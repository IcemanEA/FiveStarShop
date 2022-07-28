//
//  AboutUsViewController.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 27.07.2022.
//

import UIKit

protocol CellViewDelegate {
    func openLink(_ link: String)
}

class AboutUsViewController: UITableViewController {

    private let authors = Author.getAuthors()

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        authors.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
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
        
        let image = UIImage(named: author.nickname) ?? UIImage(named: "imagePlaceholder.png")
        cell.authorImageView.image = image
        cell.authorImageView.layer.cornerRadius = cell.authorImageView.frame.height / 2
                
        cell.delegate = self
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CellViewDelegate
extension AboutUsViewController: CellViewDelegate {
    func openLink(_ link: String) {
        let alertVC = UIAlertController(
                title: "Сайт",
                message: "Вы уверены, что хотите перейти на страницу автора?",
                preferredStyle: .alert
        )
        let actionYes = UIAlertAction(title: "Да", style: .default) {_ in
            if let url = URL(string: link) {
                UIApplication.shared.open(url)
            }
        }
        alertVC.addAction(actionYes)
        
        let actionNo = UIAlertAction(title: "Нет", style: .cancel)
        alertVC.addAction(actionNo)
        
        present(alertVC, animated: true)
    }
}
