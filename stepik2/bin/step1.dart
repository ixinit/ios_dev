import 'dart:io';
import 'dart:math';
void main(){

  double distance = 0;

  var startP = readPoint();
  int N = int.tryParse(stdin.readLineSync() ?? '-1') ?? -1;
  for(int i = 0; i<N; i++){
    var tempPoint = readPoint();
    var tempdist = startP.distanceTo(tempPoint);
    if(i==0){
      distance = tempdist;
    }else{
      if(distance-tempdist>0.001){
        distance = tempdist;
      }
    }
  }
  print(distance);
}

Point readPoint(){
  var temp = (stdin.readLineSync() ?? "").split(' ');
  return Point(int.tryParse(temp[0]) ?? 0, int.tryParse(temp[1]) ?? 0);
}

class Point {
  final int x;
  final int y;

  /// Creates a point with the provided [x] and [y] coordinates.
  const Point(int x, int y)
      : this.x = x,
        this.y = y;

  double distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}