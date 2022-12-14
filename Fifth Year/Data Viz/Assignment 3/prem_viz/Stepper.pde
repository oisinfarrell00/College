class Stepper{
    float x;
    float y;
    float width;
    float height;
    boolean overIncreaseButton;
    boolean overDecreaseButton;
    int value;
    int buttonHeight;
    String label;
    

    Stepper(float x, float y, float width, float height, boolean overIncreaseButton, boolean overDecreaseButton, int value, int buttonHeight, String label){
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.overIncreaseButton = overIncreaseButton;
        this.overDecreaseButton = overDecreaseButton;
        this.value = value;
        this.buttonHeight = buttonHeight;
        this.label = label;
    }

    void show(){
        strokeWeight(1);
        fill(255);
        rect(this.x, this.y, this.width, this.height);
        fill(0);
        textSize(45);
        textAlign(CENTER);
        text(this.value, this.x+this.width/2, this.y+this.height-5);
        textSize(15);
        text(this.label, this.x+this.width/2, this.y-(5+this.buttonHeight));
        fill(overIncreaseButton ? HOVER_COLOR : BUTTON_COLOR);
        rect(this.x, this.y-this.buttonHeight, this.width, this.buttonHeight, 5, 5, 0, 0);
        fill(overIncreaseButton ? BUTTON_COLOR : HOVER_COLOR);
        triangle(this.x+this.width/2, this.y-(this.buttonHeight-5), this.x+this.width/2-10, this.y-this.buttonHeight+15, 
        this.x+this.width/2+10, this.y-this.buttonHeight+15);
        fill(overDecreaseButton ? HOVER_COLOR : BUTTON_COLOR);
        rect(this.x, this.y+this.height, this.width, this.buttonHeight, 0, 0, 5, 5);
        fill(overDecreaseButton ? BUTTON_COLOR : HOVER_COLOR);
        triangle(this.x+this.width/2, this.y+this.height+15, 
        this.x+this.width/2-10, this.y+this.height+5, this.x+this.width/2+10, 
        this.y+this.height+5);
    }

    void update(){
        this.overIncreaseButton = (mouseX >= this.x && mouseX <= this.x+this.width && mouseY >= this.y-this.buttonHeight && mouseY <= this.y);
        this.overDecreaseButton = (mouseX >= this.x && mouseX <= this.x+this.width && mouseY >= this.y+this.height && mouseY <= this.y+this.height+this.buttonHeight);
    }

}