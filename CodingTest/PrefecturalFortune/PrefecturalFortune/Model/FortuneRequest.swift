//
//  FortuneRequest.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/28.
//

import Foundation

// プロトコルの定義場所は要検討
protocol YumemiAPIRequest {
  associatedtype Response: Decodable
  associatedtype HTTPBody: Encodable

  var path: String { get }
  var method: HTTPMethod { get }
  var body: HTTPBody { get }
}

struct FortuneRequest: YumemiAPIRequest {
  typealias Response = <#type#>
  typealias HTTPBody = FortuneRequestBody

  var path: String
  var method: HTTPMethod
  var body: HTTPBody
}
