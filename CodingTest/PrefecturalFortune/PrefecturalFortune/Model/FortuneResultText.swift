//
//  FortuneResultText.swift
//  PrefecturalFortune
//
//  Created by 川島真之 on 2026/03/18.
//

import Foundation

enum FortuneResultText {
  static var capitalLabelText: (String) -> String = { capital in
  return "県庁所在地：" + capital
  }

  static var citizenDayLabelText: (MonthDay?) -> String = { citizenDay in
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

  static var coastLineLabelText: (Bool) -> String = { hasCoastLine in
    if hasCoastLine {
      return "海岸線: あり"
    } else {
      return "海岸線: なし"
    }
  }
}
