import Foundation
import Requestable

extension URLRequest {
  init?(url urlString: String, headers: [String : String]?, parameters: [String : String]? = nil) {
    guard let url = URL(string: urlString) else { return nil }
    self.init(url: url)
    
    if let headers = headers {
      self.allHTTPHeaderFields = headers
    }
    
    if let parameters = parameters {
      var parametersString = ""
      parameters.forEach { key, value in
        parametersString += key + "=" + value + "&"
      }
      parametersString.removeLast()
      self.httpBody = parametersString.data(using: .utf8)
    }
  }
}

public class KitsuHandler {
  private let decoder: JSONDecoder
  private let session: URLSession
  private var dataTask: URLSessionDataTask?
  
  public init(decoder: JSONDecoder, session: URLSession?) {
    self.decoder = decoder
    self.session = session ?? URLSession(configuration: .default)
  }
  
  private func parseToObjectData(data: Data?) -> Data? {
    let dataJSON = try? JSONSerialization.jsonObject(with: data!) as! [String: Any?]
    guard let objectData = try? JSONSerialization.data(withJSONObject: dataJSON!["data"] as Any) else { return nil }
    return objectData
  }
  
  private func addAuthorizationHeader(with token: String, to headers: inout [String: String]?) {
    if headers != nil {
      headers!["Authorization"] = "Bearer " + token
    } else {
      headers = ["Autherization": "Bearer " + token]
    }
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
    var request = URLRequest(url: urlString, headers: Constants.requestHeaders)

    if accessToken != nil { request!.addValue(("Bearer " + accessToken!), forHTTPHeaderField: "Authorization") }
    
    let innerCallback: (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void = { data, response, error in
      guard error == nil else { return callback(nil) }
      let objectData = self.parseToObjectData(data: data)
      let object: T? = try? self.decoder.decode(T.self, from: objectData!)
      callback(object)
    }
    
    self.doRequest(request!, callback: innerCallback)
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
    var request = URLRequest(url: urlString, headers: Constants.requestHeaders)
    
    if accessToken != nil { request!.addValue(("Bearer " + accessToken!), forHTTPHeaderField: "Authorization") }

    let innerCallback: (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void = { data, response, error in
      guard error == nil else { return callback(nil) }
      let searchResult = try? self.decoder.decode(SearchResult<T>.self, from: data!)
      callback(searchResult)
    }
    
    self.doRequest(request!, callback: innerCallback)
  }
  
  /// Retrieves a tokenResponse from kitsu.io
  ///
  /// - Parameters:
  ///   - username: The username of the user trying to authenticate
  ///   - password: The password of the user trying to authenticate
  ///   - callback: The callback to be triggered when the list of objects is fetched
  public func getTokenResponse(with name: String, and password: String, callback: @escaping (TokenResponse?) -> ()) {
    let headers = Constants.clientCredentialHeaders
    let parameters: [String : String] = [
      "grant_type" : "password",
      "username" : name,
      "password" : password
    ]
    
    var request = URLRequest(url: Constants.tokenURL, headers: headers, parameters: parameters)
    request!.httpMethod = "POST"

    let innerCallback: (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void = { data, response, error in
      guard error == nil else { return callback(nil) }
      let tokenResponse = try? self.decoder.decode(TokenResponse.self, from: data!)
      callback(tokenResponse)
    }
    
    self.doRequest(request!, callback: innerCallback)
  }
  
  private func doRequest(_ request: URLRequest, callback: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
    dataTask?.cancel()
    dataTask = session.dataTask(with: request, completionHandler: callback)
    dataTask?.resume()
  }
}

