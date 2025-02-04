import 'package:dio/dio.dart';
import 'package:tally_connector/api/api.dart';

class ApiRepository {
  API api = API();
  Future<dynamic> connectTally(dynamic data) async {
    try {
      var response = await api.sendRequest.post(
        'TallyService',
        data: data,
      );
      //final body = jsonDecode(response.data);
      if (response.statusCode == 200) {
        return response; // Display response from Tally
      } else {
        throw "Failed to fetch data from Tally. Status code: ${response.statusCode}";
      }
    } on DioException catch (ex) {
      if (ex.response?.statusCode == 401) {
        // PrefData.clearStorage();

        // Get.offAll(EmptyState());
      }

      rethrow;
    } catch (ex) {
      return false;
    }
  }
}
