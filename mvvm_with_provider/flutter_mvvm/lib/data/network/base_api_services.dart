abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url); //for get api
  Future<dynamic> getPostApiResponse(String url, dynamic data); //for post api
}
