import XCTest
@testable import PhoenixKitsuCore

class ImageTests: XCTestCase {
  let decoder = JSONDecoder()
  
  let dataJSON: [String : Any] = [
    "original": "http://example.com/original"
  ]
  
  var image: Image?
  
  override func tearDown() {
    image = nil
    
    super.tearDown()
  }
  
  func testImage() {
    let json = dataJSON
    
    if JSONSerialization.isValidJSONObject(json as Any) {
      let data = try? JSONSerialization.data(withJSONObject: json as Any)
      image = try? decoder.decode(Image.self, from: data!)
    } else {
      image = nil
    }
    
    XCTAssertNotNil(image)
    
    XCTAssertEqual(image?.original, "http://example.com/original")
  }
}

