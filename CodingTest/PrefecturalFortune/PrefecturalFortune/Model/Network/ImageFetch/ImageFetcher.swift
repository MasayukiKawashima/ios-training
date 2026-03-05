//
//  ImageFetcher.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/05.
//

import Foundation

class ImageFetcher {


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
      throw ImageFetcherError.noResponse
    }

    if httpResponse.statusCode != 200 {
      print("ステータスコードエラー")
      throw ImageFetcherError.unacceptableStatusCode(httpResponse.statusCode)
    }

    guard let mimeType = httpResponse.mimeType else {
      print("mimeTypeのnilエラー")
      throw ImageFetcherError.mimeTypeError("mimeType is nil")
    }

    if !mimeType.hasPrefix("image/") {
      print("mimeTypeがimage以外のエラー")
      print("mimetype: \(mimeType)")
      throw ImageFetcherError.mimeTypeError(mimeType)
    }
    return data
  }
}
