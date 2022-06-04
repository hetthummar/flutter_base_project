import 'package:objectid/objectid.dart';

class MongoUtils {

  String generateUniqueMongoId(){
    final id = ObjectId();
    return id.hexString;
  }

}
