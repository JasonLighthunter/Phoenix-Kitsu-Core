//
//  KitsuObject.swift
//  PhoenixCoreSwift
//
//  Created by Job Cuppen on 19/05/2017.

import Requestable

public protocol KitsuObject: Cleanable, Decodable, Requestable {
  var objectID: String {get}
  var type: String {get}
  var links: Links {get}
}
