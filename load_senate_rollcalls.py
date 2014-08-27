"""
Load roll call votes for 112th Senate
"""

import csv

with open('S01_112_codes.csv', 'r') as csvfile:
	issue_coded_rollcalls_by_bill = csv.reader(csvfile)
	for row in issue_coded_rollcalls_by_bill:
		pass

with open('s112desc.csv', 'r') as csvfile:
	senate_rollcall_descriptions_112 = csv.reader(csvfile)
	for row in senate_rollcall_descriptions_112:
		pass

with open('sen112kh.ord', 'r') as ordfile:
	rollcalls = ordfile.read().split('\n')
	for row in rollcalls:
		pass