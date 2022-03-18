import g4p_controls.*;
import java.awt.Font;    //will be needed to set the font in our textfield and label
import java.util.*;
import java.awt.Font;

Font myFont = new Font("Times", Font.PLAIN, 20);  

color clrSelected;
color backgroundClr;
color drawingClr;

PImage eraser;
PImage pencil;

boolean modeErase;

String saveText;
String currentTypedText;
String textTypeEdit = "Select the text you want to edit";

int numberQuickButtons = 6;

List<CircleDrawing> circles = new ArrayList();

ArrayList <BetterText> betterText = new ArrayList <BetterText>();

int thickness = 64;

GDropList sizeMenu;
GDropList textMenu;
List<String> textMenuOptions = new ArrayList();
String DDSelectedText;
GSlider sliderRed;
GSlider sliderGreen;
GSlider sliderBlue;
GTextField tBoxSave;
GTextField tBoxText;
GButton buttonSelectBG;
GButton buttonSelectDraw;
GButton buttonDraw;
GButton buttonErase;
GButton saveIMG;
GButton buttonUp;
GButton buttonRight;
GButton buttonDown;
GButton buttonLeft;
GButton buttonInsertText;
GButton buttonDeleteText;
GLabel label;

Button [] quickColorButtons;

void setup() {
  size(1600,1200);
 
  eraser = loadImage("eraser.png");
  pencil = loadImage("pencil.png");
  
  backgroundClr = (255);
   //Our slider. Note: 5th constructor argument is overall height which includes values shown above track. 6th argument is just slider/track height
   sliderRed = new GSlider(this, 100,0,400,100,20);
   sliderRed.setNbrTicks(17);
   sliderRed.setShowTicks(true);
   sliderRed.setStickToTicks(true);
   sliderRed.setShowValue(true);
   sliderRed.setEasing(15);
   sliderRed.setLimits(255,0,255);
   
   sliderGreen = new GSlider(this, 100,100,400,100,20);
   sliderGreen.setNbrTicks(17);
   sliderGreen.setShowTicks(true);
   sliderGreen.setStickToTicks(true);
   sliderGreen.setShowValue(true);
   sliderGreen.setEasing(15);
   sliderGreen.setLimits(255,0,255);
   
   sliderBlue = new GSlider(this, 100,200,400,100,20);
   sliderBlue.setNbrTicks(17);
   sliderBlue.setShowTicks(true);
   sliderBlue.setStickToTicks(true);
   sliderBlue.setShowValue(true);
   sliderBlue.setEasing(15);
   sliderBlue.setLimits(255,0,255);
   
    buttonSelectBG = new GButton(this, 550,10,200,50,"Select Background");
    buttonSelectBG.setFont(myFont);
    buttonSelectDraw = new GButton(this, 550,240,200,50,"Select Drawing Color");
    buttonSelectDraw.setFont(myFont);
    
    buttonDraw = new GButton(this, width-300,200,300,100,"Draw");
    buttonDraw.setFont(myFont);
    buttonDraw.setLocalColorScheme(GCScheme.RED_SCHEME); 
    
    buttonErase = new GButton(this, width-300,305,300,100,"Erase");
    buttonErase.setFont(myFont);
    buttonErase.setLocalColorScheme(GCScheme.YELLOW_SCHEME);
    
    saveIMG = new GButton(this, width-300,height-300,300,100,"Save IMG");
    saveIMG.setFont(myFont);
    saveIMG.setLocalColorScheme(GCScheme.PURPLE_SCHEME); 
    
    buttonInsertText = new GButton(this, width-300,600,300,50,"Insert Text");
    buttonInsertText.setFont(myFont);
    buttonInsertText.setLocalColorScheme(GCScheme.GREEN_SCHEME); 
    
    buttonDeleteText = new GButton(this, width-300,650,300,50,"Delete Text");
    buttonDeleteText.setFont(myFont);
    buttonDeleteText.setLocalColorScheme(GCScheme.RED_SCHEME); 
    
    quickColorButtons = new Button [numberQuickButtons];
    quickColorButtons[0] = new Button(825, 50, 100, 100, color(255, 0, 0), color(200,0,0), color(150,0,0), "");
    quickColorButtons[1] = new Button(975, 50, 100, 100, color(0, 255, 0), color(0,200,0), color(0,150,0), "");
    quickColorButtons[2] = new Button(1125, 50, 100, 100, color(0, 0, 255), color(0,0,200), color(0,0,150), "");
    quickColorButtons[3] = new Button(825, 175, 100, 100, color(255, 255, 0), color(200,200,0), color(150,150,0), "");
    quickColorButtons[4] = new Button(975, 175, 100, 100, color(255, 0, 255), color(200,0,200), color(150,0,150), "");
    quickColorButtons[5] = new Button(1125, 175, 100, 100, color(0, 255, 255), color(0,200,200), color(0,150,150), "");
    
    buttonUp = new GButton(this, width-195,745,75,75,"Up");
    buttonUp.setFont(myFont);
    buttonDown = new GButton(this, width-195,820,75,75,"Down");
    buttonDown.setFont(myFont);
    buttonLeft = new GButton(this, width-270,775,75,75,"Left");
    buttonLeft.setFont(myFont);
    buttonRight = new GButton(this, width-120,775,75,75,"Right");
    buttonRight.setFont(myFont);
    
    clrSelected = color(sliderRed.getValueI(), sliderGreen.getValueI(), sliderBlue.getValueI());

    tBoxSave = new GTextField(this, width-300, height-150, 300, 150, 2); //Last argument sets scrollbar policy, but SCROLLBARS_HORIZONTAL_ONLY constant is not working. Apparently it's 2
    tBoxSave.setFont(new Font("Monospaced", Font.PLAIN, 48));
    tBoxText = new GTextField(this, width-300, 450, 300, 150, 2); 
    tBoxText.setFont(new Font("Monospaced", Font.PLAIN, 48));
    
   String [] options = {"8", "16", "32", "64", "128"};
   textMenuOptions.add(textTypeEdit);
   sizeMenu = new GDropList(this, width-300,100,300,200);
   sizeMenu.setItems(options,3); 
   textMenu = new GDropList(this, width-300,700,300,200);
   textMenu.setItems(textMenuOptions,0);
   
   betterText.add(new BetterText(100,100,"abc", color(0)));
   betterText.remove(0);
}


void draw() {
  background(backgroundClr);
  drawing();
  optionDisplay();
  quickButtons();
}

void optionDisplay(){
  noStroke(); //options
  fill(185,219,227);
  rect(0,0,width, 300);
  rect(width-300, 0, 300, height);
  
  textSize(25); //RGB Text
  fill(255,0,0);
  text("Red", 25, 60);
  fill(89,206,79);
  text("Green", 25, 160);
  fill(0,0,255);
  text("Blue", 25,260);
  
  fill(clrSelected);
  circle(650,150,150);
  
  fill(0);
  textAlign(CENTER);
  textSize(75);
  text("Size", width - 150, 75);
  textSize(35);
  text("IMG Name", width-150, height - 165);
  
  text("Quick Color Selector", 1025, 35);
  text("Type Text Below", width-150, 435);
}

void quickButtons(){
  for (int i = 0; i < quickColorButtons.length; i++){
    quickColorButtons[i].display();
  }
  if(quickColorButtons[0].clicked()){
    sliderRed.setValue(255);
    sliderGreen.setValue(0);
    sliderBlue.setValue(0);
    drawingClr = color(255,0,0);
    modeErase = false;
  }
  if(quickColorButtons[1].clicked()){
    sliderRed.setValue(0);
    sliderGreen.setValue(255);
    sliderBlue.setValue(0);
    drawingClr = color(0,255,0);
    modeErase = false;
  }
  if(quickColorButtons[2].clicked()){
    sliderRed.setValue(0);
    sliderGreen.setValue(0);
    sliderBlue.setValue(255);
    drawingClr = color(0,0,255);
    modeErase = false;
  }
  if(quickColorButtons[3].clicked()){
    sliderRed.setValue(255);
    sliderGreen.setValue(255);
    sliderBlue.setValue(0);
    drawingClr = color(255,255,0);
    modeErase = false;
  }
  if(quickColorButtons[4].clicked()){
    sliderRed.setValue(255);
    sliderGreen.setValue(0);
    sliderBlue.setValue(255);
    drawingClr = color(255,0,255);
    modeErase = false;
  }
  if(quickColorButtons[5].clicked()){
    sliderRed.setValue(0);
    sliderGreen.setValue(255);
    sliderBlue.setValue(255);
    drawingClr = color(0,255,255);
    modeErase = false;
  }
}

void handleSliderEvents(GValueControl slider, GEvent event) {
  clrSelected = color(sliderRed.getValueI(), sliderGreen.getValueI(), sliderBlue.getValueI()); //gets slider value
}

void handleButtonEvents(GButton button, GEvent event) { //button press events
 if(button == buttonSelectBG){
   backgroundClr = clrSelected;
 }
 if(button == buttonSelectDraw){
   drawingClr = clrSelected;
 }
 if(button == buttonDraw){
   modeErase = false;
 }
 if(button == buttonErase){
   modeErase = true;
 }
 if(button == buttonInsertText){
   if(currentTypedText != ""){
     betterText.add(new BetterText(600,600, currentTypedText, color(0)));
     textMenuOptions.add(currentTypedText);
     textMenu.setItems(textMenuOptions,0);
     tBoxText.setText("");
   }
 }
  if(button == buttonDeleteText){
    removeText();
  }
 if(button == saveIMG){
   PImage outIMG = get(0,300, width-300, height-300);
   outIMG.save(saveText + ".jpg");
   tBoxSave.setText("Saved :)");
 }
  if(button == buttonRight){
    for(int i = 0; i < betterText.size(); i++){
      for(BetterText text : betterText){
        String currentText = text.name;
        if (DDSelectedText == currentText && DDSelectedText != textTypeEdit){
          text.moveRight();
        }
      }
    }
  }
  if(button == buttonLeft){
    for(int i = 0; i < betterText.size(); i++){
      for(BetterText text : betterText){
        String currentText = text.name;
        if (DDSelectedText == currentText && DDSelectedText != textTypeEdit){
          text.moveLeft();
        }
      }
    }
  }
  if(button == buttonUp){
    for(int i = 0; i < betterText.size(); i++){
      for(BetterText text : betterText){
        String currentText = text.name;
        if (DDSelectedText == currentText && DDSelectedText != textTypeEdit){
          text.moveUp();
        }
      }
    }
  }
  if(button == buttonDown){
    for(int i = 0; i < betterText.size(); i++){
      for(BetterText text : betterText){
        String currentText = text.name;
        if (DDSelectedText == currentText && DDSelectedText != textTypeEdit){
          text.moveDown();
        }
      }
    }
  }
}


void handleTextEvents(GEditableTextControl textcontrol, GEvent event) { //gets text events
  saveText = tBoxSave.getText();
  currentTypedText = tBoxText.getText();
}

void handleDropListEvents(GDropList menu, GEvent event) {
  thickness = Integer.parseInt(sizeMenu.getSelectedText());
  DDSelectedText = textMenu.getSelectedText();
}

void mouseDragged(){ //drawing part
  if(mouseX<width-300 & mouseY > 300){
    circles.add(new CircleDrawing(mouseX, mouseY, thickness, drawingClr, modeErase));
  }
}

void mousePressed(){ //drawing part
  if(mouseX<width-300 & mouseY > 300){
    circles.add(new CircleDrawing(mouseX, mouseY, thickness, drawingClr, modeErase));
  }
}
