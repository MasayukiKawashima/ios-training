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

  func request<T: Requestable>(_ request: T) async throws {
    let urlRequest = try createRequest(request: request)

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
  }
}


// MARK: - Create Request

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
}
