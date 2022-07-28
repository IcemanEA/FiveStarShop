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
    
    var delegate: CellViewDelegate!
    
    @IBAction func linkButtonPressed() {
        let link = "https://github.com/\(linkButton.currentTitle ?? "")"
        delegate.openLink(link)
    }
}
