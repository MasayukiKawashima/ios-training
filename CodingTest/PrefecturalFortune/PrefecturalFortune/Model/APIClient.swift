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
    let urlRequest = try createRequest(request: request)

    do {
      let (data, response) = try await session.data(for: urlRequest)
      return try decode(type: T.self, data: data)
    } catch {
      //FIXME: エラーハンドリングの作成は専用のタスクで行う
      print("エラー: \(error)")
      throw error
    }
  }
}


// MARK: - Create Request, decode

extension APIClient {
  private func createRequest<T: Requestable>(request: T) throws -> URLRequest {
    guard let url = URL(string: request.baseURL + request.path) else {
      //FIXME: エラーハンドリングの作成は専用のタスクで行う
      print("URL作成エラー")
      throw APIClientError.invalidError
    }

    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = request.method.rawValue
    urlRequest.allHTTPHeaderFields = request.header.values()
    if let httpBody = request.body,
       let bodyData = try? JSONEncoder().encode(httpBody) {
      urlRequest.httpBody = bodyData
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
