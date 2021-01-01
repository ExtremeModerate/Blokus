import java.awt.Point;

class Piece extends Matrix {
  
  int number;
  int owner;
  color pieceColor;
  boolean played;
  Point location;
  
  Piece(int num, int id, Matrix from) {
    super(from.matrix);
    this.number = num;
    this.played = false;
    this.setOwner(id);
  }
  
  void setOwner(int id){
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
    location.setLocation(-1,-1);
  }
  
  void setPlayed(boolean value) {
    this.played = value;
  }
  
  boolean getPlayed() {
    return this.played;
  }

}
