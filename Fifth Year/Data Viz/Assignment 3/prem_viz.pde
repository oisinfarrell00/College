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
final String GAME = "GAME";
final String MIN = "MIN";
final String TOTAL = "TOTAL";
final float MAX_YCARDS_PER_MIN = 0.12535983;
final float MIN_YCARDS_PER_MIN = 0.0;
final int MAX_YCARDS_PER_GAME = 6;
final int MIN_YCARDS_PER_GAME = 0;

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

void setup(){
  size(1900,970);
  soccerBall = loadImage("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\soccerball.jpg");
  
  playerAges = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "Age");
  playerYellowCards = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "CrdY");
  playerRedCards = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "CrdR");
  playerGoals = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "GOALS");
  playerAssists = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "ASSISTS");
  playerNames = getDataString("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "Player");
  matchesPlayed = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "MP");
  minsPlayed = getDataInt("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 3\\Football Players Stats (Premier League 2021-2022).csv", "Min");

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

  disipleSelected = "TOTAL";

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
  rect(padding, height/2+padding, width/2-2*padding, height/2-2*padding);
  fill(0);
  
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


  // Numbering axes
  if(disipleSelected==TOTAL){
    numberAxis(MAX_YCARDS_BY_AGE, MIN_YCARDS_BY_AGE, yMax2, yMin2, xMin, yMin2, 12);
  }else if(disipleSelected==GAME){
    numberAxis(MAX_YCARDS_PER_GAME, MIN_YCARDS_PER_GAME, yMax2, yMin2, xMin, yMin2, 1);
  }else{
    numberAxis(MAX_YCARDS_PER_MIN, MIN_YCARDS_PER_MIN, yMax2, yMin2, xMin, yMin2, 0.01);
  }
  

  for(int i = MIN_AGE; i<=MAX_AGE; i++){
    int step = (xMax-xMin)/(MAX_AGE-MIN_AGE);
    fill(0);
    textSize(15);
    textAlign(LEFT);
    text(i, xMin+(i-MIN_AGE)*step+3, yMin2+15);
  }
  
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
    for(int index = 0; index<totalCardsByAge.length; index++){
      int step = (xMax-xMin)/(MAX_AGE-MIN_AGE);
      float barYellowY = convert(totalCardsByAge[index][YELLOW_CARD_INDEX],  MAX_YCARDS_BY_AGE, MIN_YCARDS_BY_AGE, yMax2, yMin2);
      float barRedY = convert(totalCardsByAge[index][RED_CARD_INDEX],  MAX_YCARDS_BY_AGE, MIN_YCARDS_BY_AGE, yMax2, yMin2);
      fill(#FFFF00);
      strokeWeight(3);
      rect(xMin+(index)*step, barYellowY, step/3, yMin2-barYellowY);
      fill(#FF0000);
      rect(xMin+(index)*(step)+step/3, barRedY, step/3, yMin2-barRedY);  
    }
  }else if(disipleSelected==MIN){
    for(int index = 0; index<cardsPerMinByAge.length; index++){
      int step = (xMax-xMin)/(MAX_AGE-MIN_AGE);
      float barYellowY = convert(cardsPerMinByAge[index][YELLOW_CARD_INDEX],  MAX_YCARDS_PER_MIN, MIN_YCARDS_PER_MIN, yMax2, yMin2);
      float barRedY = convert(cardsPerMinByAge[index][RED_CARD_INDEX],  MAX_YCARDS_PER_MIN, MIN_YCARDS_PER_MIN, yMax2, yMin2);
      fill(#FFFF00);
      strokeWeight(3);
      rect(xMin+(index)*step, barYellowY, step/3, yMin2-barYellowY);
      fill(#FF0000);
      rect(xMin+(index)*(step)+step/3, barRedY, step/3, yMin2-barRedY);  
    }
  }else{
    for(int index = 0; index<cardsPerGameByAge.length; index++){
      int step = (xMax-xMin)/(MAX_AGE-MIN_AGE);
      float barYellowY = convert(cardsPerGameByAge[index][YELLOW_CARD_INDEX],  MAX_YCARDS_PER_GAME, MIN_YCARDS_PER_GAME, yMax2, yMin2);
      float barRedY = convert(cardsPerGameByAge[index][RED_CARD_INDEX],  MAX_YCARDS_PER_GAME, MIN_YCARDS_PER_GAME, yMax2, yMin2);
      println(index+MIN_AGE+": "+cardsPerGameByAge[index][YELLOW_CARD_INDEX]);
      fill(#FFFF00);
      strokeWeight(3);
      rect(xMin+(index)*step, barYellowY, step/3, yMin2-barYellowY);
      fill(#FF0000);
      rect(xMin+(index)*(step)+step/3, barRedY, step/3, yMin2-barRedY);  
    }
  }
  


  
  
}