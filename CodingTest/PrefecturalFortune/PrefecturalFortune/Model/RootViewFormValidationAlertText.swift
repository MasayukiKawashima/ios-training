//
//  RootViewFormValidationAlertText.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/15.
//

import Foundation

struct RootViewFormValidationAlertText {
  static let title = "入力エラー"
  
  static var message: (FormValidationError) -> String = { errorType in
    switch errorType {
    case .empty: 
      return "文字を入力してください"
    case .length(let min, let max):
      return "\(min)文字以上\(max)文字以下で入力してください。"
    case .inValidCharacter:
      return "不正な文字が含まれています"
    }
  }
}
