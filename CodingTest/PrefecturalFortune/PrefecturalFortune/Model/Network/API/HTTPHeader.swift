//
//  HTTPHeader.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/02/28.
//

import Foundation

class HTTPHeader {


  // MARK: - Properties

  private var header: [String: String]


  // MARK: - Init

  init(_ header: [String: String]) {
    self.header = header
  }


  // MARK: - Methods

  func addValues(_ values: [String: String]) -> HTTPHeader {
    var header = self.header

    values.forEach { (key, value) in
      header[key] = value
    }

    return HTTPHeader(header)
  }

  func values() -> [String:String] {
    return self.header
  }
}
