import UIKit

class SearchVC: UIViewController {
    let userNameTextField = GFTextField()
    let CTAButton = GFButton(backgroundColor: .systemBlue, title: "Get Followers")
    
    var isUsernameEntered: Bool {
        return !userNameTextField.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUserNameTF()
        configureCTAButton()
        createDismissKeyboardTapGasture()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func createDismissKeyboardTapGasture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC(){
        guard isUsernameEntered else{
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. we need to know who to look for", buttonTitle: "ok")
            return
        }
        let followerListVC = FollowerListVC()
        followerListVC.userName = userNameTextField.text
        followerListVC.title = userNameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
        
    }

    func configureUserNameTF(){
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self // connecting to delegate
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 40),
            userNameTextField.widthAnchor.constraint(equalToConstant: 300)
            
        ])
    }
    
    func configureCTAButton(){
        view.addSubview(CTAButton)
        CTAButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            CTAButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            CTAButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            CTAButton.heightAnchor.constraint(equalToConstant: 60),
            CTAButton.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    

}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
