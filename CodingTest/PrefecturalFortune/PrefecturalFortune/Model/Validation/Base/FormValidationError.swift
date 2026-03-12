//
//  FormValidationFormError.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

enum FormValidationError: FormValidationErrorProtocol {
  case empty
  case length(min: Int, max: Int)
  case inValidCharacter

  var errorDescription: String {
    switch self {
    case .empty: return "文字を入力してください"
    case .length(let min, let max): return "\(min)文字以上\(max)文字以下で入力してください。"
    case .inValidCharacter: return "不正な文字が含まれています"
    }
  }
}
