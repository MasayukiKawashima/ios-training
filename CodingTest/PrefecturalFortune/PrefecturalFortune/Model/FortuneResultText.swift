//
//  FortuneResultText.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/18.
//

import Foundation

enum FortuneResultText {
  static func fullCapitalText(capital: String) -> String {
    return "県庁所在地：" + capital
  }

  static func fullCitizenDayText(citizenDay: MonthDay?) -> String {
    if let citizenDay = citizenDay {
      let day = String(citizenDay.day)
      let month = String(citizenDay.month)
      let combinedString = "都道府県民の日： " + month + "月" + day + "日"
      return combinedString
    } else {
      let combinedString = "都道府県民の日：なし"
      return combinedString
    }
  }

  static func fullCoastLineText(hasCoastLine: Bool) -> String {
    if hasCoastLine {
      return "海岸線: あり"
    } else {
      return "海岸線: なし"
    }
  }
}
