//
//  CollectionViewCell.swift
//  AvitoTest
//
//  Created by codela on 02/09/23.
//

import UIKit

protocol ItemCellInput: AnyObject {
    func setImage(image: Data?)
}

class ItemCollectionViewCell: UICollectionViewCell {
    private enum UIConstants {
        static let titleLabelFontSize: CGFloat = 16
        static let contentInset: CGFloat = 16
        static let cellCornerRadius: CGFloat = 10
    }
    private lazy var itemImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .clear
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIConstants.titleLabelFontSize)
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: UIConstants.titleLabelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: UIConstants.titleLabelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: UIConstants.titleLabelFontSize)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .black
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
        makeShadow()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImage.image = nil
        presenter?.view = nil
        presenter = nil
        [titleLabel, priceLabel, addressLabel, dateLabel].forEach({$0.text = nil})
    }
    private var presenter: ItemCellOutput?
    func configure(with item: ItemData, presenter: ItemCellOutput) {
        titleLabel.text = item.title
        priceLabel.text = item.price
        addressLabel.text = item.location
        dateLabel.text = item.createdDate
        loadingView.startAnimating()
        self.presenter = presenter
        presenter.loadImage(imageUrl: item.imageUrl)
    }
    
    private func makeShadow() {
        layer.cornerRadius =  UIConstants.cellCornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 1.5
        layer.masksToBounds =  false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: UIConstants.cellCornerRadius).cgPath
    }
    private func initialize() {
        backgroundColor = .white
        contentView.layer.cornerRadius = UIConstants.cellCornerRadius
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.distribution = .fillProportionally
        verticalStack.alignment = .leading
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        [titleLabel, priceLabel, addressLabel, dateLabel].forEach({verticalStack.addArrangedSubview($0)})
        [itemImage, verticalStack, loadingView].forEach({addSubview($0)})
        NSLayoutConstraint.activate([
            itemImage.leftAnchor.constraint(equalTo: leftAnchor),
            itemImage.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            itemImage.widthAnchor.constraint(equalTo: widthAnchor),
            itemImage.heightAnchor.constraint(equalToConstant: 150),
            
            loadingView.centerXAnchor.constraint(equalTo: itemImage.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: itemImage.centerYAnchor),
            
            verticalStack.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 16),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            verticalStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            verticalStack.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
extension ItemCollectionViewCell: ItemCellInput {
    func setImage(image: Data?) {
        loadingView.stopAnimating()
        itemImage.image = UIImage(data: image ?? Data())
    }
}
