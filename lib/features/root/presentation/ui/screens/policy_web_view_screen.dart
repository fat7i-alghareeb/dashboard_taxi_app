import 'package:dashboardtaxi/common/imports/imports.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Renders a hosted legal document (terms, privacy policy) inside the app.
///
/// The document lives on the public website and is shown here so it can be
/// corrected without an app release and nine translations.
class PolicyWebViewScreen extends StatefulWidget {
  const PolicyWebViewScreen({
    required this.title,
    required this.url,
    super.key,
  });

  final String title;
  final String url;

  @override
  State<PolicyWebViewScreen> createState() => _PolicyWebViewScreenState();
}

class _PolicyWebViewScreenState extends State<PolicyWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onWebResourceError: (error) {
            printC('[PolicyWebView] error: ${error.description}');
            // Drop the spinner either way — leaving it up on a failed load looks
            // like the page is still coming.
            if (mounted) setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold.appBar(
      appBarConfig: AppScaffoldAppBarConfig(title: widget.title),
      child: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading) const Center(child: MainLoadingProgress()),
        ],
      ),
    );
  }
}
