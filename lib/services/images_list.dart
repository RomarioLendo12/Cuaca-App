import 'dart:math';

class ImageList {
  List<int> image = [1, 2, 3, 4, 5, 6];

  int getImage() {
    int takeImage = image[Random().nextInt(6)];
    return takeImage;
  }
}
