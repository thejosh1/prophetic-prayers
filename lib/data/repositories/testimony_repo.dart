import 'package:get/get.dart';
import 'package:prophetic_prayers/services/testimony_services.dart';

import '../api/apiclient.dart';

class TestimonyRepo extends GetxService{
  final ApiClient apiClient;

  TestimonyRepo({required this.apiClient});

  Future<Response> getTestimonies() async {
    return await apiClient.getData("");
  }
}