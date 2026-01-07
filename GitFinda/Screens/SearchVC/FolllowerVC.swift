//
//  FolllowerVC.swift
//  GitFinda
//
//  Created by Shivang on 07/01/26.
//

import UIKit

class FolllowerVC: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var userName : String!
    var followers: [Follower] = []
    var networkManager = NetworkManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()

        getFollower()
    }
    
    func configureCollectionView(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "Cell", bundle: nil)
        
        collectionView.register( nib , forCellWithReuseIdentifier: Cell.reuseID)
        
    }
    
    func getFollower() {
        networkManager.getFollowers(for: userName, page: 1) { [weak self] followers, error in
            guard let self = self else { return }

            if let error = error {
                Task { @MainActor in
                    self.presentGFAlertOnMainThread(
                        title: "Something happened",
                        message: error,
                        buttonTitle: "ok"
                    )
                }
                return
            }

            guard let followers = followers else { return }

            Task { @MainActor in
                self.followers = followers
                self.collectionView.reloadData()
            }
        }
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FolllowerVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return followers.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Cell.reuseID,
            for: indexPath
        ) as? Cell else { return UICollectionViewCell() }

        let follower = followers[indexPath.item]
        cell.set(follower: follower)
        return cell
    }
}

extension FolllowerVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width
        let padding: CGFloat = 12
        let spacing: CGFloat = 10
        
        let availableWidth = width - (padding * 2) - spacing
        let itemWidth = availableWidth/2
        
         return CGSize(width: itemWidth, height: itemWidth + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}


