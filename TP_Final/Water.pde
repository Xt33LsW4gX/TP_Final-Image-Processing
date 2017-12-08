class Water implements Liquid{
  private float x, y, w, h, coefficient = 1;

  Water(float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  
  @Override
  void display() {
    stroke(0);
    fill (0, 174, 255, 127);
    
    rect(x, y, w, h, 7);
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

  @Override
  float getCoefficient() {
    return this.coefficient;
  }
  
}