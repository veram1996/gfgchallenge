//
//  News.swift
//  iOS_Challenge
//
//  Created by Dheeraj Verma on 27/08/21.
//

import Foundation
struct News : Codable {
	let status : String?
	let feed : Feed?
	let items : [Items]?
}
