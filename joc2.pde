import processing.serial.*;

boolean gameOver = false;

Bird b;
int wid = 800;
int rez = 20;
int score = 0;
boolean jumping = false;
PVector gravity = new PVector(0, 0.5);
ArrayList<Pipe> pipes = new ArrayList<Pipe>();
PImage myImg;

PImage go;

void setup() {
  size(800, 800);
  b = new Bird();
  pipes.add(new Pipe());
  myImg = loadImage("image001-1.png");
  go = loadImage("gameover.jpg");
  setupSerial();
}

void draw() {
  background(0);


  if (!gameOver) {
    if (frameCount % 75 == 0) {
      pipes.add(new Pipe());
    }

    if (keyPressed) {
      PVector up = new PVector(0, -5);
      b.applyForce(up);
    }

    b.update();
    b.show();
    boolean safe = true;

    for (int i = pipes.size() - 1; i >= 0; i--) {
      Pipe p = pipes.get(i);
      p.update();

      if (p.hits(b)) {
        p.show(true);
        safe = false;
      } else {
        p.show(false);
      }

      if (p.x < -p.w) {
        pipes.remove(i);
      }
    }

    if (safe) {
      score++;
    } else {
      score -= 50;
    }

    fill(255, 0, 255);
    textSize(64);
    text(score, width/2, 50);
    score = constrain(score, 0, score);

    if (score <=0) {
      gameOver=true;
    }
  } else {
    background(255, 255, 255);
    image(go, 0, 0, 800, 800);
  }
}