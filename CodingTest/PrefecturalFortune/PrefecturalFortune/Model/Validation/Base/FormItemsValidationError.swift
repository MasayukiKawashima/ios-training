//
//  FormItemsValidationError.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/15.
//

import Foundation

enum FormItemsValidationError: Error {
  case missingField([RootViewController.FormField])
}
