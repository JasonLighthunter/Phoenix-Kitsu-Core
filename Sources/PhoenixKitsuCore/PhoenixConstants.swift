import Alamofire

enum Constants {
  static let baseURL = "https://kitsu.io/api/edge/"
  static let baseHeaders: HTTPHeaders = [
    "Accept": "application/vnd.api+json",
    "Content-Type": "application/vnd.api+json"
  ]
}
