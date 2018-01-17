import Foundation
import Requestable
import Alamofire

public class KitsuHandler {
  private let decoder: JSONDecoder
  
  public init(decoder: JSONDecoder) {
    self.decoder = decoder
  }
  
  private func handle(response: DataResponse<Data>, _ callback: (Data?, Error?) -> Void) {
    switch response.result {
    case .failure(let error): callback(nil, error)
    case .success: callback(response.result.value, nil)
    }
  }
  private func parseToObjectData(data: Data?) -> Data? {
    let dataJSON = try? JSONSerialization.jsonObject(with: data!) as! [String: Any?]
    
    guard let objectData = try? JSONSerialization.data(withJSONObject: dataJSON!["data"] as Any) else { return nil }
    
    return objectData
  }
  
  /// Retrieves a KitsuObject that corresponds with the given id and type, and feeds it to the given clojure
  ///
  /// - Parameters:
  ///   - objectID: The id for the desired object
  ///   - callback: The callback to be triggered when the object is fetched
  public func getResource<T: Decodable & Requestable>(by objectID: Int, callback: @escaping (T?) -> Void) {
    let url = Constants.requestBaseURL + T.requestURLString + String(objectID)
    
    let innerCallback: (_ data: Data?, _ error: Error?) -> Void = { data, error in
      guard error == nil else { return callback(nil) }
      
      let objectData = self.parseToObjectData(data: data)
      
      guard let object: T = try? self.decoder.decode(T.self, from: objectData!) else { return callback(nil) }
      
      callback(object)
    }
    
    Alamofire.request(url, headers: Constants.requestHeaders).responseData { response in
      self.handle(response: response, innerCallback)
//        guard error == nil else { return callback(nil) }
//        guard let dataJSON = try? JSONSerialization.jsonObject(with: data!) as! [String: Any?]
//          else { return callback(nil) }
//        guard let objectData = try? JSONSerialization.data(withJSONObject: dataJSON["data"] as Any)
//          else { return callback(nil) }
//        guard let object: T = try? self.decoder.decode(T.self, from: objectData)
//          else { return callback(nil) }
//
//        callback(object)
//      }
    }
  }
  
  /// Retrieves a list of KitsuObjects that correspond with the given filters and feeds it to the given clojure
  ///
  /// - Parameters:
  ///   - filters: The filter dictionary to use for searching for the desired objects
  ///   - callback: The callback to be triggered when the list of objects is fetched
  public func getCollection<T>(by filters: [String : String]?, callback: @escaping (SearchResult<T>?) -> Void) {
    var url = Constants.requestBaseURL + T.requestURLString
    
    if let filters = filters {
      for (key, value) in filters {
        url += "?filter[\(key)]=\(value)"
      }
    }
    
    getCollection(by: url) { searchResult in callback(searchResult) }
  }
  
  /// Retrieves a list of KitsuObjects that corresponds with the given url and feeds it to the given clojure
  ///
  /// - Parameters:
  ///   - url: The url to use for retrieving a list of objects
  ///   - callback: The callback to be triggered when the list of objects is fetched
  public func getCollection<T>(by url: String, callback: @escaping (SearchResult<T>?) -> Void) {
    let innerCallback: (_ data: Data?, _ error: Error?) -> Void = { data, error in
      guard error == nil else { return callback(nil) }
      guard let searchResult = try? self.decoder.decode(SearchResult<T>.self, from: data!)
        else { return callback(nil) }
      callback(searchResult)
    }
    
    Alamofire.request(url, headers: Constants.requestHeaders).responseData { response in
      self.handle(response: response, innerCallback)
//        guard error == nil else { return callback(nil) }
//        guard let searchResult = try? self.decoder.decode(SearchResult<T>.self, from: data!)
//          else { return callback(nil) }
//        callback(searchResult)
      }
    }
  
  
  /// Retrieves a tokenResponse from kitsu.io
  ///
  /// - Parameters:
  ///   - username: The username of the user trying to authenticate
  ///   - password: The password of the user trying to authenticate
  ///   - callback: The callback to be triggered when the list of objects is fetched
  public func getTokenResponse(with name: String, and password: String, callback: @escaping (TokenResponse?) -> ()) {
    let url = Constants.tokenURL
    let method = HTTPMethod.post
    let parameters: [String : String] = [
      "grant_type" : "password",
      "username" : name,
      "password" : password
    ]
    let headers = Constants.clientCredentialHeaders

    let innerCallback: (_ data: Data?, _ error: Error?) -> Void = { data, error in
      guard error == nil else { return callback(nil) }
      guard let tokenResponse = try? self.decoder.decode(TokenResponse.self, from: data!)
        else { return callback(nil) }
      callback(tokenResponse)
    }
//
    Alamofire.request(url, method: method, parameters : parameters, headers: headers).responseData { response in
////      self.handle(response: response) { data, error in
////        guard error == nil else { return callback(nil) }
////        guard let tokenResponse = try? self.decoder.decode(TokenResponse.self, from: data!)
////          else { return callback(nil) }
////        callback(tokenResponse)
////      }
      self.handle(response: response, innerCallback)
    }
  }
}

