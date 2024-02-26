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
    private var sectionTitles: [String]?
    private var sectionCount: Int?
    private var rowsCount: [Int]?
    
    private var weatherData: WeatherDataModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getWeatherData()
        
        navigationItem.title = "Погода в Минске" // bad practice
        
    }
    
    // MARK: - Get weather data
    private func getWeatherData() {
        networkService.fetchData { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    guard let data = try? JSONDecoder().decode(WeatherDataModel.self, from: data) else { return }
                    self.weatherData = data
                    self.setSections(data: data)
                    self.tableView.reloadData()
                }
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
    
    //setup sections title, sections count and rows count in each section
    private func setSections(data: WeatherDataModel) {
        self.sectionTitles = String.getSectionTitle(data: data)
        self.sectionCount = Int.getSectionCount(data: data)
        self.rowsCount = Int.getRowsCountInSection(data: data)
    }

}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension MyTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionCount ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowsCount?[section] ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MyTableViewCell else { return UITableViewCell() }
        
        cell.fillCellWithData(data: Date())

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles?[section] ?? ""
    }
    
}

