class API {
  static deleteUrl(int id) {
    return Uri.parse("http://10.0.2.2:8000/api/notes/delete/${id}");
  }

  static updateUrl(int id) {
    return Uri.parse("http://10.0.2.2:8000/api/notes/update/${id}");
  }

  static const create = "http://10.0.2.2:8000/api/notes/create/";
  static const getNotes = "http://10.0.2.2:8000/api";
}
