public class Image: Decodable {
  public let original: String?
  
  private enum CodingKeys: String, CodingKey {
    case original
  }
}
