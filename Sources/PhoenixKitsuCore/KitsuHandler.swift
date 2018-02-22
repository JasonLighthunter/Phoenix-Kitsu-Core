import Foundation
import Requestable
//import Alamofire

public class KitsuHandler {
  private let decoder: JSONDecoder
  
  private let defaultSession = URLSession(configuration: .default)
  private var dataTask: URLSessionDataTask?
  
  public init(decoder: JSONDecoder) {
    self.decoder = decoder
  }
  
//  private func handleResponse(_ response: DataResponse<Data>, _ callback: (Data?, Error?) -> Void) {
//    switch response.result {
//    case .failure(let error): callback(nil, error)
//    case .success: callback(response.result.value, nil)
//    }
//  }
  
  private func parseToObjectData(data: Data?) -> Data? {
    let dataJSON = try? JSONSerialization.jsonObject(with: data!) as! [String: Any?]
    
    guard let objectData = try? JSONSerialization.data(withJSONObject: dataJSON!["data"] as Any) else { return nil }
    
    return objectData
  }
  
  /// Retrieves a KitsuObject that corresponds with the given id and type, and feeds it to the given clojure
  ///
  /// - Parameters:
  ///   - objectID: The id for the desired object
  ///   - accessToken: The accessToken used to authenticate the request
  ///   - callback: The callback to be triggered when the object is fetched
  public func getResource<T: Decodable & Requestable>(by objectID: Int, with accessToken: String? = nil,
                                                      callback: @escaping (T?) -> Void) {
    let urlString = Constants.requestBaseURL + T.requestURLString + String(objectID)
    guard let url = URL(string: urlString) else { return callback(nil) }
    
    var headers = Constants.requestHeaders
    if let token = accessToken {
      headers["Autherization"] = "Bearer " + token
    }
    
    let innerCallback: (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void = { data, response, error in
      guard error == nil else { return callback(nil) }
      let objectData = self.parseToObjectData(data: data)
      guard let object: T = try? self.decoder.decode(T.self, from: objectData!) else { return callback(nil) }
      callback(object)
    }
    
    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = headers
    
//    let request = Alamofire.request(url, headers: headers)
    self.doRequest(request, callback: innerCallback)
  }

  private func addFilters(_ filters: [String : String]?, to url: inout String) {
    if let filters = filters {
      for (key, value) in filters {
        url += "?filter[\(key)]=\(value)"
      }
    }
  }
  
  /// Retrieves a list of KitsuObjects that correspond with the given filters and feeds it to the given clojure
  ///
  /// - Parameters:
  ///   - filters: The filter dictionary to use for searching for the desired objects
  ///   - accessToken: The accessToken used to authenticate the request
  ///   - callback: The callback to be triggered when the list of objects is fetched
  public func getCollection<T>(by filters: [String : String]?, accessToken: String? = nil, callback: @escaping (SearchResult<T>?) -> Void) {
    var url = Constants.requestBaseURL + T.requestURLString
    
    addFilters(filters, to: &url)
    
    getCollection(by: url, with: accessToken) { searchResult in callback(searchResult) }
  }
  
  /// Retrieves a list of KitsuObjects that corresponds with the given url and feeds it to the given clojure
  ///
  /// - Parameters:
  ///   - url: The url to use for retrieving a list of objects
  ///   - accessToken: The accessToken used to authenticate the request
  ///   - callback: The callback to be triggered when the list of objects is fetched
  public func getCollection<T>(by urlString: String, with accessToken: String? = nil, callback: @escaping (SearchResult<T>?) -> Void) {
    
    guard let url = URL(string: urlString) else { return callback(nil) }
    
    let innerCallback: (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void = { data, response, error in
      guard error == nil else { return callback(nil) }
      guard let searchResult = try? self.decoder.decode(SearchResult<T>.self, from: data!)
        else { return callback(nil) }
      callback(searchResult)
    }
    
    var headers = Constants.requestHeaders
    if let token = accessToken {
      headers["Autherization"] = "Bearer " + token
    }
    
    var request = URLRequest(url: url)
    request.allHTTPHeaderFields = headers
//    let request = Alamofire.request(url, headers: headers)
    self.doRequest(request, callback: innerCallback)
  }
  
  /// Retrieves a tokenResponse from kitsu.io
  ///
  /// - Parameters:
  ///   - username: The username of the user trying to authenticate
  ///   - password: The password of the user trying to authenticate
  ///   - callback: The callback to be triggered when the list of objects is fetched
  public func getTokenResponse(with name: String, and password: String, callback: @escaping (TokenResponse?) -> ()) {
    guard let url = URL(string: Constants.tokenURL) else { return callback(nil) }
    let method = "POST"
    let parameters: [String : String] = [
      "grant_type" : "password",
      "username" : name,
      "password" : password
    ]
    var parametersString = ""
    parameters.forEach { key, value in
      parametersString += key + "=" + value + "&"
    }
    parametersString.removeLast()
    
    
    let headers = Constants.clientCredentialHeaders

    let innerCallback: (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void = { data, response, error in
      guard error == nil else { return callback(nil) }
      guard let tokenResponse = try? self.decoder.decode(TokenResponse.self, from: data!)
        else { return callback(nil) }
      callback(tokenResponse)
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.allHTTPHeaderFields = headers
    request.httpBody = parametersString.data(using: .utf8)
    
//    let request = Alamofire.request(url, method: method, parameters : parameters, headers: headers)
    self.doRequest(request, callback: innerCallback)
  }
  
  private func doRequest(_ request: URLRequest, callback: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
//    request.responseData { response in
//      self.handleResponse(response, callback)
//    }
    dataTask?.cancel()
    dataTask = defaultSession.dataTask(with: request, completionHandler: callback)
    dataTask?.resume()
  }
}

