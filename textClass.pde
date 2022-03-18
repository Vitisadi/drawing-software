class BetterText{ //class for the text that is being added by the user
  int x, y;
  int adjustmentRate;
  int size;
  String name;
  color clr;
  
  BetterText(int _x, int _y, String _name, color _clr){
    x = _x;
    y = _y;
    name = _name;
    clr = _clr;
    size = 50;
    adjustmentRate = 10;
  }
  
  void display(){
      fill(clr);
      textSize(size);
      text(name, x, y);
  }
  
  void moveLeft(){
    x -= adjustmentRate;
  }
  
  void moveRight(){
    x += adjustmentRate;
  }
  
  void moveUp(){
    y -= adjustmentRate;
  }
  
  void moveDown(){
    y += adjustmentRate;
  }
  
  String getName1 (){
    return name;
  }  
}
