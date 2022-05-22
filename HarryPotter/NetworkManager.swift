//
//  NetworkManager.swift
//  HarryPotter
//
//  Created by Zhanagul on 21.05.2022.
//

import Foundation
import UIKit

protocol NetworkManagerDelegate: AnyObject {
    func onHouseDidUpdate(with models: [HouseViewModel])
}

final class NetworkManager {
    
    weak var delegate: NetworkManagerDelegate?
    
    func fetchHouses() {
        // 1. Create url string
        let urlString = "https://wizard-world-api.herokuapp.com/Houses"
        
        // 2. Create URL object from url string
        if let url = URL(string: urlString) {
            
            // 3. Create URLRequest object from URL
            let urlRequest = URLRequest(url: url)
            
            // 4. Create URLSession object with default configuration
            let urlSession = URLSession(configuration: .default)
            
            // 5. Create Task from URLSession object with completion handler
            // In completion we have 3 attributes:
            // a. data -> information data from request
            // b. reponse -> information about response: statuses etc.
            // c. error -> error information, if something goes wrong
            let task = urlSession.dataTask(with: urlRequest) { data, response, error in
                
                // 7. Check if have any errors
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                // 8. If no errors, unwrap Data and Parse data from JSON to Swift object type
                guard let safeData = data else { return }
                self.parseJSON(from: safeData)
            }
            // 6. Don't forget to run the Task!
            task.resume()
        }
    }
    
    private func parseJSON(from data: Data) {
        // 9. Create JSONDecoder object
        let decoder = JSONDecoder()
        do {
            // 10. Call decode method from JSONDecoder which returns Decodable type Structure
            // 10.1 In decode method, pass data from request and ModelType to be parsed
            // 10.2 Decode method should in try/catch block
            // 11. That's All!
            let decodedData = try decoder.decode([HouseModel].self, from: data)
            var viewModels: [HouseViewModel] = []
            for house in decodedData {
                let viewModel = HouseViewModel(name: house.name,
                                               founderName: house.founder,
                                               colorsName: house.houseColours,
                                               ghostName: house.ghost,
                                               animalImage: UIImage(named: house.animal),
                                               elementImage: UIImage(named: house.element))
                viewModels.append(viewModel)
            }
            DispatchQueue.main.async {
                self.delegate?.onHouseDidUpdate(with: viewModels)
            }
        } catch {
            print("Cathed some error: \(error)")
        }
    }
}
