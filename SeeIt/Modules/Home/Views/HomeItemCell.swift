//
//  ShowItemCell.swift
//  SeeIt
//
//  Created by Rhullian Damião on 30/01/22.
//

import UIKit

class HomeItemCell: UICollectionViewCell {
    // MARK: UI
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .top
        view.clipsToBounds = true
        view.image = UIImage(named: "spiderPoster")
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Titulo"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var titleBackground: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        setupConfig()
    }
    
    override func layoutSubviews() {
        setupConfig()
    }
    
    override func prepareForReuse() {
        setupConfig()
    }
    
    // MARK: METHODS
    internal func setupConfig() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleBackground)
        titleBackground.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleBackground.heightAnchor.constraint(equalToConstant: contentView.bounds.height * 0.3),
            titleBackground.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            titleBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.widthAnchor.constraint(equalTo: titleBackground.widthAnchor),
            titleLabel.heightAnchor.constraint(equalTo: titleBackground.heightAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleBackground.trailingAnchor, constant: -7),
            titleLabel.leadingAnchor.constraint(equalTo: titleBackground.leadingAnchor, constant: 7),
        ])
        setupGradient()
    }
    
    private func setupGradient() {
        let gradLayer = CAGradientLayer()
        
        gradLayer.frame = titleBackground.bounds
        gradLayer.colors = [UIColor.blue, UIColor.black]
        
        DispatchQueue.main.async {
            self.titleBackground.layer.insertSublayer(gradLayer, at: 0)
        }
        
    }
}
