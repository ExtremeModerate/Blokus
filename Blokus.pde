static final int CELLSIZE=30; //<>//
static final int BOARDSIZE=20;
static final int AUTO_EXIT = 50000;
static final int PLAY_DELAY = 1000;

interface GameColors {
  public static final color EMPTY = #EEEEEE;
  public static final color RED = #EE0000;
  public static final color GREEN = #00EE00;
  public static final color BLUE = #0000EE;
  public static final color YELLOW = #EEEE00;
  public static final color[] COLORS = {GameColors.EMPTY, GameColors.RED, GameColors.GREEN, GameColors.BLUE, GameColors.YELLOW};
}

Board board = new Board(BOARDSIZE);
ArrayList<Matrix> masterpieces = new ArrayList<Matrix>();
ArrayList<Player> players = new ArrayList<Player>(4);

int playTimer=0;
int currentPlayer = 0;

void setup() {
  size(1000, 1000);

  //board.randomize(0,4);
  masterpieces = loadPieces();

  for (int i=0; i<4; i++) {
    players.add(new Player(i+1, GameColors.COLORS[i]));
  }

  //for (Player player : players) {
  //  for (int i=0; i<player.pieces.size(); i++) {
  //    board.placePiece(player.pieces.get(i), int(random(board.width)), int(random(board.height)));
  //  }
  //  player.print();
  //}
  //Player player = players.get(0);
  //board.placePiece(player.remaining.get(5), 5,5);
  //player.remaining.get(5).print();

  //for (Matrix m : masterpieces) {
  //  m.print();
  //  println();
  //  m.rotateRight();
  //  m.print();
  //  println();
  //}
}

void draw() {

  board.display();

  if (millis() > playTimer) {
    //board.rotate(1);
    Piece piece = players.get(currentPlayer).pieces.get(14);
    if (random(3) == 1) piece.rotate(1);
    int x=int(random(board.width));
    int y = int(random(board.height));
    if (board.placePiece(piece, x, y)) {
      println("piece " + piece.owner + "," + piece.number + " played at "+x+","+y);
    } else {
      piece.rotate(1);
      if (random(3) == 1) piece.flip();
      println("NOT PLAYED piece " + piece.owner + "," + piece.number + " played at "+x+","+y);
    }
    playTimer = millis()+1000;
    println(millis(), playTimer);
    currentPlayer++;
    if (currentPlayer >= players.size()) currentPlayer = 0;
  }

  if (millis() > AUTO_EXIT) { 
    exit();
  }
}

ArrayList loadPieces() {

  ArrayList<Matrix> pieces = new ArrayList<Matrix>();
  IntList mrow = new IntList();

  Table table= loadTable("pieces.csv");
  Matrix matrix = new Matrix(); // start with empty matrix
  for (TableRow row : table.rows()) {
    if (row.getString(0).substring(0, 1).equals("-")) {
      if (matrix.height > 0) {
        pieces.add(matrix);
        matrix = new Matrix();
      }
    } else {
      mrow.clear();
      for (int i=0; i<row.getColumnCount(); i++) {
        if (row.getString(i) != null) {
          mrow.append(row.getString(i).equals("0") ? 0 : 1);
        }
      }
      if (mrow.size() > 0) {
        matrix.appendRow(mrow.array());
      }
    }
  }
  if (matrix.height > 0) {
    pieces.add(matrix);
  }
  println("Loaded ", pieces.size(), " pieces");
  return pieces;
}
