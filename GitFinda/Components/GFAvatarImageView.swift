//
//  GFAvatarImageView.swift
//  GitFinda
//
//  Created by Shivang on 29/12/25.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImg = UIImage(named: "placeholder")!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        layer.cornerRadius = bounds.width / 2
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setImage(from urlString: String){
        image = placeholderImg
        
        NetworkManager.shared.downloadImage(from: urlString,){
            [weak self] image in
            guard let self = self else{return}
            if let image = image {
                self.image = image
            }
        }
    }
}
