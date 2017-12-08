class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float mass;

  Particle(PVector l) {
    acceleration = new PVector(0,-0.05);
    velocity = new PVector(random(-2,2), random(-3,0));
    location = l.get();
    lifespan = 150;
    mass = 2;
  }

  void run() {
    update();
    display();
  }

  void update() {
    acceleration.add(new PVector(0,0.15));
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
    acceleration.mult (0);
  }

  void display() {
    stroke(0,lifespan);
    fill(0, 174, 255,lifespan);
    ellipse(location.x,location.y,8,8);
  }

  // Is the Particle alive or dead?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}