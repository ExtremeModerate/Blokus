class Matrix { //<>// //<>// //<>//
  public static final int RIGHT = 1;
  public static final int LEFT = -1;

  public int width, height;
  public int score=0;
  public int[][] matrix;
  //public Blok[][] blocks;
  public int rotation = 0;
  public boolean flipped = false;

  Matrix(int x, int y) {
    this.width = (x<0 ? 0 : x);
    this.height = (y<0 ? 0 : y);
    matrix = new int[this.width][this.height];
  }

  Matrix() {
    this(0, 0);
  }

  Matrix(int[][] grid) {
    this(grid.length, grid[0].length);  //first row size determins width
    for (int y=0; y<this.height; y++) {
      for (int x=0; x<this.width; x++) {
        this.setCell(x, y, grid[x][y]);
      }
    }
    setScore();
  }

  // Initialize with a string that's w*h characters - initializes left to right, top to bottom (0,0)-(w,h)
  Matrix(int w, int h, String grid) {
    if (grid.length() != w*h) throw new ArrayIndexOutOfBoundsException("String grid size must match given width and height");

    this.width = w;
    this.height=h;
    matrix = new int[this.width][this.height];
    for (int y=0; y<this.height; y++) {
      for (int x=0; x<this.width; x++) {
        matrix[x][y] = (grid.charAt((y*this.width)+x) == '1' ? 1 : 0);
      }
    }
    setScore();
  }

  void setScore() {
    score = 0;
    for (int y=0; y<this.height; y++) { //<>//
      for (int x=0; x<this.width; x++) {
        score += (matrix[x][y] == 0 ? 0 : 1);
      }
    }
  }

  void setCell(int x, int y, int value) {
    if (x>=0 && x<this.width && y>=0 && y<this.height) {
      matrix[x][y] = value;
      setScore();
    } else {
      throw new ArrayIndexOutOfBoundsException("setCell outside of Matrix");
    }
  }

  int getCell(int x, int y) {
    if (x>=0 && x<this.width && y>=0 && y<this.height) {
      return matrix[x][y];
    } else {
      throw new ArrayIndexOutOfBoundsException("getCell outside of Matrix");
    }
  }

  void overlayMatrix(Matrix m, int left, int top) {
    for (int y=0; y<m.height; y++) {
      for (int x=0; x<m.width; x++) {
        if (left+x < this.width && top+y < this.height && m.getCell(x, y)!=0) {
          this.setCell(left+x, top+y, m.getCell(x, y));
        }
      }
    }
    setScore();
  }

  void replace(Matrix newMatrix) {
    this.width = newMatrix.width;
    this.height = newMatrix.height;
    setRotation(newMatrix.rotation);
    flip(newMatrix.flipped);
    this.matrix = newMatrix.matrix;
    setScore();
  }

  // Sets all cells to an absolute value
  void setAllCells(int value) {
    this.setAllCells(value, true);
  }

  void setAllCells(int value, boolean allCells) {
    for (int y=0; y<this.height; y++) {
      for (int x=0; x<this.width; x++) {
        if (allCells || (!allCells && matrix[x][y] != 0)) {
          matrix[x][y] = value;
        }
      }
    }
    setScore();
  }

  void rotateRight() {
    int nw = this.height;
    int nh = this.width;
    int[][] nmatrix = new int[nw][nh];

    for (int y=0; y<this.height; y++) {
      for (int x=0; x<this.width; x++) {
        nmatrix[nw-y-1][x] = matrix[x][y];
      }
    }
    this.width = nw;
    this.height = nh;
    matrix = nmatrix;
  }

  void rotateLeft() {
    int nw = this.height;
    int nh = this.width;
    int[][] nmatrix = new int[nw][nh];

    for (int y=0; y<this.height; y++) {
      for (int x=0; x<this.width; x++) {
        nmatrix[y][nh-x-1] = matrix[x][y];
      }
    }
    this.width = nw;
    this.height = nh;
    matrix = nmatrix;
  }

  void flip() {
    this.flip(!flipped);
  }

  void flip(boolean flipTo) {
    int hold;
    if (this.flipped == flipTo) return;

    for (int y=0; y<this.height; y++) {
      for (int x=0; x<floor(this.width/2); x++) {
        hold = matrix[this.width-x-1][y]; 
        //println("before ", x, y, matrix[x][y], matrix[this.width-x-1][y]);
        matrix[this.width-x-1][y] = matrix[x][y];
        matrix[x][y] = hold;
        //println("after ", x, y, matrix[x][y], matrix[this.width-x-1][y]);
      }
    }
    flipped = !flipped;
  }


  void setRow(int y, int[] values) {
    if (y>=0 && y<this.height && values.length==this.width) {
      for (int x=0; x<this.width; x++) {
        matrix[x][y] = values[x];
      }
    }
    setScore();
  }

  void randomize(int low, int high) {
    for (int y=0; y<this.height; y++) {
      for (int x=0; x<this.width; x++) {
        matrix[x][y] = int(random(low, high+1));
      }
    }
    setScore();
  }

  void appendRow(int[] values) {
    int nw = this.width;
    int nh = this.height+1;

    if (nw == 0 && values.length >0) {
      nw = values.length;
    } 
    if (values.length==nw) {
      int[][] nmatrix = new int[nw][nh];
      for (int y=0; y<this.height; y++) {
        for (int x=0; x<this.width; x++) {
          nmatrix[x][y] = matrix[x][y];
        }
      }
      for (int x=0; x<nw; x++) {
        nmatrix[x][nh-1] = values[x];
      }
      this.width = nw;
      this.height = nh;
      matrix = nmatrix;
    }
    setScore();
  }

  void rotate(int direction) {
    int nw = this.height;
    int nh = this.width;
    int[][] nmatrix = new int[nw][nh];

    if (direction == 0) return;  //don't rotate

    for (int y=0; y<this.height; y++) {
      for (int x=0; x<this.width; x++) {
        if (direction > 0) {
          nmatrix[nw-y-1][x] = matrix[x][y];
        } else if (direction < 0) {
          nmatrix[y][nh-x-1] = matrix[x][y];
        }
      }
    }

    this.width = nw;
    this.height = nh;
    matrix = nmatrix;
    rotation += direction/abs(direction);
    if (rotation < 0) rotation = 3;
    if (rotation > 3) rotation = 0;
  }

  void setRotation(int rotation) {
    rotation = constrain(rotation, 0, 4);
    //if (position >= 0 && position <=3) {
    while (this.rotation != rotation) {
      this.rotate(rotation > this.rotation ? Matrix.RIGHT : Matrix.LEFT);
      //}
    }
  }


  void print() {
    for (int y=0; y<this.height; y++) {
      for (int x=0; x<this.width; x++) {
        //print(matrix[x][y]);
        //print((matrix[x][y] == 0) ? ' ' : str(matrix[x][y]));
        //System.out.print((matrix[x][y] == 0) ? "  " : "[]");
        System.out.print((matrix[x][y] == 0) ? "[ ]" : "["+str(matrix[x][y])+"]");
      }
      System.out.println();
    }
  }

  boolean AND(Matrix other) {
    for (int y=0; y<min(this.height, other.height); y++) {
      for (int x=0; x<min(this.width, other.width); x++) {
        if (this.getCell(x, y) !=0 && other.getCell(x, y) !=0) {
          return true;
        }
      }
    }
    return false;
  }

  boolean equals(Matrix other) {
    boolean result=true;
    if (this.height != other.height || this.width != other.width) return false;
    for (int y=0; y<this.height; y++) {
      for (int x=0; x<this.width; x++) {
        result = result &&( this.getCell(x, y) == other.getCell(x, y));
      }
    }
    return result;
  }

  Matrix subMatrix(int left, int top, int w, int h) {
    if (left < 0 || top < 0 || left+w-1 > this.width || top+h-1 > this.height) {
      throw new ArrayIndexOutOfBoundsException("subMatrix outside of original Matrix boundaries");
    }

    Matrix m = new Matrix(w, h);
    for (int y=0; y<h; y++) {
      for (int x=0; x<w; x++) {
        m.setCell(x, y, this.getCell(left+x, top+y));
      }
    }
    return m;
  }

  int hashCode() {
    long hash=0;
    for (int y=0; y<this.height; y++) {
      for (int x=0; x<this.width; x++) {
        hash = hash << 1 | (this.matrix[x][y] == 0 ? 0 : 1);
      }
      hash = hash << 1;
    }
    return (int) hash;
  }
}
