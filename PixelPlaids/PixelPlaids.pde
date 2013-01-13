PImage img;
int countH = 0;
int countV = 0;
int dirH = 1;
int dirV = 1;
PImage sliceH = new PImage();
PImage sliceV = new PImage();

void setup() {

  // Set to your native desktop size to create a nice desktop background
  size(1440, 900); 

  // Load an image and get started!
  img = loadImage("img1.jpg");
  img.loadPixels();
}

void draw() {
  background(255);
  if (countH < height && countV < width) {

    // Grab a 1 pixel vertical slice and a 1 pixel horizontal slice.
    // Grab thicker chunks to create interesting effects
    PImage sliceH = img.get(0, countH, img.width, 1);
    PImage sliceV = img.get(countV, 0, 1, img.height);

    // Draw the horizontal slice and stretch it
    image(sliceH, 0, 0, width, height);

    // Play with the blend modes to create blend the layers
    // http://processing.org/reference/blendMode_.html
    blendMode(MULTIPLY);

    // Now draw the horizontal slice
    image(sliceV, 0, 0, width, height);

    // NEXT!
    countH++;
    countV++;
  }
}

void keyPressed() {
  // See something you like? Hit the space bar to save it!
  if (key==' ') {
    saveFrame("images/###.png");
  }
}

