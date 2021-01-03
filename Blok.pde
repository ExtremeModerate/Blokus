public class Blok {
  public static final int EMPTY = 0;  //this is an empty block, so always true comparison
  public static final int MUST_MATCH=1; //the value of the comparison must match my value
  public static final int MUST_NOT_MATCH=2;  //the value of the comparison must not match my ID
  public static final int MUST_BE_ZERO = 3;   //the value of the comparison must be zero


  int value;
  int blokType;

  Blok(int value, int type) {
    this.value = value;
    this.blokType = type;
  }

  int get() {
    return this.value;
  }

  int getType() {
    return this.blokType;
  }

  void set(int value) {
    this.value = value;
  }

  void setType(int type) {
    this.blokType = type;
  }

  boolean compare(int otherValue) {
    switch (blokType) {
    case Blok.EMPTY:
      return true;
    case Blok.MUST_MATCH:
      return (this.value == otherValue);
    case Blok.MUST_NOT_MATCH:
      return (this.value != otherValue);
    case Blok.MUST_BE_ZERO:
      return (otherValue == 0);
    default:
      return false;
    }
  }
}
