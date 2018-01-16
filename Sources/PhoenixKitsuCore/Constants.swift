import Alamofire

enum Constants {
  private static let baseURL = "https://kitsu.io/api/"
  static let EndpointBaseURL = baseURL + "edge/"
  static let tokenURL = baseURL + "oauth/token"
    
  static let baseHeaders: HTTPHeaders = [
    "Accept": "application/vnd.api+json",
    "Content-Type": "application/vnd.api+json"
  ]
}
