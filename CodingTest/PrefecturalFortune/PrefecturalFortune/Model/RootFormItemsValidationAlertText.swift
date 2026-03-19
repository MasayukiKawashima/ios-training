//
//  RootFormItemsValidationAlertText.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/16.
//

import Foundation

enum RootFormItemsValidationAlertText {
  static let title = "エラー"

  static func message(error: RootFormItemsValidationError) -> String {
    switch error {
    case .missingField(let missingFields):
      return "未記入の項目があります"
    }
  }
}
