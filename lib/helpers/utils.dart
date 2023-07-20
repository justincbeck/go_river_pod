import 'dart:math';

int getFakeMillis({int min = 1000, int max = 2000}) {
  return min + Random().nextInt(max - min);
}
