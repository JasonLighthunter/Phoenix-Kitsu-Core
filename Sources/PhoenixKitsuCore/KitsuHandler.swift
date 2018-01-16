import Foundation
import Requestable

public class KitsuHandler {
  private let decoder: JSONDecoder
  private let networkingUtility: NetworkingUtility
  
  init(decoder: JSONDecoder, networkingUtility : NetworkingUtility) {
    self.decoder = decoder
    self.networkingUtility = networkingUtility
  }
  
  /// Retrieves a KitsuObject that corresponds with the given id and type, and feeds it to the
  /// given clojure
  ///
  /// - Parameters:
  ///   - objectID: The id for the desired object
  ///   - callback: The callback to be triggered when the object is fetched
  func getResource<T: Decodable & Requestable>(by objectID: Int, callback: @escaping (T?) -> ()) {
    let url = Constants.endpointBaseURL + T.requestURLString + String(objectID)
    
    networkingUtility.getDataFrom(url) { response, error in
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
  func getCollection<T>(by filters: [String : String]?,
                        callback: @escaping (SearchResult<T>?) -> ()) {
    var url = Constants.endpointBaseURL + T.requestURLString
    
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
  func getCollection<T>(by url: String, callback: @escaping (SearchResult<T>?) -> Void) {
    networkingUtility.getDataFrom(url) { responseData, error in
      guard error == nil,
        let searchResult = try? self.decoder.decode(SearchResult<T>.self, from: responseData!)
        else {
          return callback(nil)
      }
      callback(searchResult)
    }
  }
}


