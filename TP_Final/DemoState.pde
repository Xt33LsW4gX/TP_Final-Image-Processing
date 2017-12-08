class DemoState implements State {

  int i = 0;
  int time = 0;

  @Override
  public void doAction(GameContext ctx, TP_Final g) {

    ctx.setState(this);

    DemoShots[] shots = {
      new DemoShots(15, -20, 1100, 300),
      new DemoShots(12, -22, 1040, 360),
      new DemoShots(15, -20, 1088, 300),
      new DemoShots(8, -23, 800, 375),
      new DemoShots(17, -18, 1100, 300),
      new DemoShots(15, -20, 1046, 246),
      new DemoShots(20, -21, 1049, 60),
      new DemoShots(13, -19, 1013, 381),
      new DemoShots(12, -22, 1046, 378),
      new DemoShots(23, -14, 1331, 441),
      new DemoShots(5, -22, 1046, 378),
    };

    if(!shot) {
      aiming = true;
      createDots(shots[i].sx, shots[i].sy);
      displayDots();
      ball.applyForce(new PVector(shots[i].sx, shots[i].sy));
      g.target.setX(shots[i].tx);
      g.target.setY(shots[i].ty);
      shot = true;
      applyGravity = true;

      i = (i >= shots.length - 1) ? 0 : i+1;
    }

    if(touchedTarget) {
      if(time >= 60) {
        resetBall();
        time = 0;
      }
      else {
        time ++;
      }
    }
  }

}