//
//  TimeIntervalExtension.swift
//  DailyMotion
//
//  Created by Hugo Coutinho on 2024-04-13.
//

import Foundation

extension TimeInterval {
    func formatToMinutes() -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute]
        formatter.unitsStyle = .full
        
        let uploadDate = Date(timeIntervalSince1970: self)
        let timeDifference = Date().timeIntervalSince(uploadDate)
        
        return formatter.string(from: timeDifference)
    }
}
