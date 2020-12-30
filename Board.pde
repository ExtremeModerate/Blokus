class Board extends Matrix {

  Board(int size) {
    super(size, size);
  }

  void display() {
    for (int y=0; y<this.height; y++) {
      for (int x=0; x<this.width; x++) {
        stroke(#000000);
        fill(GameColors.COLORS[matrix[x][y]]);
        rect(x*CELLSIZE, y*CELLSIZE, CELLSIZE, CELLSIZE);
      }
    }
  }

  void placePiece(Piece p, int left, int top) {
    if (!this.AND(p)) {
      println("placing piece", p.owner);
      this.addMatrix(p, left, top);
      p.setPlayed(true);
    }
  }


  boolean isPlayable(Piece piece, int x, int y) {
    return false;
  }
}
