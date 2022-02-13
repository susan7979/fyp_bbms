import 'package:fyp_bbms/models/blood_request.dart';
import 'package:http/http.dart' as http;

class Services {
  Future<Object> getAllBloodRequest() async {
    try {
      var response = await http.get(Uri.parse(
          "http://192.168.1.79/flutter-login-signup/blood_requests.php"));
      if (response.statusCode == 200) {
        final List<BloodRequest> _bloodRequest =
            bloodRequestFromJson(response.body);
        return _bloodRequest;
      } else {
        return <BloodRequest>[];
      }
    } catch (e) {
      return <BloodRequest>[];
    }
    // setState(() {
    //   _bloodRequest = json.decode(response.body);
    // });
    // // print(_bloodRequest);
    // return _bloodRequest;
  }
}
