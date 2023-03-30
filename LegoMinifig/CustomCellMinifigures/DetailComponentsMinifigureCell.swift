//
//  DetailComponentsMinifigureCell.swift
//  LegoMinifig
//
//  Created by Nicola Rigoni on 28/03/23.
//

import UIKit

class DetailComponentsMinifigureCell: UITableViewCell {
    
    static let identifier = "DetailComponentsMinifigureCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailComponentsMinifigureCell", bundle: nil)
    }
    
    public func configure(setProperty: SetPropertyModel){
        if let imageData = setProperty.coverImage, let image = UIImage(data: imageData) {
            coverImage.image = image
        }
        
        titleLabel.text = setProperty.name
        
        
        addToUserButton.isHidden = setProperty.userHas ?? false
    }

    @IBOutlet weak var addToUserButton: UIButton!
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func addToUser(_ sender: UIButton) {
        
        print("pressed")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
