
class Piece extends Matrix {
  
  int number;
  int owner;
  color pieceColor;
  boolean played;
  
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
  
  void setPlayed(boolean value) {
    this.played = value;
  }

}
