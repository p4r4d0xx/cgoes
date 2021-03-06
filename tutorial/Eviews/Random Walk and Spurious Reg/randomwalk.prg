'/// Do-file written by Carlos Goes (andregoes@gmail.com)
'/// for use at Dr Prakash Loungani's Macroeconometrics course
'/// at Johns Hopkins SAIS

'*** This do file aims at
'**** (a) practicing time-series commands in Eviews
'**** (b) creating 15 random walk series
'**** (c) provide examples of spurious regressions

'' 1. Create your workfile
close randomwalk.wf1
wfcreate(wf=randomwalk,page=quaterly) Q 1930Q1 2013Q4			'' creates a quarterly workfile ranging from 1930Q1 to 2013Q4

'' 2. Generate 15 random walk series and one stationary series
	
for !a = 1 to 15 																		'' sets up the loop

	smpl @first @first																'' restricts the sample to the first period
	series r_!a = rnd																	'' generates a random number
	smpl @first+1 @last															''' sets the sample to t+1 to the last period
	series r_!a = r_!a(-1) + 1+(-2)*rnd											'' sets r_it = r_it-1 + [random value between -1 and +1]

next

series stationary = rnd

'' 3. Plot the series

group group1 r_1 r_2 r_3 r_4 r_5 r_6 r_7 r_8 r_9 _
     r_10  r_11 r_12 r_13 r_14  r_15 												'' creates a group (the '_' allows you to continue on the next line)
graph graph1.line(o=midnight) group1										'' creates a new graph called 'graph1'
graph1.legend -display																'' sets the legend off
graph1.addtext(t, font(18pt,+b)) "15 Random Walk Series"				'' adds the title
show graph1																			'' plots the graph

graph graph2.line(o=modern) r_1 r_2 r_3 stationary
graph2.legend -display
graph2.addtext(t, font(18pt,+b)) "Random Walk and Stationary Series"
show graph2																			

graph graph3.line(o=modern) stationary
graph3.legend -display
graph3.addtext(t, font(18pt,+b)) "Stationary Series"
show graph3																	

'' 4. Run regressions with the random series

equation eq1.ls r_1 c r_8
show eq1
equation eq2.ls r_9 c r_14
show eq2
equation eq3.ls r_4 c r_11
show eq3
equation eq4.ls r_3 c r_6
show eq4

	'*** Note that the coefficients will be statistically significant 
      '         even though the series are random

	'*** That's called a spurious regression


