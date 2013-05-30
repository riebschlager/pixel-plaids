static int OUTPUT_WIDTH = 5100;
static int OUTPUT_HEIGHT = 3300;
PImage src, sliceH, sliceV;
PGraphics output;
int sliceY, sliceX, currentBlendMode, background;
int sliceSize = 1;
int[] blendModes = {
  BLEND, ADD, SUBTRACT, DARKEST, LIGHTEST, DIFFERENCE, EXCLUSION, MULTIPLY, SCREEN, REPLACE
};

void setup() {
  size((int) OUTPUT_WIDTH/3, (int) OUTPUT_HEIGHT/3);
  output = createGraphics(OUTPUT_WIDTH, OUTPUT_HEIGHT);
  output.beginDraw();
  output.clear();
  output.endDraw();
  src = loadImage("img1.jpg");
  src.loadPixels();
}

void draw() {
  background(0);
  image(output, 0, 0, width, height);
}

void render() {
  sliceH = src.get(0, sliceY, src.width, sliceSize);
  sliceV = src.get(sliceX, 0, sliceSize, src.height);
  output.beginDraw();
  output.clear();
  output.background(background);
  output.image(sliceH, 0, 0, output.width, output.height);
  output.blendMode(blendModes[currentBlendMode]);
  output.image(sliceV, 0, 0, output.width, output.height);
  output.endDraw();
}

void keyPressed() {
  if (key==' ') {
    output.save("output/" + year() + "-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + ".tif");
  }

  if (key=='S') {
    sliceSize++;
  }

  if (key=='s') {
    sliceSize = (sliceSize > 2) ? sliceSize - 1 : 1;
  }

  if (key=='b') {
    background = (background == 0) ? 255 : 0;
  }

  if (key=='r') {
    background = color(random(255), random(255), random(255));
  }

  if (key=='m') {
    currentBlendMode = (currentBlendMode >= blendModes.length-1) ? 0 : currentBlendMode + 1;
  }

  if (key=='n') {
    sliceY = (int) random(src.width);
    sliceX = (int) random(src.height);
  }

  if (key=='x') {
    sliceY = (int) random(src.width);
    sliceX = (int) random(src.height);
    sliceSize = (int) random(1, 1);
    //background = color(random(255), random(255), random(255));
    currentBlendMode = (int) random(blendModes.length-1);
  }

  render();
}

