import 'package:objectbox/objectbox.dart';
import '../../model/UserModel.dart'; // Import Datum model if it's a separate model
import '../../objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Box<Datum> datumBox; // Ensure you are working with the correct box

  ObjectBox._create(this.store) {
    datumBox = Box<Datum>(store); // Initialize the Datum box
  }

  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }

  // Remove all Datum data
  void removeAllData() {
    datumBox.removeAll(); // Ensure you're clearing the correct data
    print("All data removed from datumBox.");
  }
}
