import java.util.Map;
import processing.pdf.*;

Table city_table;
Table temp_table;
Table army_table;

final color beige = #dcc8ad;
final color black = 0;
final color white = 255;
final color attack_dir = color (152, 118, 84);
final color retreat_dir = black;
final float text_size = 12.5;
final int first_city_long = 24;
final int first_city_lat = 55;
final int first_city_x = 50;
final int first_city_y = height/2;
final float max_x_diff = 13.6; //largest x - smallest x
final float max_y_diff = 1.9;


float convert_long_to_x(float longitude){
  return first_city_x+((width-(first_city_x+100))/max_x_diff)*(longitude-first_city_long);
}

float convert_lat_to_y(float latitude){
  return 300-(latitude-first_city_lat)*200;
}

void draw_army_path(ArrayList<float[]> army, String direction){
  for(int i=1; i<army.size();i++){
    float weight = 5+(100*(army.get(i-1)[2]/340000));
    strokeWeight(weight);
    strokeCap(SQUARE);
    if(direction == "A"){
      stroke(attack_dir);
    }else{
      stroke(retreat_dir);
    }
    
    line(army.get(i-1)[0], army.get(i-1)[1], army.get(i)[0], army.get(i)[1]);
  }
}

void setup() {
  //size(1750, 900, PDF, "Oisin Farrell - 18325543 - Assignment 1.2.pdf");
  size(1750, 900);
  background(white);
  fill(beige);
  rect(10, 10, width-20, height-20);
  
  // Title
  textSize(text_size*3);
  fill(black);
  text("Figurative Map ", 30, 60);
  textSize(text_size*2);
  text("of the successive loss in men of the French Army in the ", 265, 60);
  textSize(text_size*3);
  text("Russian Campain of 1812-1813", 830, 60);
  
  strokeWeight(3);
  line(30, 68, 1305, 68);
  
  // Legend
  textSize(text_size*2);
  strokeWeight(5);
  fill(beige);
  rect(1200, 370, 400, 175);
  fill(black);
  text("LEGEND", 1350, 395);
  fill(beige);
  rect(1200, 400, 400, 175);
  strokeWeight(2);
  fill(black);
  textSize(text_size);
  text("Scale", 1220, 430-text_size);
  line(1220, 430, 1580, 430);
  line(1220, 430, 1220, 425);
  text("0", 1220, 430+text_size);
  line(1580, 430, 1580, 425);
  text("200km", 1580-20, 430+text_size);
  line(1220+(1580-1220)/2, 430, 1220+(1580-1220)/2, 425);
  text("100", 1220+(1580-1220)/2-3, 430+text_size);
  line(1220+(1580-1220)/10, 430, 1220+(1580-1220)/10, 425);
  text("20", 1220+(1580-1220)/10-3, 430+text_size);
  line(1220+2*(1580-1220)/10, 430, 1220+(2*(1580-1220)/10), 425);
  text("40", 1220+2*(1580-1220)/10-3, 430+text_size);
  line(1220+3*(1580-1220)/10, 430, 1220+(3*(1580-1220)/10), 425);
  text("60", 1220+3*(1580-1220)/10-3, 430+text_size);
  line(1220+4*(1580-1220)/10, 430, 1220+(4*(1580-1220)/10), 425);
  text("80", 1220+4*(1580-1220)/10-3, 430+text_size);
  fill(attack_dir);
  strokeWeight(0);
  rect(1220, 460, text_size*2, text_size*2);
  textSize(text_size);
  fill(black);
  text("- Army in Attacking Direction", 1260, 460+text_size);
  fill(black);
  strokeWeight(2);
  rect(1220, 510, text_size*2, text_size*2);
  textSize(text_size);
  fill(black);
  text("- Army in Retreating Direction", 1260, 510+text_size);
  textSize(text_size);
  text("Numbers (eg 100,000) - Size of Amry", 1220, 570);
  strokeWeight(1);
  
  
  // CITY STUFF
  HashMap<String,Map<Float, Float>> city_x_y_map = new HashMap<String,Map<Float, Float>>();
  HashMap <Float, Float> xy_coordinates = new HashMap<Float, Float>();
  
  
  city_table = loadTable("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 1.2\\minard-data-cities-csv.csv", "header, csv");
  temp_table = loadTable("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 1.2\\minard-data-temp-csv.csv", "header, csv");
  army_table = loadTable("C:\\Users\\oisin\\Documents\\College\\Fifth-Year\\Data Visualisation\\Assignment 1.2\\minard-data-army-csv.csv", "header, csv");
  
  for(TableRow row: city_table.rows()){
    float longitude = row.getFloat("LONC");
    float latitude = row.getFloat("LATC");
    String cityName = row.getString("CITY");
    
    float city_x = convert_long_to_x(longitude);
    float city_y = convert_lat_to_y(latitude);
    
    xy_coordinates.put(city_x, city_y);
    city_x_y_map.put(cityName, xy_coordinates);
    
  }
  
  // TEMP STUFF
  int temp_chart_x = first_city_x;
  int temp_chart_y = height/2+100;
  
  // Drawing the y axis of temp chart 
  float final_city_x = first_city_x+(37.6-first_city_long)*((width-200)/max_x_diff);
  fill(beige);
  line(10, 75+temp_chart_y, width-10, 75+temp_chart_y);
  line(10, 75+temp_chart_y+3, width-10, 75+temp_chart_y+3);
  line(temp_chart_x+final_city_x, 150+temp_chart_y+text_size-3, 10,  150+temp_chart_y+text_size-3);
  line(temp_chart_x+final_city_x, 150+temp_chart_y+text_size-3, temp_chart_x+final_city_x,  150);
  
  for(int i=0; i<=30; i+=5){
    fill(black);
    textSize(text_size+5);
    text(i+"°C", temp_chart_x+final_city_x+3, 150+temp_chart_y+text_size+(i*5)+6);
    if(i%10==0 && i!=0){
      line(temp_chart_x+final_city_x, 150+temp_chart_y+text_size+(i*5)-3, first_city_x+(26.7-first_city_long)*((width-200)/max_x_diff),  150+temp_chart_y+text_size+(i*5)-3);
    }
  }
  
  float previous_temp_x = convert_long_to_x(37.6);;
  float previous_temp_y = 150+temp_chart_y+text_size-(0*5)-3;
  
  for(TableRow row: temp_table.rows()){
    float longitude = row.getFloat("LONT");
    int temp = row.getInt("TEMP");
    String month = row.getString("MON")==null?" ":row.getString("MON");
    String day = row.getString("DAY")==null?" ":row.getString("DAY");
    
    float text_x = convert_long_to_x(longitude);
    float text_y = 150+temp_chart_y+text_size-(temp*5)-3;
    
    fill(black);
    textSize(text_size);
    if(temp == 0 && day.equals("18")){
      textSize(text_size+3);
      text(temp + "° " + month + " " + day, text_x-58, text_y+text_size);
    }else if(temp == -26 && day.equals("7")){
      textSize(text_size+3);
      text(temp + "° " + month + " " + day, text_x, text_y+text_size+8);
    }else{
      textSize(text_size+3);
      text(temp + "° " + month + " " + day, text_x, text_y+text_size);
    }
    strokeWeight(1);
    if(temp!=0){
      int line_y = 300;
      if(temp == -9 && day.equals("9")) line_y = 350;
      if(temp == -21 && day.equals("14")) line_y = 375;
      if(temp == -11)line_y = 415;
      if(temp == -20 && day.equals("28")) line_y = 435;
      if(temp == -24 && day.equals("1")) line_y = 420;
      if(temp == -30 && day.equals("6")) line_y = 433;
      if(temp == -26 && day.equals("7")) line_y = 433;
      line(text_x, text_y, text_x, line_y);
    }
    line(previous_temp_x, previous_temp_y, text_x, text_y);
    fill(black);
    circle(text_x, text_y, 3);
    previous_temp_x = text_x;
    previous_temp_y = text_y;
  }
  
  ArrayList<float[]> army_a_1 = new ArrayList<float[]>();
  ArrayList<float[]> army_a_2 = new ArrayList<float[]>();
  ArrayList<float[]> army_a_3 = new ArrayList<float[]>();
  ArrayList<float[]> army_r_1 = new ArrayList<float[]>();
  ArrayList<float[]> army_r_2 = new ArrayList<float[]>();
  ArrayList<float[]> army_r_3 = new ArrayList<float[]>();
  for(TableRow row: army_table.rows()){
    float longitude = row.getFloat("LONP");
    float latitude = row.getFloat("LATP");
    int survival = row.getInt("SURV");
    String direction = row.getString("DIR");
    int division = row.getInt("DIV");
    
    
    //circle(convert_long_to_x(longitude), convert_lat_to_y(latitude), 5);
    int seperator = 30;
    if(division == 1 && direction.equals("A")){
      float[] info = {convert_long_to_x(longitude), convert_lat_to_y(latitude)-seperator, survival};
      army_a_1.add(info);
    }
    if(division == 2 && direction.equals("A")){
      float[] info = {convert_long_to_x(longitude), convert_lat_to_y(latitude)-seperator, survival};
      army_a_2.add(info);
    }
    if(division == 3 && direction.equals("A")){
      float[] info = {convert_long_to_x(longitude), convert_lat_to_y(latitude)-seperator, survival};
      army_a_3.add(info);
    }
    if(division == 1 && direction.equals("R")){
      float[] info = {convert_long_to_x(longitude), convert_lat_to_y(latitude), survival};
      army_r_1.add(info);
    }
    if(division == 2 && direction.equals("R")){
      float[] info = {convert_long_to_x(longitude), convert_lat_to_y(latitude), survival};
      army_r_2.add(info);
    }
    if(division == 3 && direction.equals("R")){
      float[] info = {convert_long_to_x(longitude), convert_lat_to_y(latitude)+10, survival};
      army_r_3.add(info);
    }
  }
  
  
  draw_army_path(army_r_1, "R");
  
  army_r_2.remove(army_r_2.size()-1);
  army_r_2.remove(army_r_2.size()-1);
  army_r_2.remove(army_r_2.size()-1);
  army_r_2.remove(army_r_2.size()-1);
  float[] info = {235, 425, 10000};
  army_r_2.add(info);
  float[] new_info = {175, 432, 200};
  army_r_2.add(new_info);
  float[] new_info2 = {95, 432, 14000};
  army_r_2.add(new_info2);
  float[] new_info3 = {50, 432, 14000};
  army_r_2.add(new_info3);
  draw_army_path(army_r_2, "R");
  
  army_r_3.remove(army_r_3.size()-1);
  army_r_3.remove(army_r_3.size()-1);
  army_r_3.remove(army_r_3.size()-1);
  draw_army_path(army_r_3, "R");
  
  stroke(black);
  strokeWeight(5);
  line(93, height/2-20, 100, 135);
  
  
  
  float[] final_stop = {convert_long_to_x(37.6), convert_lat_to_y(55.8), 100000};
  army_a_1.add(final_stop);
  draw_army_path(army_a_1, "A");
  
  float[] final_stop_a = {convert_long_to_x(28.7), convert_lat_to_y(55.5), 100000};
  army_a_2.add(final_stop_a);
  draw_army_path(army_a_2, "A");
  
  float[] final_stop_r = {convert_long_to_x(24.6), convert_lat_to_y(55.8), 6000};
  army_a_3.add(final_stop_r);
  draw_army_path(army_a_3, "A");
  
  
  for(TableRow row: city_table.rows()){
    float longitude = row.getFloat("LONC");
    float latitude = row.getFloat("LATC");
    String cityName = row.getString("CITY");
    
    float city_x = convert_long_to_x(longitude);
    float city_y = convert_lat_to_y(latitude);
   
    //println(cityName);
    textSize(text_size*1.2);
    fill(black);
    if(cityName.equals("Molodexno")){ 
      city_y+=15;
    }
    if(cityName.equals("Studienska")){ 
      city_y+=40;
      city_x-=10;
    }
    if(cityName.equals("Bobr")){ 
      city_y+=30;
      city_x+=10;
    }
    if(cityName.equals("Moscou")){
      textSize(text_size*4);
      city_y-=15;
      city_x-=100;
    }
    if(cityName.equals("Chjat")){
      city_y-=30;
    }
    if(cityName.equals("Malo-jarosewli")){ 
      city_y+=30;
      city_x+=10;
    }
    if(cityName.equals("Wixma")){ 
      city_y+=30;
      city_x+=10;
    }
    if(cityName.equals("Dorogobouge")){ 
      city_y-=30;
      city_x-=30;
    }
    if(cityName.equals("Tarantino")){ 
      city_x+=100;
    }
    if(cityName.equals("Studienska")){ 
      city_x-=30;
    }
    text(cityName, city_x, city_y);
  }
  
  
  pushMatrix();
  float angle2 = radians(250);
  translate(60, 220);
  rotate(angle2);
  text("422,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(0);
  translate(60, 150);
  rotate(angle2);
  text("6,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(0);
  translate(140, 150);
  rotate(angle2);
  text("22,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(280);
  translate(160, 240);
  rotate(angle2);
  text("400,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(30);
  translate(320, 230);
  rotate(angle2);
  text("60,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(290);
  translate(475, 150);
  rotate(angle2);
  text("33,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(290);
  translate(895, 220);
  rotate(angle2);
  text("175,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(260);
  translate(1050, 270);
  rotate(angle2);
  text("145,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(290);
  translate(1350, 150);
  rotate(angle2);
  text("187,100", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(270);
  translate(1450, 150);
  rotate(angle2);
  text("100,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(80);
  translate(1530, 90);
  rotate(angle2);
  text("100,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(80);
  translate(1630, 260);
  rotate(angle2);
  text("100,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(290);
  translate(1500, 350);
  rotate(angle2);
  text("95,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(260);
  translate(1370, 310);
  rotate(angle2);
  text("87,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(260);
  translate(1240, 340);
  rotate(angle2);
  text("55,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(260);
  translate(1100, 410);
  rotate(angle2);
  text("37,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(260);
  translate(920, 450);
  rotate(angle2);
  text("24,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(260);
  translate(780, 470);
  rotate(angle2);
  text("20,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(260);
  translate(650, 500);
  rotate(angle2);
  text("30,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(290);
  translate(485, 465);
  rotate(angle2);
  text("28,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(270);
  translate(365, 485);
  rotate(angle2);
  text("12,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(270);
  translate(285, 470);
  rotate(angle2);
  text("14,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(270);
  translate(215, 470);
  rotate(angle2);
  text("8,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(270);
  translate(150, 470);
  rotate(angle2);
  text("4,000", 0, 0);
  popMatrix();
  
  pushMatrix();
  angle2 = radians(270);
  translate(80, 480);
  rotate(angle2);
  text("10,000", 0, 0);
  popMatrix();
  
  strokeWeight(2);
  fill(beige);
  rect(300-4,  670-35, 590, 50);
  fill(black);
  textSize(30);
  text("Graphic Table of Temprature in Degrees Celcius", 300,  670);
 
}
