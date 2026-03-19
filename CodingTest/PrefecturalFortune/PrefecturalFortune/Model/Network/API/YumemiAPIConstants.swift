//
//  YumemiAPIConstants.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/27.

import Foundation

enum YumemiAPIConstants {


  // MARK: - Base

  static let baseURL = "https://yumemi-ios-junior-engineer-codecheck.app.swift.cloud"


  // MARK: - EndPoints

  enum Fortune {
    static let path = "/my_fortune"
    static let method: HTTPMethod = .post
    static let version: String = "v1"
  }
}
