//
//  RootFormItemsValidator.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/15.
//

import Foundation

struct RootFormItemsValidator: CompositeValidator {
  typealias Value = RootFormItems
  var validators: [AnyValidator<Value>] = [
    AnyValidator(RootFormItemsMissingValidator())
  ]
}
