//
//  ImageFetcherError.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/05.
//

import Foundation

enum ImageFetcherError: Error {
  case invalidURL
  case noResponse
  case unacceptableStatusCode(Int)
  case mimeTypeError(String)
}
