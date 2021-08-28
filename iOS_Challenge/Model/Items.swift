//
//  Items.swift
//  iOS_Challenge
//
//  Created by Dheeraj Verma on 27/08/21.
//

import Foundation
struct Items : Codable {
	let title : String?
	let pubDate : String?
	let link : String?
	let guid : String?
	let author : String?
	let thumbnail : String?
	let description : String?
	let content : String?
	let enclosure : Enclosure?
	let categories : [String]?
}
