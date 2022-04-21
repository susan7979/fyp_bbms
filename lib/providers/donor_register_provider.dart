import 'package:flutter/cupertino.dart';

import '../api.dart';
import '../models/blood_request.dart';
import 'package:http/http.dart' as http;

import '../models/donor_register.dart';

class DonorRegisterProvider extends ChangeNotifier {
  List<DonorRegister> _donorRegister = [];

  Future<List<DonorRegister>> getAllDonorRegister() async {
    await Future.delayed(Duration(milliseconds: 400));
    try {
      var response = await http.get(Uri.parse(getAllDonorUrl));
      if (response.statusCode == 200) {
        final List<DonorRegister> _donorRegister =
            donorRegisterFromJson(response.body);
        return _donorRegister;
      }
      notifyListeners();
      // print(_donorReg);
      return <DonorRegister>[];
    } catch (e) {
      return <DonorRegister>[];
      // TODO
    }
  }
}
