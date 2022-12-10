class Button{
    float x;
    float y;
    float width;
    float height;
    boolean over;
    boolean selected;
    String team;

    Button(float x, float y, float width, float height, boolean over, boolean selected, String team){
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.over = over;
        this.selected = selected;
        this.team = team;
    }

    void show(){
        if(selected || over) fill(HOVER_COLOR);
        else fill(BUTTON_COLOR);
        rect(this.x, this.y, this.width, this.height);
        textAlign(LEFT);
        fill(0);
        textSize(15);
        text(this.team, this.x + 5, this.y+15);
    }

    void update(){
        over = (mouseX >= this.x && mouseX <= this.x+this.width && mouseY >= this.y && mouseY <= this.y+this.height);
    }

}