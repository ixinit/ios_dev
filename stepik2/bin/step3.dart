import 'package:stepik2/step3.dart';
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
  //print(sqmatr._matr);

}