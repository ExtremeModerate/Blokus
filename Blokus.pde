//import java.io.PrintStream; //<>//
//import java.io.FileOutputStream;
import java.io.*; 
import java.util.*; 

static final int CELLSIZE=30;
static final int BOARDSIZE=20;
static final int AUTO_EXIT = 500000;
static final int PLAY_DELAY = 10000;

interface GameColors {
  public static final color BACKGROUND = #FFFFFF;
  public static final color EMPTY = #EEEEEE;
  public static final color RED = #EE0000;
  public static final color GREEN = #00EE00;
  public static final color BLUE = #0000EE;
  public static final color YELLOW = #EEEE00;
  public static final color[] COLORS = {GameColors.EMPTY, GameColors.RED, GameColors.GREEN, GameColors.BLUE, GameColors.YELLOW};
}

Board board = new Board(BOARDSIZE);
Integer[] range = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19};
List<Integer> xList = Arrays.asList(range);
List<Integer> yList = Arrays.asList(range);

ArrayList<Matrix> masterpieces = new ArrayList<Matrix>();
ArrayList<Player> players = new ArrayList<Player>(4);

int playTimer=0;
int currentPlayer = 0;
int currentPiece = 0;
int playLeft = 0;
int playTop = 0;
boolean nextPlay = true;
int playedPieces;
boolean gameOver = false;

void setup() {
  size(1000, 1000);
  //try {
  //  PrintStream out = new PrintStream(new FileOutputStream("output.txt"));
  //  System.setOut(out);
  //}
  //catch (Exception e) {
  //  exit();
  //}

  //board.randomize(0,4);
  masterpieces = loadPieces();

  for (int i=0; i<4; i++) {
    players.add(new Player(i+1, GameColors.COLORS[i]));
  }

  int totalOrientations = 0;
  for (Piece p : players.get(2).pieces.values()) {
    println("Piece #", p.number, p.score);
    for (Integer k : p.orientations.keySet()) {
      totalOrientations++;
      PieceOrientation po = p.orientations.get(k);
      println(k, po.rotation, po.flipped);
      p.setRotation(po.rotation);
      p.flip(po.flipped);
      p.print();
    }
    println("-----");
  }
  println("Total ", totalOrientations);

  //exit();
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

  fill(GameColors.BACKGROUND);
  rect(0, 0, width, height);
  board.display();
  if (gameOver) {
    textSize(CELLSIZE);
    fill(#000000);
    text("GAME OVER", 10, 800);
  }

  if (currentPlayer ==0 ) {
    playedPieces = 0;
  }
  if (! gameOver && nextPlay) {
    //nextPlay = false;
    //board.rotate(1);
    if (players.get(currentPlayer).tryToPlay(board)) {
      playedPieces += 1;
    }

    //for (int y=0; y<board.height; y++) {
    //  for (int x=0; x<board.width; x++) {  
    //    boolean hasPlayed = false;
    //    while (! hasPlayed)
    //      currentPiece = int(random(players.get(currentPlayer).unplayed.size())) boolean board.isPlayable(piece
    //        for (currentPiece = 0; currentPiece < players.get(currentPlayer).unplayed.size(); currentPiece++) {
    //        Piece piece = players.get(currentPlayer).pieces.get(currentPiece);
    //        if (board.isPlayable(piece, x, y)) {
    //          board.placePiece(piece, x, y);
    //        } else {
    //          println(currentPlayer, currentPiece, x, y, " not played");
    //        }
    //      }
    //  }
    //}

    ////if (random(3) == 1) piece.rotate(1);
    //int x=int(random(board.width));
    //int y = int(random(board.height));
    //if (board.placePiece(piece, x, y)) {
    //  println("piece " + piece.owner + "," + piece.number + " played at "+x+","+y);
    //} else {
    //  piece.rotate(1);
    //  if (random(3) == 1) piece.flip();
    //  println("NOT PLAYED piece " + piece.owner + "," + piece.number + " played at "+x+","+y);
    //}

    playTimer = millis()+PLAY_DELAY;
    currentPlayer++;
    if (currentPlayer >= players.size()) {
      currentPlayer = 0;
      gameOver = (playedPieces == 0);
    }
  }

  if (millis() > AUTO_EXIT) { 
    exit();
  }
}

void keyPressed() {
  nextPlay = !nextPlay && (key ==' ');
}

void keyReleased() {
  nextPlay = nextPlay && (key == ' ');
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
