//Создать класс "Matrix". Класс должен иметь следующие переменные:
//
// двумерный массив вещественных чисел;
// количество строк и столбцов в матрице.
// Класс должен иметь следующие методы:
//
// сложение с другой матрицей;
// умножение на число;
// вывод на печать;
// умножение матриц.
// Унаследовать от него класс SquareMatrix, который будет задавать квадратную матрицу. Добавьте этому классу метод determinant, который возвращает определитель матрицы.
//
// Сделайте как можно более удобную и красивую реализацию (в идеале - переопределить методы +, -, *)

class Matrix<T extends num>{
  late List<List<T>> _matr;
  int _columns;
  int _rows;

  int get colums => _columns;
  int get rows => _rows;

  Matrix(this._rows, this._columns, T value){
    List<T> matrRows = <T>[];
    List<List<T>> matrLines = <List<T>>[];
    for(int i = 0 ; i<_columns; i++){
      matrRows.add(value);
    }
    for(int i = 0 ; i<_rows; i++){
      matrLines.add(List.from(matrRows));
    }
    this._matr = matrLines;
  }


  Matrix<T> operator +(Matrix<T> other) {
    if(_rows == other._rows && _columns == other._columns){
      Matrix<T> tmpmatr = Matrix(_rows, _columns, _zero(T));
      for(int i = 0; i < _rows; i++){
        List<T> matrColumns = _matr[i];
        for(int j = 0; j < _columns; j++){
          tmpmatr.setValue(i, j, matrColumns[j]+other.getValue(i, j) as T);
        }
      }
      return tmpmatr;
    }else{
      throw Exception("Different matrix sizes");
    }
  }

  Matrix<T> operator *(Matrix<T> other) {
    if(_columns == other._rows){
      Matrix<T> tmpmatr = Matrix(_rows, other._columns, _zero(T));
      for(int i = 0; i < _rows; i++){
        List<T> matrColumns = _matr[i];
        for(int j = 0; j < other._columns; j++){
          dynamic sum = _zero(T);
          for(int p = 0; p < _columns; p++){
            sum += matrColumns[p]*other.getValue(p, j);
          }
          tmpmatr.setValue(i, j, sum as T);
        }
      }
      return tmpmatr;
    }else{
      throw Exception("Different matrix sizes");
    }
  }

  Matrix<T> multByNum(T value){
    Matrix<T> tmpmatr = Matrix(_rows, _columns, _zero(T));
    for(int i = 0; i < _rows; i++){
      List<T> matrColumns = _matr[i];
      for(int j = 0; j < _columns; j++){
        tmpmatr.setValue(i, j, matrColumns[j]*value as T);
      }
    }
    return tmpmatr;
  }


  dynamic _zero(Type t){
    switch(t) {
      case int: return 0;
      case double: return 0.0;
    }
  }


  setValue(int row, int column, T value){
    if(row < _rows && column < _columns){
      List<T> line = _matr[row];
      line[column] = value;
    }else{
      throw Exception("Incorrect matrix element");
    }
  }

  T getValue(int row, int column){
    if(row < _rows && column < _columns){
      List<T> line = _matr[row];
      return line[column];
    }else{
      throw Exception("Incorrect matrix element");
    }
  }


  String toString(){
    String marts = "";
    for(List<T> line in _matr){
      String linematr = "";
      for(T value in line){
        linematr += value.toString()+"  ";
      }
      marts+=linematr+"\n";
    }
    return marts;
  }

  Matrix<double> toDouble(){
    Matrix<double> temp = Matrix(_rows, _columns, 0.0);
    for(int i = 0; i < _rows; i++){
      List<T> matrColumns = _matr[i];
      for(int j = 0; j < _columns; j++){
        temp.setValue(i, j, matrColumns[j].toDouble());
      }
    }
    return temp;
  }

  void show(){
    print("\n  row $_rows col $_columns");
    print("*"*_columns*3);
    print(toString());
  }

}

class SquareMatrix<T extends num> extends Matrix{

  int _dimension;

  int get dimensions => _dimension;

  SquareMatrix(this._dimension, T value): super(_dimension, _dimension, value);

  T determinant(){
    return _matrixDet(this, _dimension);
  }

  T _matrixDet(SquareMatrix matrix, int size) {
    dynamic det = _zero(T);
    int degree = 1; // (-1)^(1+j) из формулы определителя

    //Условие выхода из рекурсии
    if(size == 1) {
      return matrix.getValue(0, 0) as T;
    }
    //Условие выхода из рекурсии
    else if(size == 2) {
      return matrix.getValue(0, 0) *matrix.getValue(1, 1) - matrix.getValue(0, 1)*matrix.getValue(1, 0) as T;
    } else {
      //Матрица без строки и столбца
      SquareMatrix newMatrix;// = SquareMatrix(size-1, _zero(T));

      //Раскладываем по 0-ой строке, цикл бежит по столбцам
      for(int j = 0; j < size; j++) {
          //Удалить из матрицы i-ю строку и j-ый столбец
          //Результат в newMatrix
          newMatrix = _matrWithoutRowCol(matrix, size, 0, j);

          //Рекурсивный вызов
          //По формуле: сумма по j, (-1)^(1+j) * matrix[0][j] * minor_j (это и есть сумма из формулы)
          //где minor_j - дополнительный минор элемента matrix[0][j]
          // (напомню, что минор это определитель матрицы без 0-ой строки и j-го столбца)
          det = det + (degree * matrix.getValue(0, j) * _matrixDet(newMatrix, size-1));
          //"Накручиваем" степень множителя
          degree = -degree;
      }

    }

    return det;
  }

  SquareMatrix _matrWithoutRowCol(SquareMatrix matrix, int dim, int row, int col){
    SquareMatrix resMatrix = SquareMatrix(dim, _zero(T));
    int offsetRow =0;
    int offsetCol =0;
    for(int i = 0; i < dim-1; i++) {
      //Пропустить row-ую строку
      if(i == row) {
        offsetRow = 1; //Как только встретили строку, которую надо пропустить, делаем смещение для исходной матрицы
      }

      offsetCol = 0; //Обнулить смещение столбца
      for(int j = 0; j < dim-1; j++) {
        //Пропустить col-ый столбец
        if(j == col) {
          offsetCol = 1; //Встретили нужный столбец, проускаем его смещением
        }

        resMatrix.setValue(i, j, matrix.getValue(i+offsetRow,j + offsetCol) as T);
      }
    }
    return resMatrix;
  }

}

/*
void main(){

  Matrix<int> matr = Matrix(3, 5, 7);
  Matrix<double> matr2 = Matrix(3, 5, 3);
  matr = matr.multByNum(0);
  matr2 = matr2.multByNum(0);
  matr.setValue(1, 3, 4);
  matr2.setValue(0, 3, 5);
  matr.show();
  matr2.show();

  Matrix<double> matr3 = matr.toDouble()+matr2;
  matr3.show();
  matr3 = matr.toDouble()+matr2+matr.toDouble();
  matr3.show();
  matr2.show();
  matr.show();

  Matrix<int> mult1 = Matrix(4, 2, 0);
  Matrix<int> mult2 = Matrix(2, 3, 0);

  mult1.setValue(0, 0, 1);
  mult1.setValue(0, 1, 2);
  mult1.setValue(1, 0, 3);
  mult1.setValue(1, 1, 4);
  mult1.setValue(2, 0, 5);
  mult1.setValue(2, 1, 6);
  mult1.setValue(3, 0, 7);
  mult1.setValue(3, 1, 8);

  mult2.setValue(0, 0, 1);
  mult2.setValue(1, 1, 1);
  mult2.setValue(0, 2, 1);

  mult1.show();
  mult2.show();
  (mult1*mult2).show();


  SquareMatrix<double> sqmatr = SquareMatrix(3, 0);
  sqmatr.setValue(0, 0, 1.0);
  sqmatr.setValue(0, 1, 2.0);
  sqmatr.setValue(1, 0, 3.0);
  sqmatr.setValue(1, 1, 4.0);
  sqmatr.setValue(0, 2, 4.0);
  sqmatr.setValue(1, 2, 4.0);
  sqmatr.setValue(2, 2, 4.0);
  sqmatr.setValue(2, 0, 4.0);
  sqmatr.setValue(2, 1, 4.0);

  sqmatr.show();
  print(sqmatr.determinant());
  print(sqmatr.dimensions);
  print(sqmatr.colums);

}*/
