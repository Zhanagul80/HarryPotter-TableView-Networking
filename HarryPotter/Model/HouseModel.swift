//
//  HouseModel.swift
//  HarryPotter
//
//  Created by Zhanagul on 21.05.2022.
//

import Foundation

struct HouseModel: Decodable {
    let name: String
    let houseColours: String
    let animal: String
    let element: String
    let founder: String
    let ghost: String
}
