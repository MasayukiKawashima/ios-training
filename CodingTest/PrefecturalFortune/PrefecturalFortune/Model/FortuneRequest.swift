//
//  FortuneRequest.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/28.
//

import Foundation

struct FortuneRequest: Requestable {
  typealias Response = FortuneResponse
  typealias HTTPBody = FortuneRequestBody

  var baseURL: String
  var path: String
  var method: HTTPMethod
  var header: HTTPHeader
  var body: HTTPBody?
}
