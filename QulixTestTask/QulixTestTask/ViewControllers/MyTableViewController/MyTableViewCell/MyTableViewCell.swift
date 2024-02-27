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
    func fillCellWithData(data: List) {

        let dateString = data.dtTxt
        let hoursString = getHoursFromDate(date: dateString)
        timeLabel.text = "Time: " + hoursString
        
        let temperature = data.main.temp
        let temperatureString = String.convertToCelsiusString(value: temperature)
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
    
}
