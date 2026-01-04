import UIKit

nonisolated enum FollowerListSection: Hashable, Sendable {
    case main
}

@MainActor class FollowerListVC: UIViewController {
    
    var userName: String!
    var followers: [Follower] = []

    var networkManager = NetworkManager()
    
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<FollowerListSection, Follower>!
       

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureDataSource()   // ✅ FIRST
        getFollower()           // ✅ THEN fetch data

        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let shivang = "Shivang"
    }

    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func createThreeColumnFlowLayout()-> UICollectionViewFlowLayout{
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availabeleWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availabeleWidth/3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        return flowLayout
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
                self.updateData()
            }
        }
    }

    func configureDataSource(){
        datasource = UICollectionViewDiffableDataSource<FollowerListSection, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<FollowerListSection, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        datasource.apply(snapshot, animatingDifferences: true)
    }
    

}
