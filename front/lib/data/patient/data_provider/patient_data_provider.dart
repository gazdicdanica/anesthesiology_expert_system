import 'package:front/constant.dart';
import 'package:front/custom_exception.dart';
import 'package:front/data/shared_pref/repository/shared_pref_repository.dart';
import 'package:http/http.dart' as http;

class PatientDataProvider {

  final SharedPrefRepository _sharedPrefRepository;

  PatientDataProvider(this._sharedPrefRepository);

  Future<String?> findByJmbg(String jmbg) async {
    final token = await _sharedPrefRepository.getToken();
    final res = await http.get(Uri.parse("${path}patient/find?jmbg=$jmbg"), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    });

    if (res.statusCode == 200) {
      return res.body;
    } 
    else if(res.statusCode == 404){
      return Future(() => null);
    } 
    else {
      throw CustomException(res.body);
    }
  }
}