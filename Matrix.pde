class Matrix { //<>// //<>//
  public static final int RIGHT = 1;
  public static final int LEFT = -1;

  public int width, height;
  public int[][] matrix;
  public int rotation = 0;

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
  }

  void setCell(int x, int y, int value) {
    if (x>=0 && x<this.width && y>=0 && y<this.height) {
      matrix[x][y] = value;
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

  void addMatrix(Matrix m, int left, int top) {
    for (int y=0; y<m.height; y++) {
      for (int x=0; x<m.width; x++) {
        if (left+x < this.width && top+y < this.height) {
          this.setCell(left+x, top+y, m.getCell(x, y));
        }
      }
    }
  }

  void replace(Matrix newMatrix) {
    this.width = newMatrix.width;
    this.height = newMatrix.height;
    this.matrix = newMatrix.matrix;
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

  void setRow(int y, int[] values) {
    if (y>=0 && y<this.height && values.length==this.width) {
      for (int x=0; x<this.width; x++) {
        matrix[x][y] = values[x];
      }
    }
  }

  void randomize(int low, int high) {
    for (int y=0; y<this.height; y++) {
      for (int x=0; x<this.width; x++) {
        matrix[x][y] = int(random(low, high+1));
      }
    }
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

  void rotateTo(int position) {
    int pos = constrain(position, 0, 3);
    //if (position >= 0 && position <=3) {
    while (rotation != pos) {
      this.rotate(pos > rotation ? Matrix.RIGHT : Matrix.LEFT);
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
}
