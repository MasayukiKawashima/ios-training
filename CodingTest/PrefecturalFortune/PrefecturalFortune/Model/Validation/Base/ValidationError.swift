//
//  ValidationFormError.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

enum ValidationError: ValidationErrorProtocol {
  case empty
  case length(min: Int, max: Int)
  case inValidCharacter

  var errorDescription: String {
    switch self {
    case .empty:
      return RootViewFormValidationAlertText.message(.empty)
    case .length(let min, let max): 
      return RootViewFormValidationAlertText.message(.length(min: min, max: max))
    case .inValidCharacter: 
      return RootViewFormValidationAlertText.message(.inValidCharacter)
    }
  }
}
