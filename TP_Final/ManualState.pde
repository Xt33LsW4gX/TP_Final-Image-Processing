class ManualState implements State {

  FileWriter output;

  @Override
  public void doAction(GameContext ctx, TP_Final g) {

    ctx.setState(this);

    if(!touchedTarget) {

      if(isTestLaunch) {
        target.setX(testTarget.x);
        target.setY(testTarget.y);
      }
      else {
        target.setY(oscY);
      }
    }
    else if(!wroteCoords && isTestLaunch) {
      outputCoords();
      wroteCoords = true;
    }

    if(aiming) {
      float vix = -(mouseX - startX)/forceScaler;
      float viy = -(mouseY - startY)/forceScaler;

      createDots(vix, viy);
    }
  }

  private void outputCoords() {
  try {
    output = new FileWriter("C:\\Users\\james\\Documents\\Google Drive\\CEGEP\\5 - A2017\\Image Processing\\Travaux\\TP Final\\TP_Final\\WorkingShots.txt", true);
    output.write("testTrajectory.x = " + testTrajectory.x);
    output.write(System.lineSeparator() + "testTrajectory.y = " + testTrajectory.y);
    output.write(System.lineSeparator() + "testTarget.x = " + testTarget.x);
    output.write(System.lineSeparator() + "testTarget.y = " + testTarget.y);
    output.write(System.lineSeparator() + "------------------------------------" + System.lineSeparator());
  }
  catch (IOException e) {
    println("It Broke");
    e.printStackTrace();
  }
  finally {
    if (output != null) {
      try {
        output.close();
      } 
      catch (IOException e) {
        println("Error while closing the writer");
      }
    }
  }
}

}