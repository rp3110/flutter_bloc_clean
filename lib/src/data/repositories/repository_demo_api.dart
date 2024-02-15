import '../../utils/api_service/api_provider.dart';

class RepositoryDemoApi {
  Future callGetMethod(String url) async {
    return await APIManager.instance
        .getRequest(
      requestURL: url,
      isAuthRequired: true,
    );
  }
}
