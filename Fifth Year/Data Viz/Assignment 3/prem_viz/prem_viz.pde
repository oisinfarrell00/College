// TO DO: 
// - Sort scalling in left bottom quadrant.
// - Add button and perhas do by game etc for top left 
// - Add animation and graph to left top
// - Add entire left bottom

// Images
PImage soccerBall;
PImage premLogoRect;
PImage premLogoCircle;
PImage premTrophy;
PImage silverMedal;
PImage bronzeMedal;
PImage manCity;
PImage liverpool;
PImage chelsea;

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
Button[] teamList1Buttons;
Button[] teamList2Buttons;
HashMap<String, ArrayList<Button>> playerButtons1;
HashMap<String, ArrayList<Button>> playerButtons2;
HashMap<String, int[]> teamTableStats;
HashMap<String, int[]> tempTable;
HashMap<String, float[]> playerStatsPieCHart;


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
final color[] PI_COLORS = {};
boolean selectedTeam1;
boolean confirmedTeam1;
boolean selectedTeam2;
boolean confirmedTeam2;

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
String[] selectedTeams;
String[] selectedPlayers;
int teamList1X;
int teamList2X;
int teamListY;
int teamListWidth;
int teamListHeight;
String overTeam1;
String overTeam2;
boolean overTeam;


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

float[] getDataFloat(String tableName, String columnName){
  Table table = loadTable(tableName, "header, csv");
  float[] data = new float[table.getRowCount()];
  int index = 0;
  for (TableRow row : table.rows() ){
    data[index] = row.getFloat(columnName);
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

  if(overCircleButton(playButtonX, playButtonY, playButtonDiameter)){
    overPlayButton = true;
    playButtonColor = PLAY_HOVER;
  }else{
    overPlayButton = false;
    playButtonColor = PLAY_BUTTON;
  }

  if(selectedTeams[0] == "UNSELECTED"){
    for(int index=0; index<teamList1Buttons.length; index++){
      teamList1Buttons[index].update();
    }
  }

  if(selectedTeams[1] == "UNSELECTED"){
    for(int index=0; index<teamList2Buttons.length; index++){
      teamList2Buttons[index].update();
    }
  }
  

  if(selectedPlayers[0] == "UNSELECTED"){
    for(String team : playerButtons1.keySet()){
      for(Button button : playerButtons1.get(team)){
        button.update();
      }
    }
  }
  
  if(selectedPlayers[1] == "UNSELECTED"){
    for(String team : playerButtons2.keySet()){
      for(Button button : playerButtons2.get(team)){
        button.update();
      }
    }
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

  if(overPlayButton){
    play = true;
  }

  if(overTeam){
    selectedTeams[0] = overTeam1;
  }

  for(int index = 0; index<teamList1Buttons.length; index++){
    if(teamList1Buttons[index].over){
      for(Button otherButtons : teamList1Buttons){
        otherButtons.selected = false;
      }
      teamList1Buttons[index].selected = true;
      selectedTeams[0] = teamList1Buttons[index].value;
      selectedTeam1 = true;
    }

    if(teamList2Buttons[index].over){
      for(Button otherButtons : teamList2Buttons){
        otherButtons.selected = false;
      }
      teamList2Buttons[index].selected = true;
      selectedTeams[1] = teamList2Buttons[index].value;
      selectedTeam2 = true;
    }
  }

  if(confirmedTeam1){
    ArrayList<Button> buttons = playerButtons1.get(selectedTeams[0]);
    for(int index = 0; index<buttons.size(); index++){
      if(buttons.get(index).over){
        for(Button otherButtons : buttons){
          otherButtons.selected = false;
        }
        buttons.get(index).selected = true;
        selectedPlayers[0] = buttons.get(index).value;
      }
    }
  }

  if(confirmedTeam2){
    ArrayList<Button> buttons = playerButtons2.get(selectedTeams[1]);
    for(int index = 0; index<buttons.size(); index++){
      if(buttons.get(index).over){
        for(Button otherButtons : buttons){
          otherButtons.selected = false;
        }
        buttons.get(index).selected = true;
        selectedPlayers[1] = buttons.get(index).value;
      }
    }
  }
  
}

void mouseReleased(){
  confirmedTeam1 = selectedTeam1;
  confirmedTeam2 = selectedTeam2;
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
  int tableY = 5*padding;
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
    fill(255);
    text("#", tableX+17, tableY-3);
    textAlign(LEFT);
    fill(0);
    text(team, tableX+37, tableY+(pos-1)*rowHeight+15);
    fill(255);
    text("Team", tableX+37, tableY-3);
    textAlign(CENTER);
    int statsX = tableX+220;
    int spacing = 26;
    // stats headers
    fill(255);
    text("PL", statsX, tableY-3);
    text("W", statsX+spacing, tableY-3);
    text("D", statsX+2*spacing, tableY-3);
    text("L", statsX+3*spacing, tableY-3);
    text("GF", statsX+4*spacing, tableY-3);
    text("GA", statsX+5*spacing, tableY-3);
    text("GD", statsX+6*spacing, tableY-3);
    text("PTs", statsX+7*spacing, tableY-3);
    // Actual Stats 
    fill(0);
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

void drawListOfTeams(HashMap<String, int[]> tableData){
  fill(255);

  if(selectedTeams[0] == "UNSELECTED") rect(teamList1X, teamListY, teamListWidth, teamListHeight);
  else drawLeftListOfPlayers(selectedTeams[0]);

  if(selectedTeams[1] == "UNSELECTED") rect(teamList2X, teamListY, teamListWidth, teamListHeight);
  else drawRightListOfPlayers(selectedTeams[1]);

  for(int index=0; index<teamList1Buttons.length; index++){
    if(selectedTeams[0] == "UNSELECTED") teamList1Buttons[index].show();
    if(selectedTeams[1] == "UNSELECTED") teamList2Buttons[index].show();
  }
  
}

void drawLeftListOfPlayers(String team){
  fill(255);

  ArrayList<Button> buttons = playerButtons1.get(team);

  if(selectedPlayers[0] == "UNSELECTED") rect(teamList1X, teamListY, teamListWidth, teamListHeight);
  else showPlayerStats(selectedPlayers[0], 0);

  for(int index=0; index<buttons.size(); index++){
    if(selectedPlayers[0] == "UNSELECTED") buttons.get(index).show();
  }
}

void drawRightListOfPlayers(String team){
  fill(255);

  ArrayList<Button> buttons = playerButtons2.get(team);

  if(selectedPlayers[1] == "UNSELECTED") rect(teamList2X, teamListY, teamListWidth, teamListHeight);
  else showPlayerStats(selectedPlayers[1], 1);

  for(int index=0; index<buttons.size(); index++){
    if(selectedPlayers[1] == "UNSELECTED") buttons.get(index).show();
  }
}

void showPlayerStats(String player, int side){
  float diameter = 300;
  float x;
  float y = 3*height/4;
  if(side==0){
    x = 6*width/8 - (diameter/2+padding);
  }else{
    x = 6*width/8 + (diameter/2+padding);
  }

  pieChart(diameter, tableData.get(team), x, y);
}

void showTeamStats(String team, HashMap<String, int[]> tableData, int side){
  
  
}

void pieChart(float diameter, int[] data, float x, float y) {
  float lastAngle = 0;
  for (int i = 0; i < data.length; i++) {
    float gray = map(i, 0, data.length, 0, 255);
    fill(gray);
    arc(x, y, diameter, diameter, lastAngle, lastAngle+radians(data[i]));
    lastAngle += radians(data[i]);
  }
}

void showResults(){
  textSize(45);
  textAlign(LEFT);
  text("RESULTS", 6*width/8, 5*padding);
  line(6*width/8, 5*padding+5, 6*width/8+170, 5*padding+5);
  textSize(35);
  textAlign(LEFT);
  text("Match Date: "+matchDates[resultIndex], 6*width/8, padding*8);
  
  float totalResultSize = (width-2*padding)-6*width/8;
  float sectionSize = totalResultSize/3;
  float startX = 6*width/8;

  textSize(15);
  textAlign(LEFT);
  text("HOME TEAM", startX, padding*10);
  line(startX+sectionSize-3, padding*9, startX+sectionSize-3, height/2-4*padding);
  textAlign(CENTER);
  text("RESULT", startX+1.5*sectionSize, padding*10);
  line(startX+2*sectionSize-3, padding*9, startX+2*sectionSize-3, height/2-4*padding);
  textAlign(LEFT);
  text("AWAY TEAM", startX+2*sectionSize, padding*10);
  for(int index = resultIndex; index>=max(0, resultIndex-15); index--){
    textAlign(LEFT);
    text(getDisplayName(homeTeam[index], sectionSize), startX, padding*(12+(resultIndex-index)));
    textAlign(CENTER);
    text(result[index], startX+1.5*sectionSize, padding*(12+(resultIndex-index)));
    textAlign(LEFT);
    text(getDisplayName(awayTeam[index], sectionSize), startX+2*sectionSize, padding*(12+(resultIndex-index)));
  }
  
  // Iterate if timer ticks
  if (millis()-lastRecordedTime>interval) {
    if (!pause) {
      iteration();
      lastRecordedTime = millis();
    }
  }
}

String getDisplayName(String name, float size){
  if(textWidth(name)<size){
    return name;
  }else{
    String[] names = split(name, " ");
    return names[0];
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
  textAlign(LEFT);
  textSize(20);
  
  resultIndex++;
}

void showStaticInfo(){
  textSize(30);
  textAlign(CENTER);
  text("Premier League Standing 2021/22", 6*width/8, 3*padding);
  int logoWidth = 140;
  int logoHeight = 80;

  int prizeHeight = 100;
  int prizeWidth = 100;

  int crestSize = 100;

  image(premLogoRect, width-padding-logoWidth-5, height/2-padding-logoHeight-5, logoWidth, logoHeight);

  int prizeY = 5*padding;

  int xSpacing = 20;
  int ySpacing = 20;

  image(premTrophy, 6*width/8-20, prizeY, prizeWidth, prizeHeight);
  image(manCity, 6*width/8 + prizeWidth + xSpacing, prizeY, crestSize, crestSize);

  image(silverMedal, 6*width/8, prizeY+prizeHeight+ySpacing, prizeWidth/2, prizeHeight);
  image(liverpool, 6*width/8 + prizeWidth + xSpacing, prizeY+prizeHeight+ySpacing, crestSize, crestSize);

  image(bronzeMedal, 6*width/8, prizeY+2*(prizeHeight+ySpacing), prizeWidth/2, prizeHeight);
  image(chelsea, 6*width/8 + prizeWidth + xSpacing, prizeY+2*(prizeHeight+ySpacing), crestSize, crestSize);

}

void setup(){
  size(1900,970);
  frameRate(10);
  ellipseMode(CENTER); 
  soccerBall = loadImage("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\soccerball.jpg");
  premLogoCircle = loadImage("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\premier_league_logo_circle.png");
  premLogoRect = loadImage("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\premier_league_logo_rect.png");
  premTrophy = loadImage("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\PL_Trophy_sticker.png");
  silverMedal = loadImage("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\silvermedal.JPG");
  bronzeMedal = loadImage("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\bronzemedal.JPG");
  manCity = loadImage("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\mancitycrest.png");
  liverpool = loadImage("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\liverpool.png");
  chelsea = loadImage("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\chelsea.png");
  
  
  playerAges = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "Age");
  playerYellowCards = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "CrdY");
  playerRedCards = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "CrdR");
  playerGoals = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "GOALS");
  playerAssists = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "ASSISTS");
  playerNames = getDataString("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "Player");
  matchesPlayed = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "MP");
  minsPlayed = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "Min");
  String[] allTeams = getDataString("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "Team");
  String[] allPlayers = getDataString("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "Player");

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
  
  minimizerDisplayX = xMax+4*padding-10;
  minimizerDisplayY = yMax+4*padding;
  minimizerDisplayWidth = 40;
  minimizerDisplayHeight = 40;
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

  playButtonDiameter = 50;
  playButtonX = width-6*padding;
  playButtonY = 4*padding;
  
  playButtonColor = PLAY_BUTTON;
  overPlayButton = false;
  play = false;

  resultIndex = 0;

  selectedTeams = new String[2];
  selectedTeams[0] = "UNSELECTED";
  selectedTeams[1] = "UNSELECTED";
  selectedPlayers = new String[2];
  selectedPlayers[0] = "UNSELECTED";
  selectedPlayers[1] = "UNSELECTED";
  teamList1X = width/2 + 8*padding;
  teamList2X = 6*width/8 + 2*padding;
  teamListY = height/2+5*padding;
  teamListWidth = 6*width/8 - 2*padding - teamList1X;
  teamListHeight = height-5*padding - teamListY;

  overTeam1 = " ";
  overTeam2 = " ";
  overTeam = false;

  teamList1Buttons = new Button[teams.length];
  teamList2Buttons = new Button[teams.length];
  float boxHeight = teamListHeight/(teams.length-1);
  for(int index = 0; index<teams.length; index++){
    teamList1Buttons[index] = new Button(teamList1X, teamListY+(boxHeight*index), teamListWidth, boxHeight, false, false, teams[index], 15);
    teamList2Buttons[index] = new Button(teamList2X, teamListY+(boxHeight*index), teamListWidth, boxHeight, false, false, teams[index], 15);
  }

  playerButtons1 = new HashMap<String, ArrayList<Button>>();
  playerButtons2 = new HashMap<String, ArrayList<Button>>();
  for(int index=0; index<teams.length; index++){
    ArrayList<Button> buttons1 = new ArrayList<Button>();
    ArrayList<Button> buttons2 = new ArrayList<Button>();
    String team = teams[index];
    int numPlayersOnTeam = 0;
    for(int i = 0; i<allTeams.length; i++){
      if(allTeams[i].equals(team)){
        numPlayersOnTeam++;
      }
    }
    
    
    boxHeight = float(teamListHeight)/float(numPlayersOnTeam);
    int posInList=0;
    for(int i = 0; i<allTeams.length; i++){
      if(allTeams[i].equals(team)){
        buttons1.add(new Button(teamList1X, teamListY+(boxHeight*posInList), teamListWidth, boxHeight, false, false, allPlayers[i], 10));
        buttons2.add(new Button(teamList2X, teamListY+(boxHeight*posInList), teamListWidth, boxHeight, false, false, allPlayers[i], 10));
        posInList++;
      }
    }
    posInList=0;

    playerButtons1.put(teams[index], buttons1);
    playerButtons2.put(teams[index], buttons2);

    numPlayersOnTeam = 0;
  }

  selectedTeam1 = false;
  confirmedTeam1 = false;
  selectedTeam2 = false;
  confirmedTeam2 = false;


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
  textAlign(CENTER);
  text(minimizer, minimizerDisplayX+minimizerDisplayWidth/2, minimizerDisplayY+minimizerDisplayHeight-5);
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
  textAlign(LEFT);
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
  stroke(0);
  strokeWeight(1);
  fill(playButtonColor); 
  ellipse(playButtonX, playButtonY, playButtonDiameter, playButtonDiameter);
  fill(HOVER_COLOR);
  triangle(playButtonX+playButtonDiameter/3, playButtonY, playButtonX-playButtonDiameter/4, playButtonY+playButtonDiameter/4, playButtonX-playButtonDiameter/4, playButtonY-playButtonDiameter/4);

  // Adding table
  drawTable(teamTableStats);
  if(play && resultIndex<380){
    drawTable(tempTable);
    showResults();
  }else{
    showStaticInfo();
  }
  
  //////////////////////////////////
  // Bottom Right quadrant: Teams.//
  //////////////////////////////////
  fill(255);
  stroke(#35ca52);
  strokeWeight(3);
  rect(width/2+padding, height/2+padding, width/2-2*padding, height/2-2*padding);


  textAlign(CENTER);
  fill(0);
  textSize(35);
  text("HEAD TO HEAD", 6*width/8, height/2+3*padding);
  stroke(0);
  line(6*width/8, height/2+5*padding, 6*width/8, height-5*padding);
  drawListOfTeams(teamTableStats);
  
}


