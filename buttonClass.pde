class Button
{
  int x, y, w, h;
  color c;
  color cOver;
  color cDown;
  String txt;
  int txtSize = 24;
  boolean up;

  /****************************************************************************
   
   CONSTRUCTOR
   
   ****************************************************************************/
  Button (int _x, int _y, int _w, int _h, color _c, color _cover, color _cdown, String _txt)
  {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    c = _c;
    cOver = _cover;
    cDown = _cdown;
    txt = _txt;
    up = true;
  }

  /****************************************************************************
   
   DISPLAY THE BUTTON
   
   ****************************************************************************/
  void display()
  {
    rectMode(CORNER);
    pushStyle();
    textAlign(CENTER);
    
    if (buttonDown()) fill(cDown);     //we could play with various styles to animate the press
    else if (mouseOver()) fill(cOver);
    else fill(c);
      
    stroke(100);
    strokeWeight(2);
    rect(x, y, w, h, 10);
    fill(0);
    textSize(txtSize);
    text(txt, x+w/2, y+h/2+txtSize/2);
    popStyle();
  }


  /****************************************************************************
   
   CHANGE THE TEXT ON THE BUTTON
   
   ****************************************************************************/
  void setText (String _txt)
  {
    txt = _txt;
    display();
  }

  /****************************************************************************
   
   IS THE MOUSE OVER THE BUTTON?
   
   ****************************************************************************/
  boolean mouseOver()
  {
    return (mouseX >= x && mouseX <= (x + w) && mouseY >= y && mouseY <= (y + h));
  }
  
  boolean buttonDown()
  {
    return ( mouseOver() && mousePressed );
  }
  
  boolean clicked()            //needed to create single click events
  {
    if (up) {                  //the button is up and can to be clicked
      if (buttonDown()) {      //we find the button in the down state so it's just been clicked
        up = false;            //we can no longer click if it remains down
        return true;           //but we saw this one click so we return true
      }
      else return false;       //it was never down in the first place
    }
    
    else if (!buttonDown()) {  //the button is not down so we can reset up; it is ready to click again 
      up = true;
      return false;            //still, the button has not been clicked again yet
    }
    
    else {
      return false;
    }  
  }
} 
// Base Button class by ROLF VAN GELDER http://web20bp.com/kb/processing-button-class/
//Adapted to include a buttonDown() method and one-off clicked() method
