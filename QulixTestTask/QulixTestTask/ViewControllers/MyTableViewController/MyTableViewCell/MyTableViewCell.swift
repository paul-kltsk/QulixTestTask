//
//  TableViewCell.swift
//  QulixTestTask
//
//  Created by Pavel Kylitsky on 26/02/2024.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private var textSize: CGFloat?
    
    // MARK: - View
    private let timeLabel = UILabel()
    private let temperatureLabel = UILabel()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        updateFontSize()
    }

    // MARK: - Fill cell with data
    func fillCellWithData(data: WeatherDataModel, indexPath: IndexPath, rowCount: [Int]) {
        
        let index = getIndex(indexPath: indexPath, rowsCount: rowCount)

        let dateString = data.list[index].dtTxt
        let hoursString = getHoursFromDate(date: dateString)
        timeLabel.text = "Time: " + hoursString
        
        let temperature = data.list[index].main.temp
        let temperatureString = convertToCelsiusString(value: temperature)
        temperatureLabel.text = "Temperature: " + temperatureString
    }
    
    // MARK: - Cell view setting
    private func setupCellView() {
        setupDateLabel()
        setupTemperatureLabel()
    }
    
    // MARK: - font size
    private func updateFontSize() {
        let textSize = contentView.bounds.height * (1.0 / 3.0)
        timeLabel.font = UIFont.systemFont(ofSize: textSize)
        temperatureLabel.font = UIFont.systemFont(ofSize: textSize)
    }
    
}

// MARK: - Views
extension MyTableViewCell {
    // dateLabel
    private func setupDateLabel() {
        addSubview(timeLabel)
        timeLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        timeLabel.textColor = .black
        timeLabel.textAlignment = .left
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            timeLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
    
    // temperatureLabel
    private func setupTemperatureLabel() {
        addSubview(temperatureLabel)
        temperatureLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        temperatureLabel.textColor = .black
        temperatureLabel.textAlignment = .center
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            temperatureLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }

}

// MARK: - Calculation
private extension MyTableViewCell {
    
    // in fillCellWithData()
    func getHoursFromDate(date: String) -> String {
        let startIndex = date.index(date.startIndex, offsetBy: 11)
        let endIndex = date.index(date.startIndex, offsetBy: 16)
        let timeString = date[startIndex..<endIndex]
        return String(timeString)
    }
    
    // in fillCellWithData()
    func convertToCelsiusString(value: Double) -> String {
        let components = String(value).components(separatedBy: ".")
        if let integerPart = components.first {
            return integerPart + "°C"
        } else { return "" }
    }
    
    // Calculation weatherData index for cell in fillCellWithData()
    func getIndex(indexPath: IndexPath, rowsCount: [Int]) -> Int {
        
        var index: Int = 0
        
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            index = row
        } else {
            for i in rowsCount[0...section-1] {
                index += i
            }
            index += row
        }
    
        return index
        
    }
    
}
