//
//  Validator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/10.
//

import Foundation

protocol Validator {
  associatedtype Value
  func validate(_ value: Value) -> ValidationState
}
