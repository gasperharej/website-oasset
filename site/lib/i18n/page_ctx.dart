import 'lang.dart';

class PageCtx {
  final Lang lang;
  final String enPath; // router path like "/pricing"
  final String slPath; // router path like "/sl/pricing"
  const PageCtx({required this.lang, required this.enPath, required this.slPath});
}