public struct Links: Decodable {
  public let selfLink: String?

  private enum CodingKeys: String, CodingKey {
    case selfLink = "self"
  }
}
