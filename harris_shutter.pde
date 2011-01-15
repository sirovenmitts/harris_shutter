import processing.video.*;
import controlP5.*; // le gui
Capture cap;
ControlP5 gui;
int head, capWait, skipFrames;
float r, g, b;
PImage frames[];
void setup() {
  size(320, 240);
  cap = new Capture(this, width, height, 120);
  gui = new ControlP5(this);
  // gui.addSlider(name, min, max, default, x, y, w, h)
  gui.addSlider("skipFrames", 0, 10, 0, width / 2 - 50, height - 20, 100, 10);
  head = capWait = skipFrames = 0;
  frames = new PImage[3];
  for(int i = 0; i < 3; i++) {
    frames[i] = createImage(width, height, RGB);
    frames[i].loadPixels();
  }
}
void draw() {
  if(cap.available()) {
    if(skipFrames == 0 || (capWait += 1) % skipFrames == 0) {
      head = (head + 1) % 3;
      cap.read();
      frames[head].copy(cap, 0, 0, width, height, 0, 0, width, height);
    }
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
