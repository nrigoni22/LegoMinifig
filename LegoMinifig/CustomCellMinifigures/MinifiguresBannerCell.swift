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
    
    public func configure(title: String, image: UIImage){
        
        titleLabel.text = title
        setImage.image = image
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var setImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
