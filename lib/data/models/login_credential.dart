class LoginCredential {
  final String name;
  final String password;

  LoginCredential(this.name, this.password);

  @override
  bool operator ==(Object other) {
    return (other is LoginCredential) &&
        other.name == name &&
        other.password == password;
  }
  
}
