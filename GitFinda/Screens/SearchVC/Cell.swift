//
//  Cell.swift
//  GitFinda
//
//  Created by Shivang on 07/01/26.
//

import UIKit

class Cell: UICollectionViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    static let reuseID = "FollowerCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(follower : Follower){
        usernameLabel.text = follower.login
        NetworkManager.shared.downloadImage(from: follower.avatarUrl){
            [weak self] image in
            guard let self = self else{return}
            if let image = image {
                self.avatarImageView.image = image
            }
            
        }
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width/2
        
    }

}
