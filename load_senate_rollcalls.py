"""
Load roll call votes for 112th Senate

Roll call votes
http://www.voteview.com/senate112.htm

Issue coded votes on bills
http://voteview.com/dw-nominate_textfile.htm

The format of the roll call files is:

 1.  Congress Number
 2.  ICPSR ID Number:  5 digit code assigned by the ICPSR as
                       corrected by Howard Rosenthal and myself.
 3.  State Code:  2 digit ICPSR State Code.
 4.  Congressional District Number (0 if Senate)
 5.  State Name
 6.  Party Code:  100 = Dem., 200 = Repub. (See PARTY3.DAT)
 7.  Occupancy:  ICPSR Occupancy Code -- 0=only occupant; 1=1st occupant; 2=2nd occupant; etc.
 8.  Last Means of Attaining Office:  ICPSR Attain-Office Code -- 1=general election;
                2=special election; 3=elected by state legislature; 5=appointed
 9.  Name
10 - to the number of roll calls + 10:  Roll Call Data --
                             0=not a member, 1=Yea, 2=Paired Yea, 3=Announced Yea,
                                             4=Announced Nay, 5=Paired Nay, 6=Nay,
                             7=Present (some Congresses, also not used some Congresses),
                             8=Present (some Congresses, also not used some Congresses),
                             9=Not Voting

example:
1114050062 0COLORAD 10011SALAZAR    111160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
"""

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

with open('data/S01_112_codes.csv', 'r') as csvfile:
	issue_coded_rollcalls_by_bill = csv.reader(csvfile)
	bill_sum_votes = []
	for row in issue_coded_rollcalls_by_bill:
		# example:
		# ['112', '486', '486', '1', '1', '0', '3', '0', '1', '1', '2013', '89', '6', '0', '2', '89', '6', '0', '2', '2', '90', '0', '0', '0', '0', '8', '0', '0', '3', 'EXTEND BUSH TAX CUTS BELOW $450K (PASS)']
		bill_sum_votes.append(row)
	bill_sum_votes = np.matrix(bill_sum_votes)		

with open('data/s112desc.csv', 'r') as csvfile:
	senate_rollcall_descriptions_112 = csv.reader(csvfile)
	header = senate_rollcall_descriptions_112.next()
	for row in senate_rollcall_descriptions_112:
		pass

with open('data/sen112kh.ord', 'r') as ordfile:
	rollcalls = ordfile.read().split('\n')
	rollcall_votes = []
	for row in rollcalls:
		rollcall_votes.append([int(c) for c in row[-487:].replace('\r','')])
	rollcall_votes = rollcall_votes[:-1] # remove trailing empty array
	rollcall_votes = np.matrix(rollcall_votes)

print bill_sum_votes

