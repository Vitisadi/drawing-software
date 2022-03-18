class CircleDrawing{
  int x, y, w;
  color clr;
  boolean erase;
  
 CircleDrawing(int _x, int _y, int _w, color _clr, boolean _erase){
    x = _x;
    y = _y;
    w = _w;
    clr = _clr;
    erase = _erase;
  }
  
  void display(){
    fill(clr);
    circle(x,y,w);
  }
  
  void setColor(color bg){
    clr = bg;
  }  
}
