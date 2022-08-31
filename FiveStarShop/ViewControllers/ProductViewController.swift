//
//  ProductViewController.swift
//  FiveStarShop
//
//  Created by Egor Ledkov on 28.08.2022.
//

import UIKit

class ProductViewController: UIViewController, ProductCellProtocol {
    // MARK: - private properties
    private lazy var scrollView: UIScrollView = {
        UIScrollView()
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "imagePlaceholder")
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        createLabel(with: "Название:", andFont: UIFont.systemFont(ofSize: 18))
    }()
    private lazy var priceLabel: UILabel = {
        createLabel(with: "Цена:", andFont: UIFont.boldSystemFont(ofSize: 19))
    }()
    private lazy var descriptionLabel: UILabel = {
        createLabel(with: "Описание:", andFont: UIFont.boldSystemFont(ofSize: 18))
    }()
    private lazy var descriptionTextLabel: UILabel = {
        let label = createLabel(with: "", andFont: UIFont.systemFont(ofSize: 17))
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        setupStackView(
            with: imageView,
            nameLabel,
            priceLabel,
            descriptionLabel,
            descriptionTextLabel
        )
        
        setupConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        imageView.layer.cornerRadius = 10
    }
    
    // MARK: - Public methods
    func configure(_ product: Product) {
        title = product.article
        nameLabel.text = product.name
        priceLabel.text = (product.price ?? 0).toRubleCurrency()
        descriptionTextLabel.text = product.description
        updateImage(withName: product.article ?? "")
    }
    
    // MARK: - Private methoods
    private func updateImage(withName name: String) {
        guard let url = getImageURL(for: name) else { return }
        getImage(from: url) { [weak self] result in
            switch result {
            case .success(let image):
                self?.imageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupStackView(with subviews: UIView...) {
        subviews.forEach { view in
            stackView.addArrangedSubview(view)
        }
    }
    
    private func setupConstraints() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.topAnchor,
                constant: 0
            ),
            stackView.leadingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.leadingAnchor,
                constant: 16
            ),
            stackView.trailingAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.trailingAnchor
            ),
            stackView.bottomAnchor.constraint(
                equalTo: scrollView.contentLayoutGuide.bottomAnchor,
                constant: -20
            ),
            stackView.widthAnchor.constraint(
                equalTo: scrollView.frameLayoutGuide.widthAnchor,
                constant: -32)
        ])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(
                equalTo: scrollView.heightAnchor, multiplier: 0.424107, constant: 0)
        ])
    }
    
    private func createLabel(with text: String, andFont font: UIFont) -> UILabel {
        let label = UILabel()
        
        label.font = font
        label.text = text
        
        return label
    }
}
