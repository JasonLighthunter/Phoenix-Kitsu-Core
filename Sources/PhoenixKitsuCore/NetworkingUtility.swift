import Foundation
import Alamofire

class NetworkingUtility {  
  /// Retrieves json from the kitsu.io API and feeds it to the given clojure
  ///
  /// - Parameters:
  ///   - url: The url of the desired resource or collection
  ///   - callback: The callback to be triggered when json is fetched
  func getDataFrom(_ url: String, callback: @escaping (Data?, Error?) -> Void) {
    Alamofire.request(url, headers: Constants.baseHeaders).responseData { res in
      switch res.result {
      case .failure(let error): callback(nil, error)
      case .success: callback(res.data, nil)
      }
    }
  }
}
