library('foreign')
library('ggplot2')

# setwd("rollcall-votes/")
data.dir <- file.path("data", "dta")
data.files <- list.files(data.dir)

data.files

rollcall.data <- lapply(data.files,
  function(f) {
    read.dta(file.path(data.dir, f), convert.factors = FALSE)
  }
)

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

# Multiply the matrix by its transpose to get Senator-to-Senator tranformation,
# and calculate the Euclidan distance between each Senator.
rollcall.dist <- lapply(rollcall.simple, function(m) dist(m %*% t(m)))

# Do the multidimensional scaling
rollcall.mds <- lapply(rollcall.dist,
  function(d) as.data.frame((cmdscale(d, k = 2)) * -1)
)



# Twelfth code snippet
# Add identification information about Senators back into MDS data frames
congresses <- 102:112

for(i in 1:length(rollcall.mds)) {
  names(rollcall.mds[[i]]) <- c("x", "y")

  congress <- subset(rollcall.data[[i]], state < 99)

  congress.names <- sapply(as.character(congress$name), function(n) strsplit(n, "[, ]")[[1]][1])

  rollcall.mds[[i]] <- transform(
    rollcall.mds[[i]],
    name = congress.names,
    party = as.factor(congress$party),
    filename = data.files[[i]]
    # congress = congresses[i]
  )

}

for(i in 1:length(rollcall.mds))
{
  mds <- rollcall.mds[[i]]
  # congress <- congresses[i]
  plot.title <- paste("Roll Call Vote MDS Clustering for ", data.files[[i]], sep = "")

  # Build base plot
  mds.plot <- ggplot(mds, aes(x = x, y = y)) +
    scale_size(range = c(2, 2), guide = 'none') + scale_alpha(guide = 'none') + theme_bw() +
    theme(
      axis.ticks = element_blank(),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      panel.grid.major = element_blank()
    ) + ggtitle(plot.title) + xlab("") + ylab("")

  # Build up point and text plots separately
  mds.point <- mds.plot + geom_point(aes(color = party, alpha = 0.75, size = 2))
  mds.text <- mds.plot + geom_text(aes(color = party, alpha = 0.75, label = mds$name, size = 2))

  # Fix labels, shapes and colors
  if(length(levels(mds$party)) > 2) {

    mds.point <- mds.point + scale_color_manual(
      name = "Party",
      values = c("100" = "blue", "200" = "red", "328" = "green"),
      breaks = c("100", "200", "328"),
      labels = c("Dem.", "Rep.", "Ind.")
    )

    mds.text <- mds.text + scale_color_manual(
      name = "Party",
      values = c("100" = "blue", "200" = "red", "328" = "green"),
      breaks = c("100", "200", "328"),
      labels = c("Dem.", "Rep.", "Ind.")
    )

  }
  else {

    mds.point <- mds.point + scale_color_manual(
      name = "Party",
      values = c("100" = "blue", "200" = "red"),
      breaks = c("100", "200"),
      labels = c("Dem.", "Rep.")
    )

    mds.text <- mds.text + scale_color_manual(
      name = "Party",
      values = c("100" = "blue", "200" = "red"),
      breaks = c("100", "200"),
      labels = c("Dem.", "Rep.")
    )
  }

  ggsave(
    plot = mds.point,
    filename = file.path(
      'figures', paste(data.files[[i]], "_point.pdf", sep = "")
    ),
    width = 8,
    height = 5
  )

  ggsave(
    plot = mds.text,
    filename = file.path(
      'figures', paste(data.files[[i]], "_names.pdf", sep = "")
    ),
    width = 8,
    height = 5
  )

}
