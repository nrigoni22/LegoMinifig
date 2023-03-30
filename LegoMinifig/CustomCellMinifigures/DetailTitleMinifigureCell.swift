//
//  DetailTitleMinifigureCell.swift
//  LegoMinifig
//
//  Created by Nicola Rigoni on 28/03/23.
//

import UIKit

class DetailTitleMinifigureCell: UITableViewCell {
    
    
    static let identifier = "DetailTitleMinifigureCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "DetailTitleMinifigureCell", bundle: nil)
    }
    
    public func configure(setProperty: SetPropertyModel){
        if let imageData = setProperty.coverImage, let image = UIImage(data: imageData) {
            coverImage.image = image
        }
        
        titleLabel.text = setProperty.name
        
        yearLabel.text = "Production year: \(setProperty.year)"
    }
    
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
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
