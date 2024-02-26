//
//  TableViewController.swift
//  QulixTestTask
//
//  Created by Pavel Kylitsky on 26/02/2024.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    private let networkService = NetworkService.shared

    // MARK: - Properties
    private let cellIdentifier = "MyTableViewCell"
    private let rowHeight = UIScreen.main.bounds.height / 15
    private let sectionCount = 1
    private let rowsCount = 10
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getWeatherData()
        
        navigationItem.title = "Погода в Минске"
        
    }
    
    // MARK: - Get weather data
    private func getWeatherData() {
        networkService.fetchData { result in
            switch result {
            case .success(let data):
                guard let data = try? JSONDecoder().decode(WeatherDataModel.self, from: data) else { return }
                print("Data count: \(data.list.count)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - TableView setting
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension MyTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionCount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowsCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MyTableViewCell else { return UITableViewCell() }
        
        cell.fillCellWithData(data: Date())

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }
    
}

