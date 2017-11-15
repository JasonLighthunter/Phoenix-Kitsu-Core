//
//  KitsuObjectAttributes.swift
//  PhoenixCoreSwift
//
//  Created by Job Cuppen on 04/09/2017.

import Foundation

public protocol KitsuObjectAttributes: Cleanable, Decodable {
  var createdAt: String? {get}
  var updatedAt: String? {get}
}

public protocol KitsuObjectAttributesWithTimestamp: Decodable {
  var createdAt: String {get}
  var updatedAt: String {get}
}
