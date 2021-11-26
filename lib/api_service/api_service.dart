import 'package:http/http.dart' as http;

class ApiService {
  static var client = http.Client();
  static final baseUrl = "https://metizcrm.com/anavya/Api";
  //endpoints
  static final loginEndpoint = "/login";
  static final projectListEndpoint = "/Get_project";
}
