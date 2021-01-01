class Board extends Matrix {

  Matrix playerPositions; // = new Matrix(new int[][]{{1,2},{3,4}} );
  
  Board(int size) {
    super(size, size);
    
    IntList players = new IntList(new int[] {1,2,3,4});
    players.shuffle();
    int[] p = players.array();
    playerPositions = new Matrix();
    //playerPositions.appendRow()
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
