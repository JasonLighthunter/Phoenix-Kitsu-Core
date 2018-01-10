import Foundation
import Requestable

public class KitsuHandler {
  private static let decoder = JSONDecoder()
  private static let test = PhoenixCore()
  
  public class func getResource<T: Requestable & Decodable>(by objectID: Int,
                                                     callback: @escaping (T?) -> ()) throws {
    let url = Constants.baseURL + T.requestURLString + String(objectID)
    
    NetworkingUtil.getDataFrom(url) { response, error in
      guard
        error == nil,
        let dataJSON = try? JSONSerialization.jsonObject(with: response!) as! [String: Any?],
        let objectData = try? JSONSerialization.data(withJSONObject: dataJSON["data"] as Any),
        let object: T = try? decoder.decode(T.self, from: objectData)
        else {
          return callback(nil)
      }
      
      callback(object)
    }
  }
  
  public class func getCollection<T>(by filters: [String : String]?,
                              callback: @escaping (SearchResult<T>?) -> ()) throws {
    var url = Constants.baseURL + T.requestURLString
    
    if let filters = filters {
      for (key, value) in filters {
        url += "?filter[\(key)]=\(value)"
      }
    }
    
    getCollection(by: url) { searchResult in callback(searchResult)}
  }
  
  public class func getCollection<T>(by url: String, callback: @escaping (SearchResult<T>?) -> ()) {
    NetworkingUtil.getDataFrom(url) { responseData, error in
      guard error == nil,
        let searchResult = try? decoder.decode(SearchResult<T>.self, from: responseData!)
        else {
          return callback(nil)
      }
      callback(searchResult)
    }
  }
}


