public enum Constants {
  private static let baseURL = "https://kitsu.io/api/"
  static let requestBaseURL = baseURL + "edge/"
  static let tokenURL = baseURL + "oauth/token"
    
  static let requestHeaders: [String : String] = [
    "Accept": "application/vnd.api+json",
    "Content-Type": "application/vnd.api+json"
  ]
  
  static let clientCredentialHeaders: [String : String] = [
    "CLIENT_ID": "dd031b32d2f56c990b1425efe6c42ad847e7fe3ab46bf1299f05ecd856bdb7dd",
    "CLIENT_SECRET": "54d7307928f63414defd96399fc31ba847961ceaecef3a5fd93144e960c0e151"
  ]
}
