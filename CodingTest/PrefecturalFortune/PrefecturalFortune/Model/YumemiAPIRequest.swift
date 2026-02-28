//
//  YumemiAPIRequest.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/28.
//

import Foundation

// 2/28現在未使用のプロトコル
// より抽象的なリクエストプロトコルであるrequestableを使用中
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
