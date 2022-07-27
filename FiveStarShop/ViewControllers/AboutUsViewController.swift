//
//  AboutUsViewController.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 27.07.2022.
//

import UIKit

class AboutUsViewController: UITableViewController {

    private let authors = Author.getAuthors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        authors.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        116
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "authorCell",
                for: indexPath
            ) as? AuthorViewCell
        else { return UITableViewCell() }
        
        let author = authors[indexPath.row]
        
        cell.nameLabel.text = author.name
        cell.postLabel.text = author.post
        
        if author.nickname == "" {
            cell.linkButton.isHidden = true
        } else {
            cell.linkButton.isHidden = false
            cell.linkButton.setTitle(author.nickname, for: .normal)
        }
        
        if author.nickname != "", let image = UIImage(named: author.nickname) {
            cell.authorImageView.image = image
            cell.authorImageView.layer.cornerRadius = cell.authorImageView.frame.height / 2
        }
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

