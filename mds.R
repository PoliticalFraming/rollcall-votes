library('foreign')
library('ggplot2')

setwd("rollcall-votes/")
data.dir <- file.path("data", "dta")
data.files <- list.files(data.dir)

data.files

# Eighth code snippet
# Add all roll call vote data frames to a single list
rollcall.data <- lapply(data.files,
                        function(f)
                        {
                          read.dta(file.path(data.dir, f), convert.factors = FALSE)
                        })

# Ninth code snippet
# dim(rollcall.data[[1]])
#[1] 103 647

head(rollcall.data[[1]])
#cong id state dist lstate party eh1 eh2 name V1 V2 V3 ... V638
#1 101 99908 99 0 USA 200 0 0 BUSH 1 1 1 ... 1
#2 101 14659 41 0 ALABAMA 100 0 1 SHELBY, RIC 1 1 1 ... 6
#3 101 14705 41 0 ALABAMA 100 0 1 HEFLIN, HOW 1 1 1 ... 6
#4 101 12109 81 0 ALASKA 200 0 1 STEVENS, TH 1 1 1 ... 1
#5 101 14907 81 0 ALASKA 200 0 1 MURKOWSKI, 1 1 1 ... 6
#6 101 14502 61 0 ARIZONA 100 0 1 DECONCINI, 1 1 1 ... 6

# Tenth code snippet
# This function takes a single data frame of roll call votes and returns a
# Senator-by-vote matrix.
rollcall.simplified <- function(df)
{
  no.pres <- subset(df, state < 99)

  for(i in 10:ncol(no.pres))
  {
    no.pres[,i] <- ifelse(no.pres[,i] > 6, 0, no.pres[,i])
    no.pres[,i] <- ifelse(no.pres[,i] > 0 & no.pres[,i] < 4, 1, no.pres[,i])
    no.pres[,i] <- ifelse(no.pres[,i] > 1, -1, no.pres[,i])
  }

  return(as.matrix(no.pres[,10:ncol(no.pres)]))
}

rollcall.simple <- lapply(rollcall.data, rollcall.simplified)

# Eleventh code snippet
# Multiply the matrix by its transpose to get Senator-to-Senator tranformation,
# and calculate the Euclidan distance between each Senator.
rollcall.dist <- lapply(rollcall.simple, function(m) dist(m %*% t(m)))

# Do the multidimensional scaling
rollcall.mds <- lapply(rollcall.dist,
                       function(d) as.data.frame((cmdscale(d, k = 2)) * -1))

# Twelfth code snippet
# Add identification information about Senators back into MDS data frames
congresses <- 101:111

for(i in 1:length(rollcall.mds))
{
  names(rollcall.mds[[i]]) <- c("x", "y")

  congress <- subset(rollcall.data[[i]], state < 99)

  congress.names <- sapply(as.character(congress$name),
                           function(n) strsplit(n, "[, ]")[[1]][1])

  rollcall.mds[[i]] <- transform(rollcall.mds[[i]],
                                 name = congress.names,
                                 party = as.factor(congress$party),
                                 congress = congresses[i])
}

head(rollcall.mds[[1]])

#x y name party congress
#2 -11.44068 293.0001 SHELBY 100 101
#3 283.82580 132.4369 HEFLIN 100 101
#4 885.85564 430.3451 STEVENS 200 101
#5 1714.21327 185.5262 MURKOWSKI 200 101
#6 -843.58421 220.1038 DECONCINI 100 101
#7 1594.50998 225.8166 MCCAIN 200 101

# Thirteenth code snippet
# Create a plot of just the 110th Congress
cong.110 <- rollcall.mds[[9]]

base.110 <- ggplot(cong.110, aes(x = x, y = y)) +
  scale_size(range = c(2,2), guide = 'none') +
  scale_alpha(guide = 'none') +
  theme_bw() +
  theme(axis.ticks = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        panel.grid.major = element_blank()) +
  ggtitle("Roll Call Vote MDS Clustering for 110th U.S. Senate") +
  xlab("") +
  ylab("") +
  scale_shape(name = "Party", breaks = c("100", "200", "328"),
              labels = c("Dem.", "Rep.", "Ind."), solid = FALSE) +
  scale_color_manual(name = "Party", values = c("100" = "blue",
                                                "200" = "red",
                                                "328"="green"),
                     breaks = c("100", "200", "328"),
                     labels = c("Dem.", "Rep.", "Ind."))

print(base.110 + geom_point(aes(shape = party,
                                alpha = 0.75,
                                size = 2)))
print(base.110 + geom_text(aes(color = party,
                               alpha = 0.75,
                               label = cong.110$name,
                               size = 2)))

ggsave(filename="figures/base110.pdf")

# Fourteenth code snippet
# Create a single visualization of MDS for all Congresses on a grid
all.mds <- do.call(rbind, rollcall.mds)
all.plot <- ggplot(all.mds, aes(x = x, y = y)) +
  geom_point(aes(color = as.factor(party), alpha = 0.75, size = 2)) +
  scale_size(range = c(2, 2), guide = 'none') +
  scale_alpha(guide = 'none') +
  theme_bw() +
  scale_color_manual(values = c("blue", "red", "green"), name = "Party",
                     breaks = c("100", "200", "328"),
                     labels = c("Dem.", "Rep.", "Ind.")) +
  theme(axis.ticks = element_blank(),
        axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        panel.grid.major = element_blank()) +
  ggtitle("Roll Call Vote MDS Clustering for U.S. Senate (101st - 111th Congress)") +
       xlab("") +
       ylab("") +
      facet_wrap(~ congress)

print(all.plot)
ggsave(filename="figures/all.pdf")


# This is the code omitted from the chapter.  This is used to create shnazy plots of everything!
for(i in 1:length(rollcall.mds))
{
  mds <- rollcall.mds[[i]]
  congress <- congresses[i]
  plot.title <- paste("Roll Call Vote MDS Clustering for ",
                      congress,
                      " U.S. Senate",
                      sep = "")

  # Build base plot
  mds.plot <- ggplot(mds, aes(x = x, y = y)) +
    scale_size(range = c(2, 2), guide = 'none') +
    scale_alpha(guide = 'none') +
    theme_bw() +
    theme(axis.ticks = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          panel.grid.major = element_blank()) +
    ggtitle(plot.title) +
    xlab("") +
    ylab("")

  # Build up point and text plots separately
  mds.point <- mds.plot + geom_point(aes(shape = party,
                                         alpha = 0.75,
                                         size = 2))
  mds.text <- mds.plot + geom_text(aes(color = party,
                                       alpha = 0.75,
                                       label = mds$name,
                                       size = 2))

  # Fix labels, shapes and colors
  if(length(levels(mds$party)) > 2)
  {
    mds.point <- mds.point + scale_shape(name = "Party",
                                         breaks = c("100", "200", "328"),
                                         labels = c("Dem.", "Rep.", "Ind."),
                                         solid = FALSE)
    mds.text <- mds.text + scale_color_manual(name = "Party",
                                              values = c("100" = "black",
                                                         "200" = "dimgray",
                                                         "328" = "gray"),
                                              breaks = c("100", "200", "328"),
                                              labels = c("Dem.", "Rep.", "Ind."))
  }
  else
  {
    mds.point <- mds.point + scale_shape(name = "Party",
                                         breaks = c("100", "200"),
                                         labels = c("Dem.", "Rep."),
                                         solid = FALSE)
    mds.text <- mds.text + scale_color_manual(name = "Party",
                                              values = c("100" = "black",
                                                         "200" = "dimgray"),
                                              breaks = c("100", "200"),
                                              labels = c("Dem.", "Rep."))
  }

  ggsave(plot = mds.point,
         filename = file.path('images',
                              'senate_plots',
                              paste(congress, "_point.pdf", sep = "")),
         width = 8,
         height = 5)
  ggsave(plot = mds.text,
         filename = file.path('images',
                              'senate_plots',
                              paste(congress, "_names.pdf", sep = "")),
         width = 8,
         height = 5)
}
