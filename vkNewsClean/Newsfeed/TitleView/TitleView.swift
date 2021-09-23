//
//  TitleView.swift
//  vkNewsClean
//
//  Created by Никита Ломовцев on 22.09.2021.
//

import Foundation
import UIKit

protocol TitleViewViewModel{
    var photoUrlString: String? { get }
}

class TitleView: UIView{
    
    private var myTextField = insertableTextField()
    
    private var myAvatarView: WebImageView = {
       let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(myTextField)
        addSubview(myAvatarView)
        makeConstraints()
    }
    
    func set(userViewModel: TitleViewViewModel){
        myAvatarView.set(imageURL: userViewModel.photoUrlString)
    }
    
    private func makeConstraints() {
        
        // myTextField constraints
        myTextField.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        myTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4).isActive = true
        myTextField.trailingAnchor.constraint(equalTo: myAvatarView.leadingAnchor, constant: -12).isActive = true
        myTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        
        
        // myAvatarView constraints
        myAvatarView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        myAvatarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
        myAvatarView.heightAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true
        myAvatarView.widthAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myAvatarView.layer.cornerRadius = myAvatarView.frame.width / 2
        myAvatarView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
