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
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.image = UIImage(named: "placeholder")
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Titulo"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 2
        
        return label
    }()
    
    private lazy var titleBackground: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
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
    func setupInfo(show: Show) {
        if let showImageUrl = show.show?.image?.original {
            self.imageView.image = UIImage.getImage(from: showImageUrl)
        }
        self.titleLabel.text = show.show?.name

    }
    
    internal func setupConfig() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleBackground)
        titleBackground.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleBackground.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -5),
            titleBackground.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleBackground.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            titleBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.trailingAnchor.constraint(equalTo: titleBackground.trailingAnchor, constant: -7),
            titleLabel.leadingAnchor.constraint(equalTo: titleBackground.leadingAnchor, constant: 7),
            titleLabel.bottomAnchor.constraint(equalTo: titleBackground.bottomAnchor, constant: -7)
        ])
    }
}
