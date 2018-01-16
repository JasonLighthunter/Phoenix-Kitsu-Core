import Foundation
import Alamofire

public class NetworkingUtility {
  private func handle(response: DataResponse<Data>, _ callback: (Data?, Error?) -> ()) {
    switch response.result {
    case .failure(let error): callback(nil, error)
    case .success: callback(response.result.value, nil)
    }
  }

  public init() {
    
  }
  /// Retrieves json from the kitsu.io API and feeds it to the given clojure
  ///
  /// - Parameters:
  ///   - url: The url of the desired resource or collection
  ///   - callback: The callback to be triggered when json is fetched
  public func getDataFrom(_ url: String, and headers: HTTPHeaders,
                          callback: @escaping (Data?, Error?) -> Void) {
    Alamofire.request(url, headers: headers).responseData { response in
      self.handle(response: response, callback)
//      switch response.result {
//      case .failure(let error): callback(nil, error)
//      case .success: callback(response.result.value, nil)
//      }
    }
  }
  
  public func getDataFrom(_ url: String, callback: @escaping (Data?, Error?) -> Void) {
    Alamofire.request(url).responseData { response in
      self.handle(response: response, callback)
//      switch response.result {
//      case .failure(let error): callback(nil, error)
//      case .success: callback(response.result.value, nil)
//      }
    }
  }
//  public func getToken(with username: String, and password: String,
//                      callback: @escaping (Data?, Error?) -> ()) {
//    let url = Constants.tokenURL
//    let method = HTTPMethod.post
//    let parameters: Parameters = [
//      "grant_type" : "password",
//      "username" : username,
//      "password" : password
//    ]
//    let headers = Constants.clientCredentialHeaders
//
//    Alamofire.request(url, method: method, parameters: parameters, headers: headers)
//      .responseData { response in
//        self.handle(response: response, callback)
////        switch response.result {
////        case .failure(let error): callback(nil, error)
////        case .success:callback(response.result.value, nil)
////        }
//    }
//  }
  
//  public func refreshToken(with refreshToken: String, _ callback: @escaping (Data?, Error?) -> ()) {
//    let url = Constants.tokenURL
//    let method = HTTPMethod.post
//    let parameters: Parameters = [
//      "grant_type" : "refresh_token",
//      "refresh_token" : refreshToken
//    ]
//    let headers = Constants.clientCredentialHeaders
//
//    Alamofire.request(url, method: method, parameters: parameters, headers: headers)
//      .responseData { response in
//        self.handle(response: response, callback)
////        switch response.result {
////        case .failure(let error): callback(nil, error)
////        case .success:callback(response.result.value, nil)
////        }
//    }
//  }
  
}
