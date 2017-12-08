class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
   
  float topSpeed;
  float mass;
  float dia;
  
  Mover () {
    
    this.location = new PVector (random (width), random (height));    
    this.velocity = new PVector (0, 0);
    this.acceleration = new PVector (0 , 0);
    
    this.mass = 1;
  }  
  
  Mover (PVector loc, PVector vel) {
    this.location = loc;
    this.velocity = vel;
    this.acceleration = new PVector (0 , 0);
    
    this.topSpeed = 100;
  }
  
  Mover (float m, float x, float y) {
    mass = m;
    location = new PVector (x, y);
    
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
  
  void update () {
    velocity.add (acceleration);
    location.add (velocity);

    acceleration.mult (0);
  }
  
  void display () {
    stroke (0);
    fill(0);
    fill (255, 0, 0);
    
    // PShape arrow = createShape(GROUP);
    
    // PShape shaft = createShape(RECT, location.x, location.y - 1, 75, 2);
    // PShape head = createShape(TRIANGLE, location.x + 90, location.y, location.x + 75, location.y - 5,location.x + 75, location.y + 5);
    
    //PShape fletching = ;
    //PShape notch = ;
    
    // arrow.addChild(shaft);
    // arrow.addChild(head);
    
    // arrow.scale(0.8);
    
    // shape(arrow);
    dia = mass * 16;
    ellipse (location.x, location.y, dia, dia);
  }
  
  void checkEdges() {
    /*if (location.x > width) {
      location.x = width;
      velocity.x *= -0.8;
    } else */if (location.x < 0) {
      velocity.x *= -0.8;
      location.x = 0;
    }
    
    /*if (location.y > height) {
      velocity.y *= -0.8;
      location.y = height;
    } else */if (location.y < 0) {
      velocity.y *= -0.8;
      location.y = 0;
    }
    
  }
  
  void applyForce (PVector force) {
    PVector f = force.get();
    f.div(mass);
    acceleration.add(f);
  }
  
  boolean isInside(Liquid l) {
    float lx = l.getX();
    float ly = l.getY();
    float lw = l.getW();
    float lh = l.getH();

    if (location.x>lx && location.x<lx+lw && location.y>ly && location.y<ly+lh) {
      return true;
    }
    else {
      return false;
    }
  }

  boolean isMouseInside() {
    if ( dist(mouseX, mouseY, this.location.x, this.location.y) < this.dia/2) {
      return true;
    }
    else {
      return false;
    }
    
  }
  
  boolean isOnTarget(Target t) {
    float tx = t.getX();
    float ty = t.getY();
    float tw = t.getW();
    float th = t.getH();
    
    float circleDistanceX = abs(location.x - tx - tw/2);
    float circleDistanceY = abs(location.y - ty - th/2);

    if (circleDistanceX > (tw/2 + dia/2)) { return false; }
    if (circleDistanceY > (th/2 + dia/2)) { return false; }

    if (circleDistanceX <= (tw/2)) { return true; } 
    if (circleDistanceY <= (th/2)) { return true; }

    float cornerDistance_sq = pow(circleDistanceX - tw/2, 2) +
                         pow(circleDistanceY - th/2, 2);

    return (cornerDistance_sq <= pow(dia/1.4,2));
  }
  
  void stopMover() {
    velocity = new PVector (0, 0);
    acceleration = new PVector (0 , 0);
  }
  
  void drag(Liquid l) {
    float lc = l.getCoefficient();

     float speed = velocity.mag();
     // The force’s magnitude: Cd * v~2~
     float dragMagnitude = (lc/10) * speed * speed;
    
     PVector drag = velocity.get();
     drag.mult(-1);
     // The force's direction: -1 * velocity
     drag.normalize();
    
     // Finalize the force: magnitude and direction together.
     drag.mult(dragMagnitude);
    
     // Apply the force.
     applyForce(drag);
  }
}