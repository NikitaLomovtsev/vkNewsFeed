//
//  GalleryCollectionViewCell.swift
//  vkNewsClean
//
//  Created by Никита Ломовцев on 21.09.2021.
//

import Foundation
import UIKit

class GalleryCollectionViewCell: UICollectionViewCell{
    
    static let reuseId = "GalleryCollectionViewCell"
    
    let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9098039216, alpha: 1)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(myImageView)
        
        // myImageView constraints
        
        myImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    func set(imageUrl: String?){
        myImageView.set(imageURL: imageUrl)
    }
    
    override func layoutSubviews() {
        super .layoutSubviews()
        
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = 10
        self.layer.shadowRadius = 3
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 2.5, height: 4 )
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
