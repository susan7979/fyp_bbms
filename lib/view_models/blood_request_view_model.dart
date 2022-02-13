import 'package:flutter/cupertino.dart';
import 'package:fyp_bbms/models/blood_request.dart';
import 'package:http/http.dart' as http;

class BloodRequestViewModel extends ChangeNotifier {
  bool _loading = false;
  List<BloodRequest> _bloodRequestList = [];

  bool get loading => _loading;
  List<BloodRequest> get bloodRequestList => _bloodRequestList;

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setBloodRequestList(List<BloodRequest> bloodRequestList) {
    _bloodRequestList = bloodRequestList;
  }

  getAllBloodRequest() async {
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
