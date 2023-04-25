import 'package:http/http.dart' as http;

class Api {
  static const apikey = "RB5Waj8YnGXaZmLnBUppJPiy";
  static var baseUrl = Uri.parse("https://api.remove.bg/v1.0/removebg");
  static removebg(String imgPath) async {
    var req = http.MultipartRequest("POST", baseUrl);
    req.headers.addAll({"X-API-key": apikey});
    req.files.add(await http.MultipartFile.fromPath("image_file", imgPath));
    final res = await req.send();

    if (res.statusCode == 200) {
      http.Response img = await http.Response.fromStream(res);
      return img.bodyBytes;
    } else {
      print("Failed to upload");
      return null;
    }
  }
}
