//
//  ViewController.swift
//  HarryPotter
//
//  Created by Zhanagul on 21.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    let networkManager = NetworkManager()
    var houseViewModels: [HouseViewModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        networkManager.delegate = self
        networkManager.fetchHouses()
    }
}

// MARK: - NetworkManagerDelegate

extension ViewController: NetworkManagerDelegate {
    
    func onHouseDidUpdate(with models: [HouseViewModel]) {
        houseViewModels = models
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houseViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HouseCell = tableView.dequeueReusableCell(withIdentifier: "HouseCell", for: indexPath) as! HouseCell
        cell.configure(with: houseViewModels[indexPath.row])
        return cell
    }
}

// MARK: - Private

private extension ViewController {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: String(describing: HouseCell.self), bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "HouseCell")
    }
}
