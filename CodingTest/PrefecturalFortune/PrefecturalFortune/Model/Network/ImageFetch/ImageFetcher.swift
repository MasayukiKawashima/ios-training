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

    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode != 200 else {
      print("ノーレスポンスエラー")
    }

    guard let mimeType = httpResponse.mimeType,
          mimeType.hasPrefix("image/") else {
      print("MIMEタイプエラー")
    }
    return data
  }
}
