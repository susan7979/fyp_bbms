import 'package:flutter/material.dart';
import 'package:fyp_bbms/models/blood_request.dart';
import 'package:fyp_bbms/models/donor_register.dart';
import 'package:http/http.dart' as http;

class BloodRequestDetails extends StatefulWidget {
  const BloodRequestDetails({Key? key}) : super(key: key);

  @override
  State<BloodRequestDetails> createState() => _BloodRequestDetailsState();
}

class _BloodRequestDetailsState extends State<BloodRequestDetails> {
  List<BloodRequest> _bloodRequest = [];
  List<DonorRegister> _donorRegister = [];
  bool _loading = true;

  Future<List<BloodRequest>> getAllBloodRequest() async {
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

  Future<List<DonorRegister>> getAllDonorRegister() async {
    try {
      var response = await http.get(Uri.parse(
          "http://192.168.1.79/flutter-login-signup/donor_register.php"));
      if (response.statusCode == 200) {
        final List<DonorRegister> _donorRegister =
            donorRegisterFromJson(response.body);
        return _donorRegister;
      }
      // print(_donorReg);
      return <DonorRegister>[];
    } catch (e) {
      return <DonorRegister>[];
      // TODO
    }
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loading = true;
    getAllBloodRequest().then((bloodRequest) {
      setState(() {
        _bloodRequest = bloodRequest;
        _loading = false;
      });
    });
    getAllDonorRegister().then((donorRegister) {
      setState(() {
        _donorRegister = donorRegister;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    BloodRequest bloodRequest = _bloodRequest[_selectedIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ' + bloodRequest.name),
          ],
        ),
      ),
    );
  }
}
