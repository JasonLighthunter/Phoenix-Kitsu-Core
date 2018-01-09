import XCTest
@testable import PhoenixKitsuCore

class ImageTests: XCTestCase {
  let decoder = JSONDecoder()
  
  let dataJSON: [String : Any] = [
    "tiny": "https://example.com/image/tiny.gif",
    "small": "https://example.com/image/small.gif",
    "medium": "https://example.com/image/medium.gif",
    "large": "https://example.com/image/large.gif",
    "original": "https://example.com/image/original.gif",
    "meta": [
      "dimensions": [
        "tiny": [
          "width": 1,
          "height": 2
        ],
        "small": [
          "width": 1,
          "height": 2
        ],
        "medium": [
          "width": 1,
          "height": 2
        ],
        "large": [
          "width": 1,
          "height": 2
        ]
      ]
    ]
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
    
    XCTAssertEqual(image?.tiny, "https://example.com/image/tiny.gif")
    XCTAssertEqual(image?.small, "https://example.com/image/small.gif")
    XCTAssertEqual(image?.medium, "https://example.com/image/medium.gif")
    XCTAssertEqual(image?.large, "https://example.com/image/large.gif")
    XCTAssertEqual(image?.original, "https://example.com/image/original.gif")
    
    XCTAssertNotNil(image?.meta)
  }
  
  func testImageMeta() {
    let json = dataJSON
    
    if JSONSerialization.isValidJSONObject(json as Any) {
      let data = try? JSONSerialization.data(withJSONObject: json as Any)
      image = try? decoder.decode(Image.self, from: data!)
    } else {
      image = nil
    }
    let imageMeta: ImageMeta? = image?.meta
    
    XCTAssertNotNil(imageMeta)
    
    XCTAssertNotNil(imageMeta?.dimensions)
  }
  
  func testImageMetaDimensions() {
    let json = dataJSON
    
    if JSONSerialization.isValidJSONObject(json as Any) {
      let data = try? JSONSerialization.data(withJSONObject: json as Any)
      image = try? decoder.decode(Image.self, from: data!)
    } else {
      image = nil
    }
    let imageMetaDimensions: ImageMetaDimensions? = image?.meta?.dimensions
    
    XCTAssertNotNil(imageMetaDimensions)
    
    XCTAssertNotNil(imageMetaDimensions?.tiny)
    XCTAssertNotNil(imageMetaDimensions?.small)
    XCTAssertNotNil(imageMetaDimensions?.medium)
    XCTAssertNotNil(imageMetaDimensions?.large)
  }
  
  func testImageMetaDimension() {
    let json = dataJSON
    
    if JSONSerialization.isValidJSONObject(json as Any) {
      let data = try? JSONSerialization.data(withJSONObject: json as Any)
      image = try? decoder.decode(Image.self, from: data!)
    } else {
      image = nil
    }
    let imageMetaDimension: ImageMetaDimension? = image?.meta?.dimensions?.tiny
    
    XCTAssertNotNil(imageMetaDimension)
    
    XCTAssertEqual(imageMetaDimension?.height, 2)
    XCTAssertEqual(imageMetaDimension?.width, 1)
  }
}

