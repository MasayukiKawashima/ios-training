//
//  RootFormItemsValidationAlertText.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/16.
//

import Foundation

struct RootFormItemsValidationAlertText {
  static let title = "エラー"

  static var message: (RootFormItemsValidationError) -> String = { errorType in
    switch errorType {
    case .missingField(let missingFields):
      return "未記入の項目があります"
    }
  }
}
