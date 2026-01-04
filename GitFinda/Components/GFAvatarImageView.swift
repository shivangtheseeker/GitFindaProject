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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImg
        translatesAutoresizingMaskIntoConstraints = false
    }
}
