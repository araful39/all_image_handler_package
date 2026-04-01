import 'package:all_image_handler/all_image_handler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AllImageController reload increments reloadKey', () {
    final controller = AllImageController();
    expect(controller.reloadKey, 0);
    controller.reload();
    expect(controller.reloadKey, 1);
  });
}
