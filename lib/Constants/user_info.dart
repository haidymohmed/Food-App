import '../Data/LocalStorage/db_helper_sharedPrefrences.dart';
import '../Data/Models/User.dart';

late UserDetails customerData = UserDetails(
    name  : CacheHelper.getString("userName"),
    id  : CacheHelper.getString("userId"),
    pass  : CacheHelper.getString("userPassword"),
    email  : CacheHelper.getString("userEmail"),
    phone  : CacheHelper.getString("userPhone"),
);