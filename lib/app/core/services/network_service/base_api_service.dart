import 'package:clean_architecture_example_app/app/core/services/network_service/entities/file_entity.dart';
import 'package:clean_architecture_example_app/app/core/services/network_service/entities/loader_entity.dart';



abstract class BaseApiService {

  // for graphql api
  Future requestGraphQL({
    required String baseUrl,
    required String query,
    Map<String, String>? headers,
  });
  Future requestGET(
      {required ApiRouteEntity apiRoute,
      required Map<String, String>? headers});

  Future requestPOST(
      {required ApiRouteEntity apiRoute,
      Object? data,
      Map<String, String>? headers});

  Future requestPUT(
      {required ApiRouteEntity apiRoute,
      Object? data,
      required Map<String, String>? headers});

  Future requestDELETE(
      {required ApiRouteEntity apiRoute,
      Object? data,
      required Map<String, String>? headers});

  Future requestMultiPartPOST({
    required List<FileEntity> files,
    required ApiRouteEntity apiRoute,
    Map<String, String>? data,
    required Map<String, String> headers,
  });

  Future requestMultiPartPUT({
    required List<FileEntity> files,
    required ApiRouteEntity apiRoute,
    Map<String, String>? data,
    required Map<String, String> headers,
  });
}
