//
//  AuthorViewCell.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 27.07.2022.
//

import UIKit

class AuthorViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var postLabel: UILabel!
    @IBOutlet var linkButton: UIButton!
    @IBOutlet var authorImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func linkButtonPressed() {
        if let url = URL(string: "https://github.com/\(linkButton.currentTitle ?? "")") {
            UIApplication.shared.open(url)
        }
    }

}
