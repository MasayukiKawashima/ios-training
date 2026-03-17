//
//  ImageFetcher.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/05.
//

import Foundation

class ImageDataFetcher {


  // MARK: - Properties

  private let session: URLSession


  // MARK: - Init

  init(session: URLSession = .shared) {
    self.session = session
  }


  // MARK: - Methods

  func fetch(url: URL) async throws -> Data {
    let (data, response) = try await session.data(from: url)

    guard let httpResponse = response as? HTTPURLResponse else {
      print("ノーレスポンスエラー")
      throw ImageDataFetcherError.noResponse
    }

    if httpResponse.statusCode != 200 {
      print("ステータスコードエラー")
      throw ImageDataFetcherError.unacceptableStatusCode(httpResponse.statusCode)
    }

    guard let mimeType = httpResponse.mimeType else {
      print("mimeTypeのnilエラー")
      throw ImageDataFetcherError.mimeTypeError("mimeType is nil")
    }

    if !mimeType.hasPrefix("image/") {
      print("mimeTypeがimage以外のエラー")
      print("mimetype: \(mimeType)")
      throw ImageDataFetcherError.mimeTypeError(mimeType)
    }
    return data
  }
}
