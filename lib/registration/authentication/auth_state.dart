import '../../models/user_model.dart';

abstract class Authstate{}
class AuthInitial extends Authstate{}
class Authenticating extends Authstate{}
class Authenticated extends Authstate{
  final UserModel userdata;

  Authenticated(this.userdata);
}
class AuthenticationFailed extends Authstate{
  String message;
  AuthenticationFailed(this.message);
}
class LoggedOut extends Authstate{}