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

  boolean tryToPlay(Board board) {
    //every piece
    //  every rotation
    //    every flipped
    //      
    List<Piece> randomPieces = new ArrayList<Piece>(pieces.values());
    Collections.shuffle(randomPieces);

    for (Piece p : randomPieces) {
      if (!p.played) {
        println("Piece #", p.number);
        for (Integer k : p.orientations.keySet()) {
          PieceOrientation po = p.orientations.get(k);
          //println(k, po.rotation, po.flipped);
          p.setRotation(po.rotation);
          p.flip(po.flipped);
          Collections.shuffle(xList);
          Collections.shuffle(yList);
          for (int y : yList) {
            for (int x : xList) {
              if (board.isPlayable(this, p, x, y)) {
                board.placePiece(p, x, y);
                p.playAt(new Point(x, y));
                return true;
              }
            }
          }
        }
        //p.print();
      }
    }
      return false;
  }

  int getScore(boolean played) {
    int score=0;
    for (Piece p : this.pieces.values()) {
      if (p.played == played) score += p.score;
    }
    return score;
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
