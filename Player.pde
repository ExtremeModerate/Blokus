
class Player {
  int id;
  int colornum;
  color pieceColor;
  ArrayList<Piece> remaining = new ArrayList<Piece>(masterpieces.size());
  ArrayList<Piece> played = new ArrayList<Piece>(0);
  
  Player(int iid, color icolor) {
    id = iid;
    pieceColor = icolor;
    for (Matrix m : masterpieces) {
      remaining.add(new Piece(m)); //<>//
    }
  }
}
