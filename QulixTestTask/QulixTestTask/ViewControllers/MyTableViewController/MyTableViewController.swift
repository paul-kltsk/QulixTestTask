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
    private let city = MinskCity()
    
    private var weatherData: WeatherDataModel?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getWeatherData()
        
        navigationItem.title = city.cityName
        
    }
    
    // MARK: - Get weather data
    private func getWeatherData() {
        networkService.fetchData(latitude: city.latitude, longitude: city.longitude) { result in
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
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
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
    
    // did select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // number of section
    override func numberOfSections(in tableView: UITableView) -> Int {
        sectionCount ?? 0
    }
    
    // number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowsCount?[section] ?? 0
    }
    
    // cell for row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MyTableViewCell else { return UITableViewCell() }
        
        guard let weatherData = weatherData, let rowsCount = rowsCount else { return UITableViewCell() }
        
        cell.fillCellWithData(data: weatherData, indexPath: indexPath, rowCount: rowsCount)

        return cell
        
    }
    
    // height for row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        rowHeight
    }
    
    // title for header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles?[section] ?? ""
    }
    
}

