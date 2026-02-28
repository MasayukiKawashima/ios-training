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

  var baseURL: String {
    YumemiAPIConstants.baseURL
  }

  var path: String {
    YumemiAPIConstants.EndPoint.fortune.path
  }

  var method: HTTPMethod {
    YumemiAPIConstants.EndPoint.fortune.method
  }

  var header: HTTPHeader {
    HTTPHeader(["API-Version": YumemiAPIConstants.EndPoint.fortune.version])
  }
  var body: HTTPBody?
}
