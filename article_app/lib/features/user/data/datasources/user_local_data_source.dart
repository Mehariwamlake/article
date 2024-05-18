
import 'package:article_app/features/user/data/models/user_model.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getLastUser();
  Future<void> cacheUser(UserModel userToCache);

}

