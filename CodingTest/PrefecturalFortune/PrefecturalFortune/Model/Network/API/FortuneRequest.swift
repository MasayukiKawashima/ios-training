//
//  FortuneRequest.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/28.
//

import Foundation

struct FortuneRequest: Requestable {
  typealias Response = FortuneResponseBody
  typealias HTTPBody = FortuneRequestBody

  var baseURL: String {
    YumemiAPIConstants.baseURL
  }

  var path: String {
    YumemiAPIConstants.Fortune.path
  }

  var method: HTTPMethod {
    YumemiAPIConstants.Fortune.method
  }

  var header: HTTPHeader {
    HTTPHeader(["API-Version": YumemiAPIConstants.Fortune.version])
      .addValues(["Content-Type": "application/json"])
  }
  var body: HTTPBody?
}
