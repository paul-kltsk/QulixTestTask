//
//  String+Extension.swift
//  QulixTestTask
//
//  Created by Pavel Kylitsky on 26/02/2024.
//

import Foundation

extension String {
    
    // MARK: - For TableView header title
    static func getSectionTitle(data: WeatherDataModel) -> [String] {
        var daysList: Set<String> = []
        for date in data.list {
            let dayDate = date.dtTxt.prefix(10)
            daysList.insert(String(dayDate))
        }
        let sortedDates = sortedArrayWithDates(dates: daysList)
        return sortedDates
    }
    
    // sorted dates in Set of dates
    static func sortedArrayWithDates(dates: Set<String>) -> Array<String> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let sortedDates = dates.sorted {
            let date1 = dateFormatter.date(from: $0)!
            let date2 = dateFormatter.date(from: $1)!
            return date1 < date2
        }
        return sortedDates
    }
    
}
