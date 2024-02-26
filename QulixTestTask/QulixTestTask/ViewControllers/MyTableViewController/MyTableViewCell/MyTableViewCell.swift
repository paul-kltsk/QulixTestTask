//
//  TableViewCell.swift
//  QulixTestTask
//
//  Created by Pavel Kylitsky on 26/02/2024.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    // MARK: - View
    let dateLabel = UILabel()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Fill cell with data
    func fillCellWithData(data: Date) {
        dateLabel.text = "123"
    }
    
    // MARK: - Cell view setting
    private func setupCellView() {
        setupDateLabel()
    }
    
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.text = "123"
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        dateLabel.textColor = .black
        dateLabel.textAlignment = .center
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -200),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }

}
