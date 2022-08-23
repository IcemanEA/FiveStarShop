//
//  CatalogTableViewController.swift
//  FiveStarShop
//
//  Created by Dimondr on 27.07.2022.
//

import UIKit

protocol CatalogViewCellDelegate {
    func calculateTotalSum(with purchase: Purchase)
}

class CatalogTableViewController: UIViewController {
        
    // MARK: - IBOutlets and public properties
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var totalSumLabel: UILabel!
    @IBOutlet var purchaseInfo: UIView!
    @IBOutlet var cartInButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var delegate: TabBarControllerDelegate!
    var purchases: [Purchase] = []
    
    // MARK: - Private properties
    
    private var refreshControl = UIRefreshControl()
    private var totalSum = 0 {
        didSet {
            totalSumLabel.text = totalSum.toRubleCurrency()
            updateUI()
        }
    }
    
    // MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRefreshControl()
        
        cartInButton.layer.cornerRadius = 15
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        purchases = purchases.map { Purchase(product: $0.product, count: 0) }
        
        let cart = DataStore.shared.cart
        cart.forEach { purchase in
            if let index = purchases.firstIndex(where: { $0 == purchase }) {
                purchases[index].count = purchase.count
            }
        }
        getTotalCartSum()
        tableView.reloadData()
        updateUI()
    }
    
    // MARK: - IBActions
    
    @IBAction func cartInButtonPressed() {
        
        let cart = purchases.filter { purchase in
            purchase.count > 0
        }
        
        DataStore.shared.cart = cart
        
        delegate.openTab(with: .purchases)
    }
    
    // MARK: - Private methods
    
    private func updateUI() {
        var bottom: CGFloat
        if totalSum == 0 {
            purchaseInfo.isHidden = true
            bottom = 0
        } else {
            purchaseInfo.isHidden = false
            bottom = CGFloat(purchaseInfo.frame.height)
        }
                
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)
    }
    
    private func getTotalCartSum() {
        totalSum = 0
        for purchase in purchases {
            totalSum += purchase.totalPrice
        }
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(fetchProducts), for: .valueChanged)
        refreshControl.tintColor = .systemIndigo
        tableView.refreshControl = refreshControl
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
            
            guard let detailVC = segue.destination as? ProductDetailViewController else { return }
            detailVC.product = purchases[indexPath.row].product
        }
    }
    
}

// MARK: - UITableViewDataSource
extension CatalogTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        purchases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "CatalogCell",
                for: indexPath
            ) as? CatalogViewCell
        else { return UITableViewCell() }

        cell.delegate = self
        cell.purchase = purchases[indexPath.row]
        cell.configure()

        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension CatalogTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
}
// MARK: - NetWorking
extension CatalogTableViewController {
    @objc private func fetchProducts() {

        NetworkManager.shared.fetch(
            [Product].self,
            from: NetworkManager.shared.getLink(.allProducts))
        { [weak self] result in
            switch result {
            case .success(let products):
                DataStore.shared.products = products
                
                self?.purchases = []
                for product in products {
                    self?.purchases.append(Purchase(product: product, count: 0))
                }
                
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
                self?.activityIndicator?.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - PurchaseViewCellDelegate
extension CatalogTableViewController: CatalogViewCellDelegate {
    
    func calculateTotalSum(with purchase: Purchase) {
        if let index = purchases.firstIndex(where: { $0 == purchase }) {
            purchases[index] = purchase
        }
        
        let cart = purchases.filter { purchase in
            purchase.count > 0
        }
        
        DataStore.shared.cart = cart
        
        getTotalCartSum()
    }
    
}
