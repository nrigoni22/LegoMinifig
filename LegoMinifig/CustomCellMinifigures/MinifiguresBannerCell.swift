//
//  MinifiguresBannerCell.swift
//  LegoMinifig
//
//  Created by Nicola Rigoni on 24/03/23.
//

import UIKit

class MinifiguresBannerCell: UITableViewCell {

    static let identifier = "MinifiguresBannerCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MinifiguresBannerCell", bundle: nil)
    }
    
    public func configure(setProperty: SetPropertyModel){
        
        if let imageData = setProperty.coverImage, let image = UIImage(data: imageData) {
            setImage.image = image
        }
        
        titleLabel.text = setProperty.name
        yearLabel.text = "\(setProperty.year)"
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var setImage: UIImageView!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
