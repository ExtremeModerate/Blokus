 //<>//
class Player {
  int id;
  int colornum;
  color pieceColor;
  //ArrayList<Piece> remaining = new ArrayList<Piece>(masterpieces.size());
  //ArrayList<Piece> played = new ArrayList<Piece>(0);

  HashMap<Integer, Piece> pieces = new HashMap<Integer, Piece>(masterpieces.size());
  IntList unplayed = new IntList();
  IntList played = new IntList();

  Player(int iid, color icolor) {
    id = iid;
    pieceColor = icolor;
    for (int i = 0; i<masterpieces.size(); i++) {
      pieces.put(i, new Piece(i, id, masterpieces.get(i)));
      unplayed.append(i);
    }
  }

  void playPiece(int number) {
    pieces.get(number).setPlayed(true);
    played.append(number);
    deleteFromList(unplayed, number);
  }

  void deleteFromList(IntList list, int value) {
    while (list.hasValue(value)) {
      for (int i=0; i<list.size(); i++) {
        if (list.get(i) == value) {
          list.remove(i);
          break;
        }
      }
    }
  }

  void print() {
    System.out.println("Player "+id+" color "+pieceColor);
    for (int k : pieces.keySet()) {
      System.out.println("Player "+ id +" Piece " + pieces.get(k).number + " " + str(pieces.get(k).played));
    }
  }
}
