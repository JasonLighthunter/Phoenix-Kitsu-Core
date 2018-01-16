import Foundation
import Requestable

public class KitsuHandler {
  private let decoder: JSONDecoder
  private let networkingUtility: NetworkingUtility
  
  public init(decoder: JSONDecoder, networkingUtility : NetworkingUtility) {
    self.decoder = decoder
    self.networkingUtility = networkingUtility
  }
  
  /// Retrieves a KitsuObject that corresponds with the given id and type, and feeds it to the
  /// given clojure
  ///
  /// - Parameters:
  ///   - objectID: The id for the desired object
  ///   - callback: The callback to be triggered when the object is fetched
  public func getResource<T: Decodable & Requestable>(by objectID: Int, callback: @escaping (T?) -> ()) {
    let url = Constants.requestBaseURL + T.requestURLString + String(objectID)
    
    networkingUtility.getDataFrom(url, and: Constants.requestHeaders) { response, error in
      guard
        error == nil,
        let dataJSON = try? JSONSerialization.jsonObject(with: response!) as! [String: Any?],
        let objectData = try? JSONSerialization.data(withJSONObject: dataJSON["data"] as Any),
        let object: T = try? self.decoder.decode(T.self, from: objectData)
        else {
          return callback(nil)
      }
      
      callback(object)
    }
  }
  
  /// Retrieves a list of KitsuObjects that correspond with the given filters and feeds it to
  /// the given clojure
  ///
  /// - Parameters:
  ///   - filters: The filter dictionary to use for searching for the desired objects
  ///   - callback: The callback to be triggered when the list of objects is fetched
  public func getCollection<T>(by filters: [String : String]?,
                               callback: @escaping (SearchResult<T>?) -> ()) {
    var url = Constants.requestBaseURL + T.requestURLString
    
    if let filters = filters {
      for (key, value) in filters {
        url += "?filter[\(key)]=\(value)"
      }
    }
    
    getCollection(by: url) { searchResult in callback(searchResult)}
  }
  
  /// Retrieves a list of KitsuObjects that corresponds with the given url and feeds it to the
  /// given clojure
  ///
  /// - Parameters:
  ///   - url: The url to use for retrieving a list of objects
  ///   - callback: The callback to be triggered when the list of objects is fetched
  public func getCollection<T>(by url: String, callback: @escaping (SearchResult<T>?) -> Void) {
    networkingUtility.getDataFrom(url, and: Constants.requestHeaders) { responseData, error in
      guard
        error == nil,
        let searchResult = try? self.decoder.decode(SearchResult<T>.self, from: responseData!)
        else {
          return callback(nil)
      }
      callback(searchResult)
    }
  }
  
  /// Retrieves a tokenResponse from kitsu.io
  ///
  /// - Parameters:
  ///   - username: The username of the user trying to authenticate
  ///   - password: The password of the user trying to authenticate
  ///   - callback: The callback to be triggered when the list of objects is fetched
  public func getTokenResponse(with username: String, and password: String,
                               callback: @escaping (TokenResponse?) -> Void) {
    let url = Constants.tokenURL
    let parameters: [String : String] = [
      "grant_type" : "password",
      "username" : username,
      "password" : password
    ]
    let headers = Constants.clientCredentialHeaders
    
    networkingUtility.getTokenFrom(url, parameters, headers) { responseData, error in
      guard error == nil else { return callback(nil) }
      
      if let tokenResponse = try? self.decoder.decode(TokenResponse.self, from: responseData!) {
        callback(tokenResponse)
      }
      return callback(nil)
    }
  }
}

