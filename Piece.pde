import java.awt.Point;

class Piece extends Matrix {

  int number;
  int owner;
  color pieceColor;
  boolean played;
  Point location;
  HashMap<Integer, PieceOrientation> orientations = new HashMap<Integer, PieceOrientation>();

  Piece(int num, int id, Matrix from) {
    super(from.matrix);
    this.number = num;
    this.played = false;
    this.setOwner(id);
    for (int r=0; r<4; r++) {
      this.setRotation(r);
      for (int f=0; f<2; f++) {
        this.flip(f>0);
        orientations.putIfAbsent(this.hashCode(), new PieceOrientation(r, (f>0)));
      }
    }
  }

  void setOwner(int id) {
    owner = id;
    this.setAllCells(owner, false);  //change all the non-zero values to my owner id
  }

  void setPieceColor(color newColor) {
    pieceColor = newColor;
  }

  void playAt(Point position) {
    this.setPlayed(true);
    this.location = position;
  }

  void unPlay() {
    this.setPlayed(false);
    location.setLocation(-1, -1);
  }

  void setPlayed(boolean value) {
    this.played = value;
  }

  boolean getPlayed() {
    return this.played;
  }

  String asString() {
    //return "Player="+this.owner+", Piece="+this.number;
    return "Piece("+this.owner+", "+this.number+", "+this.played+", "+this.score+")";
  }
}


class PieceOrientation { 
  int rotation;
  boolean flipped;

  PieceOrientation(int rotation, boolean flipped) {
    this.setRotation(rotation);
    this.setFlipped(flipped);
  }

  int getRotation() {
    return rotation;
  }

  boolean getFlipped() {
    return flipped;
  }

  void  setRotation(int value) {
    rotation = constrain(value, 0, 4);
  }

  void setFlipped(boolean value) {
    flipped = value;
  }

  boolean equals(Piece p) {
    return this.hashCode() == p.hashCode();
  }
}
