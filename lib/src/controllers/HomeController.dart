import 'package:dio/dio.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController {

  final Dio dio = Dio();

  final originalUrl = RxNotifier<String>('');
  final shortenedUrl = RxNotifier<String>('');
  final showData = RxNotifier<bool>(false);
  final isProcessingUrl = RxNotifier<bool>(false);

  Future<void> createShortenedUrl(String url) async {
    Response response = await dio.post(
      'https://uvvszaca6s.us-west-2.awsapprunner.com/create_shortened_url',
      data: {'url': url},

    );

    await Future.delayed(const Duration(seconds: 2));
    showData.value = true;
    originalUrl.value = url;
    isProcessingUrl.value = false;
    shortenedUrl.value = response.data.toString();
  }

  void openShortenedUrl(String shortenedRrl) async {
    final Uri url = Uri.parse(shortenedRrl);
    await launchUrl(url);
  }



}