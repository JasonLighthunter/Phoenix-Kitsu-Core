//import Foundation
//import Alamofire
//
//public class NetworkingUtility {
//  private func handle(response: DataResponse<Data>, _ callback: (Data?, Error?) -> ()) {
//    switch response.result {
//    case .failure(let error): callback(nil, error)
//    case .success: callback(response.result.value, nil)
//    }
//  }
//
//  public init() {}
//  /// Retrieves json from the kitsu.io API and feeds it to the given clojure
//  ///
//  /// - Parameters:
//  ///   - url: The url of the desired resource or collection
//  ///   - callback: The callback to be triggered when json is fetched
//  public func getDataFrom(_ url: String, and headers: HTTPHeaders,
//                          callback: @escaping (Data?, Error?) -> Void) {
//    Alamofire.request(url, headers: headers).responseData { response in
//      self.handle(response: response, callback)
//    }
//  }
//
//  public func getDataFrom(_ url: String, callback: @escaping (Data?, Error?) -> Void) {
//    Alamofire.request(url).responseData { response in
//      self.handle(response: response, callback)
//    }
//  }
//
//  // codebeat:disable[ARITY]
//  public func getTokenFrom(_ url: String, _ parameters: Parameters, _ headers: HTTPHeaders, callback: @escaping (Data?, Error?) -> Void) {
//    Alamofire.request(url, method: HTTPMethod.post, parameters: parameters, headers: headers)
//      .responseData { response in
//        self.handle(response: response, callback)
//    }
//  }
//  // codebeat:enable[ARITY]
//}

