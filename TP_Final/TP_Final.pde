import java.io.FileWriter;

int forceScaler = 5;
int pTotal = 30;
float startX = 0, startY = 0;
float theta = 0;
float amplitude = 200;
float period = 240;
float oscX = 0, oscY = 0;
float offsetY = 0;

boolean applyGravity;
boolean aiming = false;
boolean touchedTarget;
boolean splashed;
boolean shot;
boolean isTestLaunch = false;
boolean wroteCoords = false;

Mover ball;
Liquid water;
LiquidFactory liquidFactory;
Target target;
ArrayList<Particle> particles;

GameContext ctx;
State manualState;
State demoState;

PVector launch;
PVector gravity;
PVector[] dots;
PVector testTrajectory;
PVector testTarget;

void setup() {
  fullScreen(P2D);
  //size(1200, 600);
  stroke(255);
  frameRate(60);

  ctx = new GameContext();
  manualState = new ManualState();
  demoState = new DemoState();
  ctx.setState(manualState);

  liquidFactory = new LiquidFactory();
  water = liquidFactory.getLiquid("water", -1, 550, width, height / 2);

  ball = new Mover(2, 200, 450);
  target = new RectTarget(1100, 300, 20, 80);
  particles = new ArrayList<Particle>();

  dots = new PVector[15];

  gravity = new PVector (0, 0.3);

  testTrajectory = new PVector(15,-20);
  testTarget = new PVector(1100, 300);
}

void draw() { 
  update();
  render();
}

void update() {

  oscY = (amplitude * cos(TWO_PI * frameCount / period)) + 200;

  ctx.getState().doAction(ctx, this);

  if (applyGravity) {
    ball.applyForce(gravity); 
  }

  if (ball.isInside(water)) {
    ball.drag(water);
  }

  if (ball.isOnTarget(target)) {
  	ball.stopMover();
    touchedTarget = true;
  }

  // FOR TEST LAUNCH
  if(isTestLaunch) {
    createDots(testTrajectory.x, testTrajectory.y);
  }

  ball.update();
  ball.checkEdges();
}

void render() {
  background(255);

  text("fps :"+frameRate, 20, 20);

  ball.display();
  water.display();
  target.play();
  
  if(ball.location.y >= 550) {
  	if(!splashed) {
  	  for (int i = 0; i < pTotal; i++) {
	      particles.add(new Particle(new PVector(ball.location.x, 550)));
	    }
	  splashed = true;
  	}

  	for (Particle p: particles) {
	    p.run();
	  }
  }

  if (ball.location.y > 800) {
    ball = new Mover(2, 200, 450);
    applyGravity = false;
    splashed = false;
    touchedTarget = false;
    shot = false;
    particles = new ArrayList<Particle>();
  }

  if (aiming && dots != null) {
    displayDots();
  }

  // FOR TEST LAUNCH
  if(isTestLaunch) {
    fill(255, 0, 0);
    textSize(20);
    text("testTrajectory.x: " + testTrajectory.x + "\ntestTrajectory.y: " + testTrajectory.y, 10, 20);
    text("testTarget.x: " + testTarget.x + "\ntestTarget.y: " + testTarget.y, 10, 80);

    displayDots();
  }
}

void createDots(float _vix, float _viy) {
  float vix = _vix;
  float viy = _viy;

  launch = new PVector(vix, viy);

  float t = quadratic(-viy, -gravity.y*2, -100);
  float step = (float)dots.length/t;

  for (int i = 0; i < dots.length; i++) {
    float tStep = i * step;

    float x = -vix * tStep;
    float y = -viy * tStep + (gravity.y*2 * tStep * tStep)/2;

    dots[i] = new PVector(x, y);
  }
}

void displayDots() {
  if(isTestLaunch || ctx.getState() == demoState) {
    fill(255, 0, 0);
  }
  else {
    fill(127, 127, 127, 127);
  }
  
  for (int i = 0; i < dots.length - 1; i++) {
      ellipse(dots[i].x + 200, dots[i].y + 450, 10, 10);
  }
}

float quadratic(float a, float b, float c) {
  return (-b - sqrt( b*b - 4*a*c)) / (2*a);
}

void mousePressed() {
  if(ball.isMouseInside() && !shot && ctx.getState() == manualState) {
  	startX = mouseX;
    startY = mouseY;

  	aiming = true;
  }
}

void mouseReleased() {
  if(aiming && !shot && ctx.getState() == manualState) {
  	ball.applyForce(launch);

  	applyGravity = true;
  	shot = true;
  	aiming = false;
  }
}

void resetBall() {
  ball = new Mover(2, 200, 450);

    launch = null;
    applyGravity = false;
    touchedTarget = false;
    splashed = false;
    shot = false;
    wroteCoords = false;
}

void keyPressed() {
  if (key == 'r') {
    resetBall();
  }
  if (key == 'q' && !shot && isTestLaunch) {
    ball.applyForce(new PVector(testTrajectory.x, testTrajectory.y));

  	applyGravity = true;
  	shot = true;
  }
  if (key == 't' && !shot) {
    isTestLaunch = !isTestLaunch;
  }

  // CONTROLS FOR TRAJECTORY
  if (key == 'i') {
    testTrajectory.x += 1;
  }
  if (key == 'u') {
    testTrajectory.x -= 1;
  }
  if (key == 'k') {
    testTrajectory.y -= 1;
  }
  if (key == 'j') {
    testTrajectory.y += 1;
  }

  // CONTROLS FOR TARGET
  if(!touchedTarget && !shot) {
    if (key == 'p') {
      testTarget.x += 3;
    }
    if (key == 'o') {
      testTarget.x -= 3;
    }
    if (key == ';') {
      testTarget.y -= 3;
    }
    if (key == 'l') {
      testTarget.y += 3;
    }
  }

  // CONTROLS FOR STATES
  if (key == '1') {
    ctx.setState(manualState);
  }
  if (key == '2' && !shot) {
    ctx.setState(demoState);
    target.setX(1100);
    target.setY(300);
  }
}