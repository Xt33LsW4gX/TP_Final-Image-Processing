public abstract class Target {

  abstract void display();

  public final void play() {
    display();
  }

  public void setX(float _x) {
    setX(_x);
  }
  public void setY(float _y) {
    setY(_y);
  }
  public void setW(float _w) {
    setW(_w);
  }
  public void setH(float _h) {
    setH(_h);
  }

  public float getX() {
    return getX();
  }
  public float getY() {
    return getY();
  }
  public float getW() {
    return getW();
  }
  public float getH() {
    return getH();
  }
}