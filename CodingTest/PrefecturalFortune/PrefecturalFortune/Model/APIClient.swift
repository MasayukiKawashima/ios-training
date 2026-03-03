//
//  APIClient.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/01.
//

import Foundation

class APIClient {


  // MARK: - Properties

  let session: URLSession


  // MARK: - Init

  init(session: URLSession) {
    self.session = session
  }


  // MARK: - Methods

  func request<T: Requestable>(_ request: T) async throws -> T.Response {
    do {
      let urlRequest = try createRequest(request: request)
      let (data, response) = try await session.data(for: urlRequest)
      let decoder = JSONDecoder()
      return try decoder.decode(T.Response.self, from: data)
    } catch let error as EncodingError {
      // エンコードエラーが投げられてきた場合
      print("エンコードエラー")
      print("エラー内容: \(error)")
      throw APIClientError.encodeError(error)
    } catch let error as DecodingError {
      // デコードエラーが投げられてきた場合
      print("デコードエラー")
      print("エラー内容: \(error)")
      throw APIClientError.decodeError(error)
    } catch {
      // 上記のエラー以外のエラーが投げれたとき
      print("エラー: \(error)")
      throw error
    }
  }
}


// MARK: - Create Request, decode

extension APIClient {
  private func createRequest<T: Requestable>(request: T) throws -> URLRequest {
    guard let url = URL(string: request.baseURL + request.path) else {
      // URL作成エラー
      print("URL作成エラー")
      throw APIClientError.invalidURL
    }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    urlRequest.allHTTPHeaderFields = request.header.values()
    if let httpBody = request.body {
      urlRequest.httpBody = try JSONEncoder().encode(httpBody)
    }
    return urlRequest
  }

  private func decode<T: Requestable>(type: T.Type, data: Data) throws -> T.Response {
    let decoder = JSONDecoder()
    return try decoder.decode(T.Response.self, from: data)
  }
}


// MARK: - checkURLRequest

extension APIClient {
  private func checkURLRequest(urlRequest: URLRequest) {
    print("------------------------------------------------------")
    print("リクエスト作成後")
    print("URL:\(urlRequest.url?.absoluteString ?? "nil")")
    print("HTTPMethod:\(urlRequest.httpMethod ?? "nil")")
    print("Header: \(urlRequest.allHTTPHeaderFields ?? [:])")

    if let body = urlRequest.httpBody {
      do {
        let jsonObject = try JSONSerialization.jsonObject(with: body, options: [])
        let prettyData = try JSONSerialization.data(
          withJSONObject: jsonObject,
          options: [.prettyPrinted]
        )

        if let prettyString = String(data: prettyData, encoding: .utf8) {
          print("Body:\n\(prettyString)")
        }
      } catch {
        print("Body decode failed:", error)
      }
    }
    print("------------------------------------------------------")
  }
}
