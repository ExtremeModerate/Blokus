class Matrix { //<>//
  int width, height;
  int[][] matrix;

  Matrix() {
    width = 0;
    height = 0;
    matrix = null;
  }

  Matrix(int x, int y) {
    width = (x<0 ? 0 : x);
    height = (y<0 ? 0 : y);
    matrix = new int[width][height];
  }

  void rotateRight() {
    int nw = height;
    int nh = width;
    int[][] nmatrix = new int[nw][nh];

    for (int y=0; y<height; y++) {
      for (int x=0; x<width; x++) {
        nmatrix[nw-y-1][x] = matrix[x][y];
      }
    }
    width = nw;
    height = nh;
    matrix = nmatrix;
  }

  void rotateLeft() {
    int nw = height;
    int nh = width;
    int[][] nmatrix = new int[nw][nh];

    for (int y=0; y<height; y++) {
      for (int x=0; x<width; x++) {
        nmatrix[y][nh-x-1] = matrix[x][y];
      }
    }
    width = nw;
    height = nh;
    matrix = nmatrix;
  }

  void setRow(int y, int[] values) {
    if (y>=0 && y<height && values.length==width) {
      for (int x=0; x<width; x++) {
        matrix[x][y] = values[x];
      }
    }
  }

  void appendRow(int[] values) {
    int nw = width;
    int nh = height+1;

    if (nw == 0 && values.length >0) {
      nw = values.length;
    } 
    if (values.length==nw) {
      int[][] nmatrix = new int[nw][nh];
      for (int y=0; y<height; y++) {
        for (int x=0; x<width; x++) {
          nmatrix[x][y] = matrix[x][y];
        }
      }
      for (int x=0; x<nw; x++) {
        nmatrix[x][nh-1] = values[x];
      }
      width = nw;
      height = nh;
      matrix = nmatrix;
    }
  }

  void printit() {
    for (int y=0; y<height; y++) {
      for (int x=0; x<width; x++) {
        //print(matrix[x][y]);
        //print((matrix[x][y] == 0) ? ' ' : str(matrix[x][y]));
        print((matrix[x][y] == 0) ? "  " : "[]");
      }
      println();
    }
  }
}
