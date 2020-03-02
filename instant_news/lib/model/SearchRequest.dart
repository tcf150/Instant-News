class SearchRequest {
  String keyword;
  String from;
  String sortBy;
  String preference;
  String language;

  SearchRequest(
      this.keyword,
      this.from,
      this.sortBy,
      this.preference,
      this.language);
}