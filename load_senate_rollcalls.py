"""
Load roll call votes for 112th Senate

Roll call votes
http://www.voteview.com/senate112.htm

Issue coded votes on bills
http://voteview.com/dw-nominate_textfile.htm
"""

#### DOCUMENTATION FOR ROLL CALL VOTES

#  1.  Congress Number
#  2.  ICPSR ID Number:  5 digit code assigned by the ICPSR as
#                        corrected by Howard Rosenthal and myself.
#  3.  State Code:  2 digit ICPSR State Code.
#  4.  Congressional District Number (0 if Senate)
#  5.  State Name
#  6.  Party Code:  100 = Dem., 200 = Repub. (See PARTY3.DAT)
#  7.  Occupancy:  ICPSR Occupancy Code -- 0=only occupant; 1=1st occupant; 2=2nd occupant; etc.
#  8.  Last Means of Attaining Office:  ICPSR Attain-Office Code -- 1=general election;
#                 2=special election; 3=elected by state legislature; 5=appointed
#  9.  Name
# 10 - to the number of roll calls + 10:  Roll Call Data --
#                              0=not a member, 1=Yea, 2=Paired Yea, 3=Announced Yea,
#                                              4=Announced Nay, 5=Paired Nay, 6=Nay,
#                              7=Present (some Congresses, also not used some Congresses),
#                              8=Present (some Congresses, also not used some Congresses),
#                              9=Not Voting

# example:
# 1114050062 0COLORAD 10011SALAZAR    111160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

# Characters in roll call vote file
# 3 - congress
# 5 - ICPSR
# 2 - state code
# 1 blank
# 1 - District  number (0 if senate)
# 7 - state name
# 1 blank
# 3 - party code
# 2 - occupancy code
# 11 - lastname
#rest is vector


#### DOCUMENTATION FOR ISSUE CODED VOTES
#  7.  Issue Code One
#  8.  Issue Code Two
#  9.  Month of Roll Call
# 10.  Day of Roll Call
# 11.  Year of Roll Call
# 20.  Number of 0's in Roll Call  (Not in Congress)
# 21.  Number of 1's in Roll Call  (YEAs)
# 22.  Number of 2's in Roll Call  (Paired YEA)
# 23.  Number of 3's in Roll Call  (Announced YEA)
# 24.  Number of 4's in Roll Call  (Announced NAY)
# 25.  Number of 5's in Roll Call  (Paired NAY)
# 26.  Number of 6's in Roll Call  (NAYs)
# 27.  Number of 7's in Roll Call  (Present -- some Congresses, also not used some Congresses)
# 28.  Number of 8's in Roll Call  (Present -- some Congresses, also not used some Congresses)
# 29.  Number of 9's in Roll Call  (Not Voting)


import csv
import numpy as np
from blessings import Terminal

t = Terminal()

with open('data/S01_112_codes.csv', 'r') as csvfile:
	issue_coded_rollcalls_by_bill = csv.reader(csvfile)
	bill_sum_votes = []
	for row in issue_coded_rollcalls_by_bill:
		# example:
		# ['112', '486', '486', '1', '1', '0', '3', '0', '1', '1', '2013', '89', '6', '0', '2', '89', '6', '0', '2', '2', '90', '0', '0', '0', '0', '8', '0', '0', '3', 'EXTEND BUSH TAX CUTS BELOW $450K (PASS)']
		bill_sum_votes.append(row)
	bill_sum_votes = np.array(bill_sum_votes)

with open('data/s112desc.csv', 'r') as csvfile:
	senate_rollcall_descriptions_112 = csv.reader(csvfile)
	header = senate_rollcall_descriptions_112.next()
	for row in senate_rollcall_descriptions_112:
		pass

with open('data/ord/sen112kh.ord', 'r') as ordfile:
	rollcalls = ordfile.read().split('\n')
	rollcall_votes = []
	for row in rollcalls:
		rollcall_votes.append([int(c) for c in row[-487:].replace('\r','')])
	rollcall_votes = rollcall_votes[:-1] # remove trailing empty array
	rollcall_votes = np.array(rollcall_votes)

print t.yellow("rollcall_votes")
print rollcall_votes
print t.yellow("bill_sum_votes")
print bill_sum_votes

issue_codes = {
	'immigration': 59,
	'abortion': 21,
	'homosexuality': 22,
	'school_prayer': 33,
	'narcotics': 81,
	'firearms': 82,
	'war_on_terror': 108
}

for congress_number in range(102, 112+1):
	congress_number = str(congress_number)

	for issue, issue_code in issue_codes.items():
		issue_code = str(issue_code)

		sum_votes_vectors = filter( lambda v: (v[7-1] == issue_code) or (v[8-1] == issue_code), bill_sum_votes )
		sum_votes_vectors = filter( lambda v: v[0] == congress_number, sum_votes_vectors)
		vote_indexes = map (lambda v: int(v[1]) - 1, sum_votes_vectors)

		x = filter(lambda tuple: (tuple[1][7-1] == issue_code) or (tuple[1][8-1] == issue_code), enumerate(bill_sum_votes))

		absolute_positions = map(lambda tuple: tuple[0], x) # absolute position of vote in issue coded vote file
		sum_votes_vectors = map(lambda tuple: tuple[1], x) # vote in issue coded vote file
		vote_indexes = map (lambda v: int(v[1]) - 1, sum_votes_vectors) # index of relevant votes in vote vector for 112th congress

		print issue + "_" + congress_number + " = " + "c(" + ", ".join(map(lambda index: "\"V" + str(index) + "\"", vote_indexes)) + ")"

#### Junk for later
# for vector in bill_sum_votes:
# 	claussen_code = vector[3-1]
# 	peltzman_code_one = vector[4-1]
# 	peltzman_code_two =vector[5-1]
# 	issue_code_one = vector[6-1]
# 	issue_code_two =vector[7-1]



