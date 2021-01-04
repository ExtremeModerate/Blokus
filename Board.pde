public static final ArrayList<Point> CORNERS = new ArrayList<Point>() {
  {
    add(new Point(-1, -1));
    add(new Point(1, -1));
    add(new Point(1, 1));
    add(new Point(-1, 1));
  }
};

public static final ArrayList<Point> EDGES = new ArrayList<Point>() {
  {
    add(new Point(-1, 0));
    add(new Point(1, 0));
    add(new Point(0, -1));
    add(new Point(0, 1));
  }
};

public static final ArrayList<Point> PLAYER_CORNERS = new ArrayList<Point>() {
  {
    add(new Point(0, 0));
    add(new Point(BOARDSIZE-1, 0));
    add(new Point(BOARDSIZE-1, BOARDSIZE-1));
    add(new Point(0, BOARDSIZE-1));
  }
};

//ArrayList<Type> obj = new ArrayList<Type>(
//      Arrays.asList(Obj A, Obj B, Obj C, ....so on));

class Board extends Matrix {

  private boolean[] firstPlay = new boolean[]{true, true, true, true};

  Board(int size) {
    super(size, size);

    IntList players = new IntList(new int[] {1, 2, 3, 4});
    players.shuffle();
    int[] p = players.array();
  }

  void display() {
    for (int y=0; y<this.height; y++) {
      for (int x=0; x<this.width; x++) {
        stroke(#000000);
        fill(GameColors.COLORS[matrix[x][y]]);
        rect(x*CELLSIZE, y*CELLSIZE, CELLSIZE, CELLSIZE);
        ;
      }
    }
    int textStart = (BOARDSIZE+1)*CELLSIZE;
    for (Player p : players) {
      textSize(CELLSIZE);
      fill(GameColors.COLORS[p.id]);
      text("Player "+p.id+" remaining="+p.getScore(false), 10, textStart);
      textStart += CELLSIZE;
    }
  }

  boolean placePiece(Piece p, int left, int top) {
    println("placing piece", p.owner);
    this.overlayMatrix(p, left, top);
    p.playAt(new Point(left, top)) ;
    this.firstPlay[p.owner-1] = false;
    return true;
  }


  boolean isPlayable(Player player, Piece piece, int left, int top) {
    int bx, by;
    Point bp = new Point(left, top);

    boolean isFirstCorner = false;
    boolean isOffBoard = false;
    boolean isTaken = false;
    boolean cornerMatch = false;
    boolean edgeMatch = false;
    boolean playable = false;

    for (int y=0; y<piece.height; y++) {
      for (int x=0; x<piece.width; x++) {
        if (piece.getCell(x, y) > 0) {
          bx = left + x;
          by = top + y;
          bp.setLocation(bx, by);
          isOffBoard = isOffBoard || (bx < 0) || (bx >= board.width) || (by < 0) || (by >= board.height);
          if (! isOffBoard) {
            isTaken = isTaken || (board.getCell(bx, by) > 0);
            if (! isTaken) {
              isFirstCorner = isFirstCorner || (firstPlay[piece.owner-1] && bp.equals(PLAYER_CORNERS.get(piece.owner-1)));
              // check that at least one corner matches
              for (Point p : CORNERS) {
                bx = left + x + (int) p.getX(); 
                by = top + y + (int) p.getY();
                if (bx >= 0 && bx < board.width && by >= 0 && by < board.height) {
                  cornerMatch = cornerMatch || (board.getCell(bx, by) == piece.getCell(x, y));
                } else {
                }
              }
              for (Point p : EDGES) {
                bx = left + x + (int) p.getX(); 
                by = top + y + (int) p.getY();
                if (bx >= 0 && bx < board.width && by >= 0 && by < board.height) {
                  edgeMatch = edgeMatch || (board.getCell(bx, by) == piece.getCell(x, y));
                }
              }
            }
          }
        }
      }
    }
    playable = isFirstCorner || (!isOffBoard && !isTaken && cornerMatch && !edgeMatch);
    if (playable) {
      println(piece.asString(), "(", left, top, ")", "isFirst=", isFirstCorner, "offBoard=", isOffBoard, "isTaken=", isTaken, "cornerMatch=", cornerMatch, "edgeMatch=", edgeMatch);
    }
    return playable;
  }
}
