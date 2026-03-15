//
//  FormValidationFormError.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

enum FormValidationError: Error {
  case empty
  case length(min: Int, max: Int)
  case inValidCharacter
}
