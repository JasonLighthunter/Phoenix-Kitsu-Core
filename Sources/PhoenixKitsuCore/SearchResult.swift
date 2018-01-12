import Requestable

public class SearchResult<T: HasKitsuObjectAttributes & Requestable>: Decodable {
  public let data: [T]?
  public let meta: MetaObject?
  public let pagingLinks: PagingLinks?

  private enum CodingKeys: String, CodingKey {
    case data
    case meta
    case pagingLinks = "links"
  }

  public required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    self.data = try? container.decode([T].self, forKey: .data)
    self.meta = try? container.decode(MetaObject.self, forKey: .meta)
    self.pagingLinks = try? container.decode(PagingLinks.self, forKey: .pagingLinks)
  }
}
