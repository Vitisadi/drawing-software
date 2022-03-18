void drawing(){ //displays all circles
  for(CircleDrawing circle : circles){
    if (circle.erase){
      circle.setColor(backgroundClr);
    }
    circle.display();    
  } 
  if (modeErase){ //shows eraser when in mode erase
    imageMode(CENTER);
    image(eraser,mouseX,mouseY,thickness,thickness);
  }
  if(!modeErase){ //shows pencil when in mode draw
    imageMode(CENTER);
    image(pencil,mouseX,mouseY,thickness,thickness);
  }
  
  for(BetterText text : betterText){ //displays all user interfered text
    text.display();
  }
}
void removeText(){ //removes selected user intered text
  for(int i = 0; i < betterText.size(); i++){
    for(BetterText text : betterText){
      String currentText = text.name;
      if (DDSelectedText == currentText && DDSelectedText != textTypeEdit){
        betterText.remove(i);
        textMenuOptions.remove(i + 1);
        textMenu.setItems(textMenuOptions,0);
      }
    }
  }
}
