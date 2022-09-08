//
//  GlobalFunctions.swift
//  WeatherApp
//
//  Created by Nikhil Jaggi on 08/09/22.
//

import Foundation
import UIKit

public func defaultViews(views: [UIView]) {
    for view in views {
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 1
    }
}

public func timeFromStamp(_ timeStamp: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    return dateFormatter.string(from: date)
}
