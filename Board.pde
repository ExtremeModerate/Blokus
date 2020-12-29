class Board {

  Box [][] grid;
  int width, height;

  Board(int x, int y) {
    width = x;
    height = y;
    grid = new Box[x][y];
    for (int w=0; w<width; w++) {
      for (int h=0; h<height; h++) {
        grid[w][h] = new Box(w, h);
      }
    }
  }

  void display() {
    for (int w=0; w<width; w++) {
      for (int h=0; h<height; h++) {
        grid[w][h].display();
      }
    }
  }
}

class Box {

  int x, y;
  int boxColor;

  Box(int ix, int iy) {
    x=ix;
    y=iy;
    boxColor = int(random(250));
  }

  void display() {
    stroke(255);
    fill(boxColor);
    rect(x*CELLSIZE, y*CELLSIZE, CELLSIZE, CELLSIZE);
  }
}
