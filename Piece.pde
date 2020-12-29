public static color[] PIECE_COLORS = {#FF0000, #00FF00, #0000FF, #00FFFF};
public static int RIGHT = 1;
public static int LEFT = -1;

class Piece {

  int w, h;
  int rotation = 0;
  Matrix grid;

  Piece(Matrix igrid) {
    w=igrid.width;
    h=igrid.height;
    grid = igrid;
  }

  void display() {
    grid.printit();
  }

  void rotateTo(int position) {
    if (position >= 0 && position <=3) {
      while (rotation != position) {
        rotate(position > rotation ? RIGHT : LEFT);
      }
    }
  }

  void rotate(int direction) {
    if (direction < 0) {
      grid.rotateLeft();
      rotation = (rotation>0) ? rotation-1 : 3;
    } else if (direction > 0) {
      grid.rotateRight();
      rotation = (rotation<3) ? rotation+1 : 0;
    }
  }

  //Piece(int iw, int ih, Matrix igrid) {
  //  w=iw;
  //  h=ih;
  //  grid = new int[w][h];

  //  for (int x=0; x<w; x++) {
  //    for (int y=0; y<h; y++) {
  //      grid[x][y] = igrid.matrix[x][y];
  //    }
  //  }
  //}
}
