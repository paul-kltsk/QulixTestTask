//
//  DetailViewController.swift
//  QulixTestTask
//
//  Created by Pavel Kylitsky on 27/02/2024.
//

protocol DataDelegate: AnyObject {
    func sendData(data: List)
}

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private var data: List?
    
    weak var delegate: DataDelegate?
    
    // MARK: - Views
    private let dateLabel = UILabel()
    private let iconImageView = UIImageView()
    private let temperatureLabel = UILabel()
    private let humidityLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray6
        
        setupViews()
        
        fillViewsWithData()
        
    }

    // MARK: - fill labels with data
    private func fillViewsWithData() {
        
        guard let data = data else { return }
        
        dateLabel.text = String(data.dtTxt.prefix(16))
        temperatureLabel.text = String.convertToCelsiusString(value: data.main.temp)
        humidityLabel.text = "Humidity: \(data.main.humidity)"
        descriptionLabel.text = data.weather[0].description
        iconImageView.image = UIImage(named: data.weather[0].icon.rawValue)
    }
    
}

// MARK: - Delegate for sending data 
extension DetailViewController: DataDelegate {
    
    func sendData(data: List) {
        self.data = data
    }
    
}

// MARK: - Views setting
private extension DetailViewController {
    
    func setupViews() {
        setupDateLabel()
        setupIconImageView()
        setupTemperatureLabel()
        setupHumidityLabel()
        setupDescriptionLabel()
    }
    
    // dateLabel
    func setupDateLabel() {
        view.addSubview(dateLabel)
        dateLabel.textAlignment = .center
        dateLabel.textColor = .black
        dateLabel.numberOfLines = 1
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // iconImageView
    func setupIconImageView() {
        view.addSubview(iconImageView)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 100),
            iconImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // temperatureLabel
    func setupTemperatureLabel() {
        view.addSubview(temperatureLabel)
        temperatureLabel.textAlignment = .center
        temperatureLabel.textColor = .black
        temperatureLabel.numberOfLines = 1
        temperatureLabel.adjustsFontSizeToFitWidth = true
        temperatureLabel.font = UIFont.systemFont(ofSize: 50, weight: .semibold)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10),
            temperatureLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            temperatureLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    // humidityLabel
    func setupHumidityLabel() {
        view.addSubview(humidityLabel)
        humidityLabel.textAlignment = .center
        humidityLabel.textColor = .black
        humidityLabel.numberOfLines = 1
        humidityLabel.adjustsFontSizeToFitWidth = true
        humidityLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            humidityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
            humidityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            humidityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            humidityLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // descriptionLabel
    func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 1
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
