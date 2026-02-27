//
//  YumemiAPIConstants.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/27.
//

import Foundation

struct YumemiAPIConstants {
  static let baseURL = "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud"

  enum EndPoint {
    case fortune

    var path: String {
      switch self {
      case .fortune:
        return "/my_fortune"
      }
    }

    var method: HTTPMethod {
      switch self {
      case .fortune:
        return .post
      }
    }

    var version: String {
      switch self {
      case .fortune:
        return "v1"
      }
    }
  }
}
