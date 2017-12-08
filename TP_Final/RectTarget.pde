public class RectTarget extends Target{
  
  float x, y, w, h;

  RectTarget(float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  
  @Override
  void display() {
    stroke(0);
    fill (200, 200, 200, 255);
    
    rect(x, y, w, h, 7);
  }

  @Override
  void setX(float _x) {
    this.x = _x;
  }
  @Override
  void setY(float _y) {
    this.y = _y;
  }
  @Override
  void setW(float _w) {
    this.w = _w;
  }
  @Override
  void setH(float _h) {
    this.h = _h;
  }

  @Override
  float getX() {
    return this.x;
  }
  @Override
  float getY() {
    return this.y;
  }
  @Override
  float getW() {
    return this.w;
  }
  @Override
  float getH() {
    return this.h;
  }
}