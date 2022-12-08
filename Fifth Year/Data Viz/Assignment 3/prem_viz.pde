// TO DO: 
// - Sort scalling in left bottom quadrant.
// - Add button and perhas do by game etc for top left 
// - Add animation and graph to left top
// - Add entire left bottom

// Images
PImage soccerBall;

// Tables
Table playerStats;
int[] playerAges;
int[] playerYellowCards;
int[] playerRedCards;
int[] playerGoals;
int[] playerAssists;
int[] matchesPlayed;
int[] minsPlayed;
String[] playerNames;
String[] matchDates;
String[] homeTeam;
String[] awayTeam;
String[] result;
HashMap<String, int[]> teamTableStats;
HashMap<String, int[]> tempTable;


// Paddings, helper, scalers
int padding = 15;
int soccerBallMarkerSize = 15;

// Constants
final int MIN_AGE = 17; // youngest age is actually 15 but the 15 and 16 yo didnt contribute much in terms of stats 
final int MAX_AGE = 39;
final int MAX_GOALS = 23;
final int MIN_GOALS = 0;
final int MAX_ASSISTS = 13;
final int MIN_ASSISTS = 0;
final int MAX_YCARDS = 11;
final int MIN_YCARDS = 0;
final int MAX_YCARDS_BY_AGE = 156;
final int MIN_YCARDS_BY_AGE = 0;
final int YELLOW_CARD_INDEX = 0;
final int RED_CARD_INDEX = 1;
final color BUTTON_COLOR = #C0C0C0;
final color HOVER_COLOR = #808080;
final color PLAY_BUTTON = #FF0000;
final color PLAY_HOVER = #A30000;
final String GAME = "GAME";
final String MIN = "MIN";
final String TOTAL = "TOTAL";
final float MAX_YCARDS_PER_MIN = 0.12535983;
final float MIN_YCARDS_PER_MIN = 0.0;
final int MAX_YCARDS_PER_GAME = 6;
final int MIN_YCARDS_PER_GAME = 0;
final int POS_INDEX = 0;
final int PLAYED_INDEX = 1;
final int WON_INDEX = 2;
final int DREW_INDEX = 3;
final int LOST_INDEX = 4;
final int GF_INDEX = 5;
final int GA_INDEX = 6;
final int GD_INDEX = 7;
final int POINTS_INDEX = 8;
final int TABLE = 1;
final int GRAPH = -1;

// Objects

// Global Variables
int xMin;
int xMax;
int yMin;
int yMax;
int minimizer = 4;
int minimizerDisplayX;
int minimizerDisplayY;
int minimizerDisplayWidth;
int minimizerDisplayHeight;
int minimizerIncreaseButtonX;
int minimizerIncreaseButtonY;
int minimizerIncreaseButtonWidth;
int minimizerIncreaseButtonHeight;
boolean overMinimizerIncreaseButton;
boolean overMinimizerDecreaseButton;
int minimizerDecreaseButtonX;
int minimizerDecreaseButtonY;
int minimizerDecreaseButtonWidth;
int minimizerDecreaseButtonHeight;
boolean overTotalButton;
boolean overPerMinButton;
boolean overPerGameButton;
int buttonBoxX;
int buttonBoxY;
int buttonBoxWidth;
int buttonBoxHeight;
int buttonPadding;
int perTotalBoxX;
int perTotalBoxY;
int perTotalBoxWidth;
int perTotalBoxHeight;
int perMinBoxX;
int perMinBoxY;
int perMinBoxWidth;
int perMinBoxHeight;
int perGameBoxX;
int perGameBoxY;
int perGameBoxWidth;
int perGameBoxHeight;
color perTotalButtonColor;
color perMinButtonColor;
color perGameButtonColor;
String disipleSelected;
int vizType;
int tableGraphButtonX;
int tableGraphButtonY;
int tableGraphButtonWidth;
int tableGraphButtonHeight;
boolean overTableGraphButton;
int playButtonX;
int playButtonY;
int playButtonDiameter;
boolean overPlayButton;
boolean play;
color playButtonColor;
int interval = 100;
int lastRecordedTime = 0;
boolean pause = false;
int resultIndex;


// Functions
int[] getDataInt(String tableName, String columnName){
  Table table = loadTable(tableName, "header, csv");
  int[] data = new int[table.getRowCount()];
  int index = 0;
  for (TableRow row : table.rows()){
    data[index] = row.getInt(columnName);
    index++;
  }
  return data;
}

String[] getDataString(String tableName, String columnName){
  Table table = loadTable(tableName, "header, csv");
  String[] data = new String[table.getRowCount()];
  int index = 0;
  for (TableRow row : table.rows() ){
    data[index] = row.getString(columnName);
    index++;
  }
  return data;
}

int convert(int oldVal, int oldMax, int oldMin, int newMax, int newMin){
    int OldRange = (oldMax - oldMin);
    int NewRange = (newMax - newMin);
    return(((oldVal - oldMin) * NewRange) / OldRange) + newMin;
}

float convert(float oldVal, float oldMax, float oldMin, float newMax, float newMin){
    float OldRange = (oldMax - oldMin);
    float NewRange = (newMax - newMin);
    return(((oldVal - (oldMin)) * NewRange) / OldRange) + (newMin);
}

boolean overButton(int x, int y, int width, int height){
  return (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height);
}

boolean overCircleButton(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

void update(){
  if(overButton(minimizerIncreaseButtonX, minimizerIncreaseButtonY, minimizerIncreaseButtonWidth, minimizerIncreaseButtonHeight)){
    overMinimizerIncreaseButton = true;
  }else{
    overMinimizerIncreaseButton = false;
  }

  if(overButton(minimizerDecreaseButtonX, minimizerDecreaseButtonY, minimizerDecreaseButtonWidth, minimizerDecreaseButtonHeight)){
    overMinimizerDecreaseButton = true;
  }else{
    overMinimizerDecreaseButton = false;
  }

  if(overButton(perTotalBoxX, perTotalBoxY, perTotalBoxWidth, perTotalBoxHeight)){
    overTotalButton = true;
    perTotalButtonColor = HOVER_COLOR;
  }else{
    overTotalButton = false;
    if(disipleSelected != TOTAL){
      perTotalButtonColor = BUTTON_COLOR;
    }
  }

  if(overButton(perGameBoxX, perGameBoxY, perGameBoxWidth, perGameBoxHeight)){
    overPerGameButton = true;
    perGameButtonColor = HOVER_COLOR;
  }else{
    overPerGameButton = false;
    if(disipleSelected != GAME){
      perGameButtonColor = BUTTON_COLOR;
    }
  }

  if(overButton(perMinBoxX, perMinBoxY, perMinBoxWidth, perMinBoxHeight)){
    overPerMinButton = true;
    perMinButtonColor = HOVER_COLOR;
  }else{
    overPerMinButton = false;
    if(disipleSelected != MIN){
      perMinButtonColor = BUTTON_COLOR;
    }
  }

  if(overButton(tableGraphButtonX, tableGraphButtonY, tableGraphButtonWidth, tableGraphButtonHeight)){
    overTableGraphButton = true;
  }else{
    overTableGraphButton = false;
  }

  if(overCircleButton(playButtonX, playButtonY, playButtonDiameter)){
    overPlayButton = true;
    playButtonColor = PLAY_HOVER;
  }else{
    overPlayButton = false;
    playButtonColor = PLAY_BUTTON;
  }
}

void mousePressed(){
  if(overMinimizerIncreaseButton && minimizer<min(MAX_GOALS, MAX_ASSISTS)-1){
    minimizer++;
  }

  if(overMinimizerDecreaseButton && minimizer>MIN_GOALS){
    minimizer--;
  }

  if(overPerGameButton){
    disipleSelected = GAME;
  }

  if(overPerMinButton){
    disipleSelected = MIN;
  }

  if(overTotalButton){
    disipleSelected = TOTAL;
  }

  if(overTableGraphButton){
    vizType*=-1;
  }

  if(overPlayButton){
    play = true;
  }
}

void updateArray(float[][] array, int row, int col, float increment){
  array[row][col] = array[row][col] + increment;
}

void numberAxis(float maxVal, float minVal, float axisMax, float axisMin, float xPos, float yPos, float multiple){
  for(float i = 0; i<=maxVal; i=i+multiple){
    float step = (axisMax-axisMin)/(maxVal-minVal);
    fill(0);
    textAlign(RIGHT);
    textSize(15);
    if(i%1==0){
      text(int(i), xPos-5, yPos+i*step);
    }else{
      text(i, xPos-5, yPos+i*step);
    }
  }
}

void plotCardData(float[][] cardData, float max, float min, int yMax, int yMin){
  for(int index = 0; index<cardData.length; index++){
    int step = (xMax-xMin)/(MAX_AGE-MIN_AGE);
    float barYellowY = convert(cardData[index][YELLOW_CARD_INDEX],  max, min, yMax, yMin);
    float barRedY = convert(cardData[index][RED_CARD_INDEX],  max, min, yMax, yMin);
    fill(#FFFF00);
    strokeWeight(3);
    rect(xMin+(index)*step, barYellowY, step/3, yMin-barYellowY);
    fill(#FF0000);
    rect(xMin+(index)*(step)+step/3, barRedY, step/3, yMin-barRedY);  
  }
}

void drawTable(HashMap<String, int[]> tableData){
  int tableX = width/2+2*padding;
  int tableY = 4*padding;
  int tableWidth = width/4-4*padding;
  int tableHeight = height/2-6*padding;
  int headerHeight = 20;

  fill(#C0C0C0);
  stroke(0);
  fill(#5A5A5A);
  rect(tableX, tableY-headerHeight, tableWidth, headerHeight);
  for(String team : tableData.keySet()){
    int[] stats = tableData.get(team);
    int pos = stats[POS_INDEX];
    int played = stats[PLAYED_INDEX];
    int won = stats[WON_INDEX];
    int drew = stats[DREW_INDEX];
    int lost = stats[LOST_INDEX];
    int goalsFor = stats[GF_INDEX];
    int goalsAgainst = stats[GA_INDEX];
    int goalDiff = stats[GD_INDEX];
    int points = stats[POINTS_INDEX];

    strokeWeight(2);
    fill(#C0C0C0);
    float rowHeight = tableHeight/tableData.size();
    rect(tableX, tableY+(pos-1)*rowHeight, tableWidth, rowHeight);
    fill(0);
    textSize(15);
    textAlign(RIGHT);
    text(pos, tableX+17, tableY+(pos-1)*rowHeight+15);
    textAlign(LEFT);
    text(team, tableX+37, tableY+(pos-1)*rowHeight+15);
    textAlign(CENTER);
    int statsX = tableX+220;
    int spacing = 26;
    text(played, statsX, tableY+(pos-1)*rowHeight+15);
    text(won, statsX+spacing, tableY+(pos-1)*rowHeight+15);
    text(drew, statsX+2*spacing, tableY+(pos-1)*rowHeight+15);
    text(lost, statsX+3*spacing, tableY+(pos-1)*rowHeight+15);
    text(goalsFor, statsX+4*spacing, tableY+(pos-1)*rowHeight+15);
    text(goalsAgainst, statsX+5*spacing, tableY+(pos-1)*rowHeight+15);
    text(goalDiff, statsX+6*spacing, tableY+(pos-1)*rowHeight+15);
    text(points, statsX+7*spacing, tableY+(pos-1)*rowHeight+15);
  }
}

void showResults(){
  textSize(45);
    textAlign(LEFT);
    text("RESULTS", 6*width/8, 5*padding);
    line(6*width/8, 5*padding+5, 6*width/8+170, 5*padding+5);
    
    // Iterate if timer ticks
    if (millis()-lastRecordedTime>interval) {
      if (!pause) {
        iteration();
        lastRecordedTime = millis();
      }
    }
}

void updateTable(HashMap<String, int[]> tableData, String homeTeam, String result, String awayTeam){
  int[] homeTeamStats = tableData.get(homeTeam);
  int[] awayTeamStats = tableData.get(awayTeam);
  String[] goals = split(result, ':');
  int homeTeamGoals = Integer.valueOf(goals[0]);
  int awayTeamGoals = Integer.valueOf(goals[1]);

  if(homeTeamGoals>awayTeamGoals){
    homeTeamStats[POINTS_INDEX]+=3;
    homeTeamStats[WON_INDEX]+=1;
    awayTeamStats[LOST_INDEX]+=1;
  }else if(homeTeamGoals<awayTeamGoals){
    awayTeamStats[POINTS_INDEX]+=3;
    awayTeamStats[WON_INDEX]+=1;
    homeTeamStats[LOST_INDEX]+=1;
  }else{
    homeTeamStats[POINTS_INDEX]+=1;
    awayTeamStats[POINTS_INDEX]+=1;
    homeTeamStats[DREW_INDEX]+=1;
    awayTeamStats[DREW_INDEX]+=1;
  }

  homeTeamStats[PLAYED_INDEX]+=1;
  awayTeamStats[PLAYED_INDEX]+=1;
  homeTeamStats[GF_INDEX]+=homeTeamGoals;
  awayTeamStats[GF_INDEX]+=awayTeamGoals;
  homeTeamStats[GA_INDEX]+=awayTeamGoals;
  awayTeamStats[GA_INDEX]+=homeTeamGoals;
  homeTeamStats[GD_INDEX]+=(homeTeamGoals-awayTeamGoals);
  awayTeamStats[GD_INDEX]+=(awayTeamGoals-homeTeamGoals);

  reorderTable(tableData);

}

void reorderTable(HashMap<String, int[]> tableData){
  HashMap<String, int[]> temp = new HashMap<String, int[]>();
  ArrayList<String> teamsList = new ArrayList<String>();
  for(String team : tableData.keySet()){
    teamsList.add(team);
  }
  
  
  for(int posForGrabs = 1; posForGrabs<=20; posForGrabs++){
    int maxPoints = 0;
    String topTeam = "";
    for(String team : teamsList){
      if(tableData.get(team)[POINTS_INDEX]>=maxPoints){
        maxPoints = tableData.get(team)[POINTS_INDEX];
        topTeam = team;

      }
    }
    int[] topTeamStats = tableData.get(topTeam);
    topTeamStats[POS_INDEX] = posForGrabs;
    temp.put(topTeam, topTeamStats);
    teamsList.remove(topTeam);
  }

}

void iteration(){
  updateTable(tempTable, homeTeam[resultIndex], result[resultIndex], awayTeam[resultIndex]);
  drawTable(tempTable);
  textSize(35);
  textAlign(LEFT);
  text("Match Date: "+matchDates[resultIndex], 6*width/8, padding*8);
  textSize(25);
  text("HOME TEAM   RESULT   AWAY TEAM", 6*width/8, padding*10);
  textSize(20);
  text(homeTeam[resultIndex] +" "+ result[resultIndex] +" "+ awayTeam[resultIndex], 6*width/8, padding*12);
  resultIndex++;
}

void setup(){
  size(1900,970);
  frameRate(10);
  ellipseMode(CENTER); 
  soccerBall = loadImage("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\soccerball.jpg");
  
  playerAges = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "Age");
  playerYellowCards = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "CrdY");
  playerRedCards = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "CrdR");
  playerGoals = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "GOALS");
  playerAssists = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "ASSISTS");
  playerNames = getDataString("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "Player");
  matchesPlayed = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "MP");
  minsPlayed = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "Min");

  String[] teams = getDataString("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\final_table.csv", "Team");
  int[] pos = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\final_table.csv", "Pos");
  int[] played = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\final_table.csv", "Pld");
  int[] won = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\final_table.csv", "W");
  int[] drew = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\final_table.csv", "D");
  int[] lost = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\final_table.csv", "L");
  int[] goalDiff = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\final_table.csv", "GD");
  int[] goalsFor = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\final_table.csv", "GF");
  int[] goalsAgainst = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\final_table.csv", "GA");
  int[] points = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\final_table.csv", "Pts");

  matchDates = getDataString("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\premier_league_match_results.csv", "Date");
  homeTeam = getDataString("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\premier_league_match_results.csv", "HomeTeam");
  awayTeam = getDataString("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\premier_league_match_results.csv", "AwayTeam");
  result = getDataString("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\premier_league_match_results.csv", "Result");

  teamTableStats = new HashMap<String, int[]>();
  for(int index=0; index<teams.length; index++){
    int[] finalStats = {pos[index], played[index], won[index], drew[index], lost[index], goalsFor[index], goalsAgainst[index], goalDiff[index], points[index]};
    teamTableStats.put(teams[index], finalStats);
  }

  String[] startingOrder = sort(teams);
  tempTable = new HashMap<String, int[]>();
  for(int index = 0; index<startingOrder.length; index++){
    int[] initialStats = {index+1,0,0,0,0,0,0,0,0};
    tempTable.put(startingOrder[index], initialStats);
  }

  xMin = 4*padding;
  xMax = width/2-8*padding;
  yMin = height/2-4*padding;
  yMax = 4*padding;
  
  minimizerDisplayX = xMax+3*padding-10;
  minimizerDisplayY = yMax+3*padding;
  minimizerDisplayWidth = 60;
  minimizerDisplayHeight = 60;
  minimizerIncreaseButtonX = minimizerDisplayX;
  minimizerIncreaseButtonY = minimizerDisplayY-20;
  minimizerIncreaseButtonWidth = minimizerDisplayWidth;
  minimizerIncreaseButtonHeight = 20;
  minimizerDecreaseButtonX = minimizerDisplayX;
  minimizerDecreaseButtonY = minimizerDisplayY + minimizerDisplayHeight;
  minimizerDecreaseButtonWidth = minimizerDisplayWidth;
  minimizerDecreaseButtonHeight = 20;

  overMinimizerIncreaseButton = false;
  overMinimizerDecreaseButton = false;

  overTotalButton = overPerMinButton = overPerGameButton = false;

  buttonBoxX=xMax-4*padding;
  buttonBoxY=height/2+2*padding;
  buttonBoxWidth=width/2-2*padding-(buttonBoxX);
  buttonBoxHeight=75;
  buttonPadding = 2;
  perTotalBoxX = buttonBoxX + buttonPadding;
  perTotalBoxY = buttonBoxY + buttonPadding;
  perTotalBoxWidth = buttonBoxWidth - 2*buttonPadding;
  perTotalBoxHeight = (buttonBoxHeight-2*buttonPadding)/3;
  perMinBoxX = buttonBoxX + buttonPadding;
  perMinBoxY = buttonBoxY + buttonPadding + perTotalBoxHeight;
  perMinBoxWidth = buttonBoxWidth - 2*buttonPadding;
  perMinBoxHeight = (buttonBoxHeight-2*buttonPadding)/3;
  perGameBoxX = buttonBoxX + buttonPadding;
  perGameBoxY = buttonBoxY + buttonPadding + perTotalBoxHeight + perMinBoxHeight;
  perGameBoxWidth = buttonBoxWidth - 2*buttonPadding;
  perGameBoxHeight = (buttonBoxHeight-2*buttonPadding)/3;

  perGameButtonColor = perMinButtonColor = #C0C0C0;
  perTotalButtonColor = #808080;

  disipleSelected = TOTAL;

  vizType = TABLE;

  tableGraphButtonX = width-8*padding;
  tableGraphButtonY = 2*padding;
  tableGraphButtonWidth = 70;
  tableGraphButtonHeight = 30;
  playButtonDiameter = 50;
  playButtonX = tableGraphButtonX+tableGraphButtonWidth/2;
  playButtonY = tableGraphButtonY+tableGraphButtonHeight+playButtonDiameter/2+padding;
  
  overTableGraphButton = false;
  playButtonColor = PLAY_BUTTON;
  overPlayButton = false;
  play = false;

  resultIndex = 0;

}



void draw(){
  background(#3d195b);
  update();
  
  // Splitting the convas up into 4
  strokeWeight(2);
  stroke(#35ca52);
  line(width/2, 0, width/2, height); 
  line(0, height/2, width, height/2);
  
  ////////////////////////////////////////////////////
  // Top left quadrant: Goals and assist per player.//
  ////////////////////////////////////////////////////
  fill(255);
  strokeWeight(3);
  rect(padding, padding, width/2-2*padding, height/2-2*padding);
  fill(0);
  
  // Labelling axes 
  textSize(30);
  textAlign(LEFT);
  text("Goals and Assists Per Match 2021-22", width/4-300, 4*padding); 
  textSize(25);
  textAlign(LEFT);
  text("Goals", width/4-100, height/2-padding-5); 

  pushMatrix();
  float angle1 = radians(-90);
  translate(2*padding+5, height/4);
  rotate(angle1);
  textAlign(LEFT);
  text("Assists", 0, 0);
  popMatrix();
  
  stroke(0);
  strokeWeight(5);
  line(xMin, yMin, xMax, yMin);
  line(xMin, yMin, xMin, yMax);
  
  // Numbering axes
  for(int i = minimizer; i<=MAX_GOALS; i++){
    int step = (xMax-xMin)/(MAX_GOALS-minimizer);
    fill(0);
    textSize(12);
    textAlign(LEFT);
    text(i, xMin+(i-minimizer)*step, yMin+15);
  }
  
  for(int i = minimizer; i<=MAX_ASSISTS; i++){
    int step = (yMax-yMin)/(MAX_ASSISTS-minimizer);
    fill(0);
    textAlign(LEFT);
    text(i, xMin-15, yMin+(i-minimizer)*step);
  }
  
  // Adding slider 
  strokeWeight(1);
  fill(255);
  rect(minimizerDisplayX, minimizerDisplayY, minimizerDisplayWidth, minimizerDisplayHeight);
  fill(0);
  textSize(45);
  textAlign(LEFT);
  text(minimizer, minimizerDisplayX+17, minimizerDisplayY+45);
  fill(#C0C0C0);
  rect(minimizerIncreaseButtonX, minimizerIncreaseButtonY, minimizerIncreaseButtonWidth, minimizerIncreaseButtonHeight, 5, 5, 0, 0);
  rect(minimizerDecreaseButtonX, minimizerDecreaseButtonY, minimizerDecreaseButtonWidth, minimizerDecreaseButtonHeight, 0, 0, 5, 5);
  triangle(minimizerIncreaseButtonX+minimizerIncreaseButtonWidth/2, minimizerIncreaseButtonY+5, 
  minimizerIncreaseButtonX+minimizerIncreaseButtonWidth/2-10, minimizerIncreaseButtonY+15, minimizerIncreaseButtonX+minimizerIncreaseButtonWidth/2+10, 
  minimizerIncreaseButtonY+15);
  triangle(minimizerDecreaseButtonX+minimizerDecreaseButtonWidth/2, minimizerDecreaseButtonY+15, 
  minimizerDecreaseButtonX+minimizerDecreaseButtonWidth/2-10, minimizerDecreaseButtonY+5, minimizerDecreaseButtonX+minimizerDecreaseButtonWidth/2+10, 
  minimizerDecreaseButtonY+5);

  
  // Adding football markers 
  strokeWeight(3);
  for (int index=0; index< playerAges.length; index++){
    if(playerGoals[index]>minimizer && playerAssists[index]>minimizer){
      fill(0);
      int markerX = convert(playerGoals[index], MAX_GOALS, minimizer, xMax, xMin )-5;
      int markerY = convert(playerAssists[index], MAX_ASSISTS, minimizer, yMax , yMin );
      image(soccerBall, markerX, markerY, soccerBallMarkerSize, soccerBallMarkerSize);
      
      if(mouseX >= markerX && mouseX <= markerX+soccerBallMarkerSize && mouseY >= markerY && mouseY <= markerY+soccerBallMarkerSize){
        fill(#C0C0C0);
        strokeWeight(1);
        rect(mouseX, mouseY, 100, 50);
        fill(0);
        textSize(12);
        textAlign(LEFT);
        text(playerNames[index], mouseX+padding, mouseY+padding);
        text("GOALS: "+playerGoals[index], mouseX+padding, mouseY+2*padding);
        text("ASSISTS: "+playerAssists[index], mouseX+padding, mouseY+3*padding);
      }
    }
  }
  

  //////////////////////////////////////
  // Bottom left quadrant: Discipline.//
  //////////////////////////////////////
  fill(255);
  stroke(#35ca52);
  strokeWeight(3);
  rect(padding, height/2+padding, width/2-2*padding, height/2-2*padding);
  fill(0);
  textSize(30);
  text("Yellow/Red Cards per Age by "+disipleSelected, width/9, height/2+3*padding);
  textSize(20);
  text("Age", width/5, height-2*padding);
  
  int yMin2 = height-4*padding;
  int yMax2 = height/2+4*padding;
  
  stroke(0);
  strokeWeight(5);
  line(xMin, yMin2, xMax, yMin2);
  line(xMin, yMin2, xMin, yMax2);

  // Buttons
  fill(#000000);
  rect(buttonBoxX, buttonBoxY, buttonBoxWidth, buttonBoxHeight);
  fill(perTotalButtonColor);
  rect(perTotalBoxX, perTotalBoxY, perTotalBoxWidth, perTotalBoxHeight);
  textSize(15);
  fill(0);
  text("TOTAL", perTotalBoxX + 50, perTotalBoxY + 15);
  fill(perMinButtonColor);
  rect(perMinBoxX, perMinBoxY, perMinBoxWidth, perMinBoxHeight);
  textSize(15);
  fill(0);
  text("PER MIN", perMinBoxX + 50, perMinBoxY + 15);
  fill(perGameButtonColor);
  rect(perGameBoxX, perGameBoxY, perGameBoxWidth, perGameBoxHeight);
  textSize(15);
  fill(0);
  text("PER GAME", perGameBoxX + 50, perGameBoxY + 15);

  // Plotting legend 
  strokeWeight(3);
  fill(#FFFF00);
  rect(perGameBoxX, perGameBoxY+60, 15, 15);
  fill(#FF0000);
  rect(perGameBoxX, perGameBoxY+80, 15, 15);
  fill(0);
  text(" - Yellow Cards", perGameBoxX+20, perGameBoxY+75);
  text(" - Red Cards", perGameBoxX+20, perGameBoxY+95);

  // Numbering axes
  for(int i = MIN_AGE; i<=MAX_AGE; i++){
    int step = (xMax-xMin)/(MAX_AGE-MIN_AGE);
    fill(0);
    textSize(15);
    textAlign(LEFT);
    text(i, xMin+(i-MIN_AGE)*step+3, yMin2+15);
  }
  
  // Collecting data (Could possibly be redone if time)
  float[][] totalCardsByAge = new float[MAX_AGE-MIN_AGE+1][2];
  float[][] cardsPerMinByAge = new float[MAX_AGE-MIN_AGE+1][2];
  float[][] cardsPerGameByAge = new float[MAX_AGE-MIN_AGE+1][2];
  for(int index=0; index<playerYellowCards.length; index++){
    updateArray(totalCardsByAge, playerAges[index]-MIN_AGE, YELLOW_CARD_INDEX, float(playerYellowCards[index]));
    updateArray(totalCardsByAge, playerAges[index]-MIN_AGE, RED_CARD_INDEX, float(playerRedCards[index]));

    if(minsPlayed[index]!=0 && playerYellowCards[index]!=0){
      updateArray(cardsPerMinByAge, playerAges[index]-MIN_AGE, YELLOW_CARD_INDEX, float(playerYellowCards[index])/float(minsPlayed[index]));
      updateArray(cardsPerMinByAge, playerAges[index]-MIN_AGE, RED_CARD_INDEX, float(playerRedCards[index])/float(minsPlayed[index]));
    }

    if(matchesPlayed[index]!=0 && playerYellowCards[index]!=0){
      updateArray(cardsPerGameByAge, playerAges[index]-MIN_AGE, YELLOW_CARD_INDEX, float(playerYellowCards[index])/float(matchesPlayed[index]));
      updateArray(cardsPerGameByAge, playerAges[index]-MIN_AGE, RED_CARD_INDEX, float(playerRedCards[index])/float(matchesPlayed[index]));
    }
  }

  // Plotting data 
  if(disipleSelected==TOTAL){
    numberAxis(MAX_YCARDS_BY_AGE, MIN_YCARDS_BY_AGE, yMax2, yMin2, xMin, yMin2, 12);
    plotCardData(totalCardsByAge, MAX_YCARDS_BY_AGE, MIN_YCARDS_BY_AGE, yMax2, yMin2);
  }else if(disipleSelected==MIN){
    numberAxis(MAX_YCARDS_PER_MIN, MIN_YCARDS_PER_MIN, yMax2, yMin2, xMin, yMin2, 0.01);
    plotCardData(cardsPerMinByAge, MAX_YCARDS_PER_MIN, MIN_YCARDS_PER_MIN, yMax2, yMin2);
  }else{
    numberAxis(MAX_YCARDS_PER_GAME, MIN_YCARDS_PER_GAME, yMax2, yMin2, xMin, yMin2, 1);
    plotCardData(cardsPerGameByAge, MAX_YCARDS_PER_GAME, MIN_YCARDS_PER_GAME, yMax2, yMin2);
  }

  

  //////////////////////////////////////////////////////
  // Top Right quadrant: Table and graph of standings.//
  //////////////////////////////////////////////////////
  fill(255);
  stroke(#35ca52);
  strokeWeight(3);
  rect(width/2+padding, padding, width/2-2*padding, height/2-2*padding);

  // Adding button
  fill(BUTTON_COLOR);
  stroke(0);
  strokeWeight(2);
  rect(tableGraphButtonX, tableGraphButtonY, tableGraphButtonWidth, tableGraphButtonHeight);
  fill(HOVER_COLOR);
  stroke(0);
  strokeWeight(1);
  int sliderX = (vizType == TABLE ? width-8*padding : width-8*padding+tableGraphButtonWidth/2);
  rect(sliderX, tableGraphButtonY, tableGraphButtonWidth/2, tableGraphButtonHeight);
  fill(playButtonColor); 
  ellipse(playButtonX, playButtonY, playButtonDiameter, playButtonDiameter);
  fill(HOVER_COLOR);
  triangle(playButtonX+playButtonDiameter/3, playButtonY, playButtonX-playButtonDiameter/4, playButtonY+playButtonDiameter/4, playButtonX-playButtonDiameter/4, playButtonY-playButtonDiameter/4);

  // Adding table
  if(vizType==TABLE){
    drawTable(teamTableStats);
    if(play && resultIndex<380){
      drawTable(tempTable);
      showResults();
    }
  }else{

  }
  
  
}
