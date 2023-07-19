abstract class Authstate{}
class AuthInitial extends Authstate{}
class Authenticating extends Authstate{}
class Authenticated extends Authstate{}
class AuthenticationFailed extends Authstate{
  String message;
  AuthenticationFailed(this.message);
}
class LoggedOut extends Authstate{}