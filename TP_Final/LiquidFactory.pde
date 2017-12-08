public class LiquidFactory {
  public Liquid getLiquid(String whichLiquid, float _x, float _y, float _w, float _h){
    if(whichLiquid == null) {
      return null;
    }

    if(whichLiquid.equalsIgnoreCase("water")) {
      return new Water(_x, _y, _w, _h);
    }

    return null;
  }
}