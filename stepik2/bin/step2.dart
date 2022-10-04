import 'dart:io';

void main(){

  int a = readInt();
  int b = readInt();
  int c = readInt();

  print(area(a,b,c));

}

int area(int a, int b, int c){
  return 2*((a*b)+(b*c)+(a*c));
}

int readInt(){
  var temp = (stdin.readLineSync() ?? "");
  return int.tryParse(temp) ?? -1;
}
