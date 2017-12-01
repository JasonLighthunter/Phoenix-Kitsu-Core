import XCTest
@testable import PhoenixKitsuCore

class LinksTests: XCTestCase {
  let decoder = JSONDecoder()
  
  let stringJSON: [String : Any] = [
    "self": "http://example.com/posts"
  ]
  
  var links: Links?
  
  override func tearDown() {
    links = nil
    
    super.tearDown()
  }
  
  func testLinksSelfLink() {
    let json = stringJSON
    
    if JSONSerialization.isValidJSONObject(json as Any) {
      let data = try? JSONSerialization.data(withJSONObject: json as Any)
      links = try? decoder.decode(Links.self, from: data!)
    } else {
      links = nil
    }
    
    XCTAssertNotNil(links)
    
    XCTAssertEqual(links?.selfLink, "http://example.com/posts")
  }
}
