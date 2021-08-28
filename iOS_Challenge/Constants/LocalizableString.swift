//
//  LocalizableString.swift
//  iOS_Challenge
//
//  Created by Dheeraj Verma on 27/08/21.
//

import Foundation

protocol LocalizationProtocol {

}

extension LocalizationProtocol where Self: RawRepresentable, Self.RawValue == String {
    func text() -> String {
        return NSLocalizedString(rawValue, tableName: "Localizable", bundle: .main, comment: rawValue)
    }
}

enum ErrorString: String, LocalizationProtocol {
    case pleaseCheckInternetConnection = "error.pleaseCheckInternetConnection"
}
