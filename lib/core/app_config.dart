class AppConfig {
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');

  // API Base URLs
  static const String agreementApiUrl = 'https://loan-agreement-script.onrender.com';
  
  // Auth Redirection URLs
  static const String resetPasswordUrlProd = 'https://primekeyapp-49jj.onrender.com/reset-password';
  static const String resetPasswordUrlDev = 'http://localhost:5000/reset-password';

  static String get resetPasswordUrl => isProduction ? resetPasswordUrlProd : resetPasswordUrlDev;

  // Add other config here
}
