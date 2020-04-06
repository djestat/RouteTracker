//
//  Helper.swift
//  RouteTracker
//
//  Created by Igor on 06.04.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import Foundation

final class Helper {
    
    //MARK: - Date Formatter functions
    func convertDateToName(_ inputDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date = dateFormatter.date(from: inputDate)
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        return dateFormatter.string(from: date!)
    }
    
    func convertNameToLabelText(_ name: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let date = dateFormatter.date(from: name)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date!)
    }
    
    func convertDateToInt(_ inputDate: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date = dateFormatter.date(from: inputDate)
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let string = dateFormatter.string(from: date!)
        let result: Int = Int(string)!
        return result
    }
    
    //MARK: - _ functions

    
}
