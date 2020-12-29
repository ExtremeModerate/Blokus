
class Piece {
  public static final int RIGHT = 1;
  public static final int LEFT = -1;
  public static final color RED = #FF0000;
  public static final color GREEN = #00FF00;
  public static final color BLUE = #0000FF;
  public static final color YELLOW = #FFFF00;
  
  int rotation = 0;
  Matrix grid;

  Piece(Matrix igrid) {
    grid = igrid;
  }


  void display() {
    grid.printit();
  }

  void rotateTo(int position) {
    int pos = constrain(position, 0, 3);
    //if (position >= 0 && position <=3) {
    while (rotation != pos) {
      this.rotate(pos > rotation ? Piece.RIGHT : Piece.LEFT);
      //}
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
}
