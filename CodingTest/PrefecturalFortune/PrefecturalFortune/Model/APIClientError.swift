//
//  APIClientError.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/01.
//

import Foundation

enum APIClientError: Error {
  case invalidURL
  case encodeError(Error)
  case decodeError(Error)
  case noResponse
  case unacceptableStatusCode(Int)
}
