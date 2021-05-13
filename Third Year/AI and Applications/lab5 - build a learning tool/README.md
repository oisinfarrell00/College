# Lab work 5: ML - build a learning tool
## General
Build a Machine Learning program for a data set using a data mining tool called Weka. Download the tool, look at the videos to get acquainted. Then create an own data set and train the system.

### TASK:
1. Choose one of the tools below (Scikit or WEKA).
2. Download it and look at implemented examples and investigate the outcome.
3. Create your own example and test run it! Does the tool seem to work for your example?

WEKA runs in two modes. It has a GUI and a command line mode. There is a manual in the distribution that will guide you through WEKA use. Try one of the examples in the manual to learn the tool.

WEKA has several data sets or you can find data sets on the web. Try several ML techniques from WEKA on a data set. What levels of perforance do the techniques have on the chosen data set, are there differences?

The repository in the link has 351 data sets (at the time this was written). You may use one of theses as a source for your task. Data set source (Länkar till en externa sida.)

Try to Classify the Data set
Click on "Classify", Choose "DecisionTable" - click on the word "DecisionTable" (in the field) and changed displayRules = True

Example ML 3

For the example in the lecture, you will get the table showing the data:

=============================

Size       Price

=============================

'(362-inf)' 8000000.0

'(210-248]' 4500000.0

'(172-210]' 4000000.0

'(96-134]' 3000000.0

'(58-96]'   2300000.0

'(-inf-58]' 1600000.0

=============================

 

To get the production rules, choose M5 rules and click on the "M5Rules" and change unpruned to True:

Exempel ML4

For the example in the lecture, you will get:

Number of Rules : 3

Rule: 1
IF
    Size > 160
THEN
Price =
    13956.5322 * Size
    + 1749532.5494 [3/84.433%]

Rule: 2
IF
    Size <= 52.5
THEN
Price =
    15693.0592 * Size
    + 1102035.4194 [2/83.456%]

Rule: 3
Price =
    + 2650000 [2/100%]'