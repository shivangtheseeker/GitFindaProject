//
//  FollowerTableCell.swift
//  GitFinda
//
//  Created by Shivang on 08/01/26.
//

import UIKit

class FollowerTableCell: UITableViewCell {

    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    static let reuseID = "TableCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
    }

    
}

