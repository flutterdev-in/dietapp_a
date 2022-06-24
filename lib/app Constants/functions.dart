String hostNameFromUrl(String url) {
  var uri = Uri.parse(url);
  return uri.host;
}
