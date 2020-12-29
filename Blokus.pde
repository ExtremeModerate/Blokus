static int CELLSIZE=20; //<>//
static int BOARDSIZE=20;

Board board;
ArrayList<Matrix> masterpieces = new ArrayList<Matrix>();
ArrayList<Player> players = new ArrayList<Player>(4);
long exitTime;

void setup() {
  size(1000, 1000);
  board = new Board(BOARDSIZE, BOARDSIZE);
  masterpieces = loadPieces();

  for (int i=1; i<2; i++) {
    players.add(new Player(i, PIECE_COLORS[i-1]));
  }

  for (Matrix m : masterpieces) {
    m.printit();
    println();
    m.rotateRight();
    m.printit();
    println();
  }
  exitTime = millis()+5000;
}

void draw() {
  board.display();
  if (millis() > exitTime) { 
    exit();
  }
}

ArrayList loadPieces() {

  ArrayList<Matrix> pieces = new ArrayList<Matrix>();
  IntList mrow = new IntList();

  Table table= loadTable("pieces.csv");
  Matrix matrix = new Matrix(); // start with empty matrix
  for (TableRow row : table.rows()) {
    //println(row.getColumnCount());
    if (row.getString(0).substring(0, 1).equals("-")) {
      //println("end piece");
      if (matrix.height > 0) {
        pieces.add(matrix);
        matrix = new Matrix();
      }
    } else {
      mrow.clear();
      for (int i=0; i<row.getColumnCount(); i++) {
        if (row.getString(i) != null) {
          mrow.append(row.getString(i).equals("0") ? 0 : 1);
          //print(row.getString(i));
          //print(".");
        }
      }
      if (mrow.size() > 0) {
        matrix.appendRow(mrow.array());
      }
      //println("");
    }
  }
  if (matrix.height > 0) {
    pieces.add(matrix);
  }
  println("Loaded ", pieces.size(), " pieces");
  return pieces;
}
