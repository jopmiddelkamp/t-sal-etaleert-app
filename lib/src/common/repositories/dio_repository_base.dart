import 'package:dio/dio.dart';

typedef RequestFunction = Future<Response> Function();

abstract class DioRepositoryBase {
  final Dio http;
  final String baseUrl;

  const DioRepositoryBase({
    required this.http,
    required this.baseUrl,
  });

  Future<Response> safeRequest(RequestFunction req) async {
    try {
      final resp = await req();
      return resp;
    } on DioError catch (e) {
      // if (e.type == DioErrorType.response &&
      //     e.response?.data is Map<String, dynamic>) {

      //   rethrow;
      // } else {
      rethrow;
      // }
    }
  }

  getApiUrl(
    String resource,
  ) {
    return baseUrl + (resource.startsWith('/') ? resource : '/$resource');
  }

  // void _handleApiError(int statusCode, ApiErrorDTO error) {
  //   if (statusCode == 401 || statusCode == 403) {
  //     return;
  //   }
  //   if (error?.errorCode != null) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       switch (error.errorCode) {
  //         case 'FinishActiveTasksFirst':
  //           DialogUtils.showErrorDialog(
  //             title: (context) => MTPLocalizations.of(context)
  //                 .errorTitleForFinishActiveTasksFirst,
  //             message: (context) => MTPLocalizations.of(context)
  //                 .errorMessageForFinishActiveTasksFirst,
  //           );
  //           break;
  //         case 'TooManyTasksInProgress':
  //           DialogUtils.showErrorDialog(
  //             title: (context) => MTPLocalizations.of(context)
  //                 .errorTitleForTooManyTasksInProgress,
  //             message: (context) => MTPLocalizations.of(context)
  //                 .errorMessageForTooManyTasksInProgress,
  //           );
  //           break;
  //         default:
  //           DialogUtils.showErrorDialog(
  //             title: (context) =>
  //                 MTPLocalizations.of(context).errorTitleForUnknownErrorCode,
  //             message: (context) => MTPLocalizations.of(context)
  //                 .errorMessageForUnknownErrorCode(error.errorDescription),
  //           );
  //           break;
  //       }
  //     });
  //   }
  // }
}
