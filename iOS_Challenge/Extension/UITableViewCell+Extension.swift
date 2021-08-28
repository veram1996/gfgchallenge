//
//  UITableViewCell+Extension.swift
//  iOS_Challenge
//
//  Created by Dheeraj Verma on 28/08/21.
//

import Foundation
import UIKit

extension UITableViewCell {
    static func nib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
