//
//  FollowerCell.swift
//  GitFinda
//
//  Created by Shivang on 29/12/25.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been used")
    }
    
    func set(follower: Follower) {
        avatarImageView.setImage(from: follower.avatarUrl)
        avatarImageView.layer.cornerRadius = 167/2
        avatarImageView.clipsToBounds = true
        usernameLabel.text = follower.login
    }
    
    private func configure(){
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            usernameLabel.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        
    }
    
    
}
