class Board {

  BoardCell [][] grid;
  int width, height;

  Board(int x, int y) {
    width = x;
    height = y;
    grid = new BoardCell[x][y];
    for (int w=0; w<width; w++) {
      for (int h=0; h<height; h++) {
        grid[w][h] = new BoardCell(w, h);
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
  
  boolean isPlayable(Piece piece, int x, int y) {
    if 
  }  
  
}

class BoardCell {

  int x, y;
  int owner = 0;
  color myColor;
  final color[] COLORS = {Piece.RED, Piece.GREEN, Piece.BLUE, Piece.YELLOW};

  BoardCell(int ix, int iy) {
    x=ix;
    y=iy;
    owner = 0; 
    myColor = COLORS[int(random(COLORS.length))];
  }

  void display() {
    stroke(#000000);
    fill(myColor);
    rect(x*CELLSIZE, y*CELLSIZE, CELLSIZE, CELLSIZE);
  }
  
  boolean isPlayed() {
    return false;
  }
}
