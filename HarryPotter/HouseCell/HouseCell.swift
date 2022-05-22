//
//  HouseCell.swift
//  HarryPotter
//
//  Created by Zhanagul on 21.05.2022.
//

import UIKit

final class HouseCell: UITableViewCell {
    
    @IBOutlet private weak var animalImage: UIImageView!
    @IBOutlet private weak var elementImage: UIImageView!
    @IBOutlet private weak var houseName: UILabel!
    @IBOutlet private weak var houseColours: UILabel!
    @IBOutlet private weak var founderName: UILabel!
    @IBOutlet private weak var ghostName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: HouseViewModel) {
        animalImage.image = model.animalImage
        elementImage.image = model.elementImage
        houseName.text = model.name
        houseColours.text = model.colorsName
        founderName.text = model.founderName
        ghostName.text = model.ghostName
    }
}
