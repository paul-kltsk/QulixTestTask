//
//  Int+Extension.swift
//  QulixTestTask
//
//  Created by Pavel Kylitsky on 26/02/2024.
//

import Foundation

extension Int {
    // MARK: - For TableView sections count
    static func getSectionCount(data: WeatherDataModel) -> Int {
        var daysList: Set<String> = []
        for date in data.list {
            let dayDate = date.dtTxt.prefix(10)
            daysList.insert(String(dayDate))
        }
        return daysList.count
    }
    
    // MARK: - get array with rows in section (index = section, value = rows count)
    static func getRowsCountInSection(data: WeatherDataModel) -> [Int] {
        var datesArray: [String] = []
        for dayDate in data.list {
            datesArray.append(String(dayDate.dtTxt.prefix(10)))
        }
        let rowsCount = countOccurrences(dates: datesArray)
        return rowsCount
    }
    
    // in getRowsCountInSection
    static func countOccurrences(dates: [String]) -> [Int] {
        
        var counts: [Int] = []
        var previousDate = dates[0]
        var currentCount = 0
        
        for date in dates {
            if date == previousDate {
                currentCount += 1
            } else {
                counts.append(currentCount)
                previousDate = date
                currentCount = 1
            }
        }
        counts.append(currentCount)

        return counts
    }
}
