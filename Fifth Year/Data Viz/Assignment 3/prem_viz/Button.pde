class Button{
    float x;
    float y;
    float width;
    float height;
    boolean over;
    boolean selected;
    String value;
    int textSize;

    Button(float x, float y, float width, float height, boolean over, boolean selected, String value, int textSize){
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.over = over;
        this.selected = selected;
        this.value = value;
        this.textSize = textSize;
    }

    void show(){
        if(this.selected || this.over) fill(HOVER_COLOR);
        else fill(BUTTON_COLOR);
        rect(this.x, this.y, this.width, this.height);
        textAlign(LEFT);
        fill(0);
        textSize(this.textSize);
        text(this.value, this.x + 5, this.y+textSize);
    }

    void update(){
        this.over = (mouseX >= this.x && mouseX <= this.x+this.width && mouseY >= this.y && mouseY <= this.y+this.height);
    }

}