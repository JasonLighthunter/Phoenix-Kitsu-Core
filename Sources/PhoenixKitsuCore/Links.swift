//
//  Links.swift
//  PhoenixCoreSwift
//
//  Created by Job Cuppen on 09/02/17.

import Foundation

public class Links: Decodable, Cleanable, Equatable {
  public fileprivate(set) var selfLink: String?

  private enum CodingKeys: String, CodingKey {
    case selfLink = "self"
  }
  
  public func doCleanUp() {
    emptyStringToNil(&selfLink)
  }

  public static func == (lhs: Links, rhs: Links) -> Bool {
    return lhs.selfLink == rhs.selfLink
  }
}
