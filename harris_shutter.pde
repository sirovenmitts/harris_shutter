import processing.video.*;
Capture cap;
int head;
float r, g, b;
PImage frames[];
void setup() {
  size(320, 240);
  cap = new Capture(this, width, height, 120);
  head = 0;
  frames = new PImage[3];
  for(int i = 0; i < 3; i++) {
    frames[i] = createImage(width, height, RGB);
    frames[i].loadPixels();
  }
}
void draw() {
  if(cap.available()) {
    head = (head + 1) % 3;
    cap.read();
    frames[head].copy(cap, 0, 0, width, height, 0, 0, width, height);
  }
  loadPixels();
  for(int i = 0; i < width * height; i++) {
    r = red(frames[head].pixels[i]);
    g = green(frames[(head + 1) % 3].pixels[i]);
    b = green(frames[(head + 2) % 3].pixels[i]);
    pixels[i] = color(r, g, b);
  }
  updatePixels();
}
