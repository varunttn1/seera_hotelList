//
//  Constant.swift
//  HotelListing
//
//  Created by Varun Kumar on 05/01/21.
//

import Foundation

func getAppLanguage() -> String {
    return LocalizationManager.sharedInstance.getLanguage()
}

func setAppLanguage(languageCode: String) {
    LocalizationManager.sharedInstance.setLanguage(languageCode: languageCode)
}

let languageNone = "none"
let languageEn = "en"
let languageAr = "ar"
