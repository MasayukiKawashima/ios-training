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
  var header: HTTPHeader{ get }
  var body: HTTPBody? { get } // fetch時にGETの場合を考慮してif letでbodyのnilチェックをする。GETならBodyがnilのため
}

extension YumemiAPIRequest {
  var baseURL: String {
    YumemiAPIConstants.baseURL
  }
}

struct FortuneRequest: YumemiAPIRequest {
  typealias Response = FortuneResponse
  typealias HTTPBody = FortuneRequestBody

  var path: String
  var method: HTTPMethod
  var header: HTTPHeader
  var body: HTTPBody?
}
