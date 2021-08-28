//
//  ErrorResponse.swift
//  iOS_Challenge
//
//  Created by Dheeraj Verma on 27/08/21.
//

import Foundation

struct ErrorResponse: Error,Codable {
    var code: String?
    var message: String?
    var error: String?

    init(code: Int?, message: String?,error: String?) {
        self.message = message
        self.code = "\(code ?? 0)"
        self.error = error
    }
}

