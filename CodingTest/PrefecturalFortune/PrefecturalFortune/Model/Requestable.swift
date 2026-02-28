//
//  Requestable.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/28.
//

import Foundation

protocol Requestable {
  associatedtype Response: Decodable
  associatedtype HTTPBody: Encodable

  var baseURL: String { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var header: HTTPHeader { get }
  var body: HTTPBody? { get }
}
