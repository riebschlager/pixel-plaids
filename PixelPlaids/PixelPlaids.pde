PImage img;
int countH = 0;
int countV = 0;
int dirH = 1;
int dirV = 1;
PImage sliceH = new PImage();
PImage sliceV = new PImage();
boolean auto = true;
int sliceSize = 1;
int currentBlendMode = 0;
int background = 0;
int[] blendModes = {
  BLEND, ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, REPLACE
};

void setup() {

  // Set to your native desktop size to create a nice desktop background
  size(2560, 1440); 

  // Load an image and get started!
  img = loadImage("img5.jpg");
  img.loadPixels();
}

void draw() {
  background(background);

  // Grab a 1 pixel vertical slice and a 1 pixel horizontal slice.
  // Grab thicker chunks to create interesting effects
  PImage sliceH = img.get(0, countH, img.width, sliceSize);
  PImage sliceV = img.get(countV, 0, sliceSize, img.height);

  // Draw the horizontal slice and stretch it
  image(sliceH, 0, 0, width, height);

  // Play with the blend modes to create blend the layers
  // http://processing.org/reference/blendMode_.html
  blendMode(blendModes[currentBlendMode]);

  // Now draw the horizontal slice
  image(sliceV, 0, 0, width, height);

  if (countH < height && countV < width && auto) {
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
  
  // Make the sliceSize BIGGER
  if (key=='S') {
    sliceSize++;
  }

  // Make the sliceSize smaller, but no smaller than 1 pixel
  if (key=='s') {
    sliceSize = (sliceSize > 2) ? sliceSize - 1 : 1;
  }

  // Invert the background color
  if (key=='b') {
    background = (background == 0) ? 255 : 0;
  }

  // Pick a weird random background color
  if (key=='r') {
    background = color(random(255), random(255), random(255));
  }

  // Change up that blend mode!
  if (key=='m') {
    currentBlendMode = (currentBlendMode >= blendModes.length-1) ? 0 : currentBlendMode + 1;
  }

  // Rather than iterate through the rows and columns, just jump around!
  if (key=='n') {
    auto = false;
    countH = (int) random(img.width);
    countV = (int) random(img.height);
  }

  // RANDOM EVERYTHING!!!
  if (key=='x') {
    auto = false;
    countH = (int) random(img.width);
    countV = (int) random(img.height);
    sliceSize = (int) random(1, 1);
    background = color(random(255), random(255), random(255));
    currentBlendMode = (int) random(blendModes.length-1);
  }

  // Use the current parameters and restart in auto mode
  if (key=='a') {
    auto = true;
    countH = 0;
    countV = 0;
  }
}

