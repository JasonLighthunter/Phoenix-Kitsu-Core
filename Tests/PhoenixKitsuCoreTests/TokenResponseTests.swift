import XCTest
@testable import PhoenixKitsuCore

class TokenResponseTests: XCTestCase {
  let decoder = JSONDecoder()

  let dataJSON: [String: Any] = [
    "access_token": "64dd8cb22",
    "token_type": "bearer",
    "expires_in": 771413,
    "refresh_token": "64dd333b22",
    "scope": "public",
    "created_at": 1514290597
  ]

  var tokenResponse: TokenResponse?

  override func tearDown() {
    tokenResponse = nil

    super.tearDown()
  }

  func testTokenResponse() {
    let json = dataJSON

    if JSONSerialization.isValidJSONObject(json as Any) {
      let data = try? JSONSerialization.data(withJSONObject: json as Any)
      tokenResponse = try? decoder.decode(TokenResponse.self, from: data!)
    } else {
      tokenResponse = nil
    }

    XCTAssertNotNil(tokenResponse)

    XCTAssertEqual(tokenResponse?.accessToken, "64dd8cb22")
    XCTAssertEqual(tokenResponse?.tokenType, "bearer")
    XCTAssertEqual(tokenResponse?.expiresIn, 771413)
    XCTAssertEqual(tokenResponse?.refreshToken, "64dd333b22")
    XCTAssertEqual(tokenResponse?.scope, "public")
    XCTAssertEqual(tokenResponse?.createdAt, 1514290597)
  }
}
