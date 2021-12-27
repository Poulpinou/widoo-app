import 'package:widoo_app/client/ApiClient.dart';
import 'package:widoo_app/client/WidooApiClient.dart';
import 'package:widoo_app/model/Activity.dart';
import 'package:widoo_app/model/dto/request/CreateActivityRequest.dart';
import 'package:widoo_app/model/dto/response/ActivityCountResponse.dart';
import 'package:widoo_app/utils/LoggingUtils.dart';

class ActivityRepository {
  final ApiClient _client = WidooApiClient(basePath: "/activities");

  Future<Activity> getActivity(int id) async {
    final Map<String, dynamic> responseData =
        await _client.get("/" + id.toString());

    try {
      return Activity.fromJson(responseData);
    } catch (e) {
      Log.error("Failed to create activity from response", e);
      rethrow;
    }
  }

  Future<Activity> getRandomActivity() async {
    final Map<String, dynamic> responseData = await _client.get("/random");

    try {
      return Activity.fromJson(responseData);
    } catch (e) {
      Log.error("Failed to create activity from response", e);
      rethrow;
    }
  }

  Future<Activity> getSelectedActivity() async {
    final Map<String, dynamic> responseData = await _client.get("/selected");

    try {
      return Activity.fromJson(responseData);
    } catch (e) {
      Log.error("Failed to create activity from response", e);
      rethrow;
    }
  }

  Future<ActivityCountResponse> getActivityCount() async {
    final Map<String, dynamic> responseData = await _client.get("/count");

    try {
      return ActivityCountResponse.fromJson(responseData);
    } catch (e) {
      Log.error("Failed get count from response", e);
      rethrow;
    }
  }

  Future<void> postActivity(CreateActivityRequest request) async {
    return await _client.post("", body: request.toJson());
  }

  Future<void> endActivity(int activityId) async {
    return await _client.put("/" + activityId.toString() + "/done");
  }

  Future<List<Activity>> getHistory() async {
    final List<dynamic> responseData =
        await _client.get("/history");

    try {
      return responseData.map((data) => Activity.fromJson(data)).toList();
    } catch (e) {
      Log.error("Failed to create activity from response", e);
      rethrow;
    }
  }

  Future<void> selectActivity(int activityId) async {
    return await _client.post("/" + activityId.toString() + "/select");
  }

  Future<void> repeatActivity(int activityId) async {
    return await _client.post("/" + activityId.toString() + "/repeat");
  }
}
