

import UIKit

class DesignCodeViewController: UIViewController {
    
    
    var backgroundImageVIew: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "swift_lo")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var logoImage: UIImageView = {
        let logoImg = UIImageView()
        logoImg.image = UIImage(named: "home")
        logoImg.layer.cornerRadius = 50
        logoImg.layer.masksToBounds = true
        logoImg.contentMode = .scaleAspectFill
        logoImg.translatesAutoresizingMaskIntoConstraints = false
        return logoImg
    }()
    
    var inputContainerView: UIView = {
        let inptview = UIView()
        inptview.backgroundColor = UIColor.blue
        inptview.translatesAutoresizingMaskIntoConstraints = false
        
        return inptview
    }()
    
    var userIdTextField: UITextField = {
        let textField = UITextField()
        textField.text = "UserId"
        textField.textColor = UIColor.white
        //textField.borderStyle =
        textField.backgroundColor = UIColor.clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var firstLineseperator: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.green
        lineView.translatesAutoresizingMaskIntoConstraints = false
        return lineView
    }()
    
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Password"
        textField.textColor = UIColor.white
        //textField.borderStyle =
        textField.backgroundColor = UIColor.clear
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var secondLineseperator: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.green
        lineView.translatesAutoresizingMaskIntoConstraints = false
        return lineView
    }()
    
    
    var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.brown
        button.setTitle("LogIn", for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    @objc func handleLogin(){
        print("in login")
    }
    
    var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        button.setTitle("Register", for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    @objc func handleRegister(){
        print("in login")
    }
    
    
    var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.clear
        button.setTitle("ForgotPassword", for: .normal)
        button.contentHorizontalAlignment = .right
        
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        return button
    }()
    
    @objc func handleForgotPassword(){
        print("in login")
    }
    
    var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "    Designed and Devloped by \n   anyEmi Online Services PvtLtd"
        label.textColor = UIColor.green
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name:"FontAwesome",size:18)
        label.numberOfLines = 2
        
        
        return label
    }()
    
    
    var logoImage2: UIImageView = {
        let logoImg = UIImageView()
        logoImg.image = UIImage(named: "anyemi")
        //logoImg.contentMode = .scaleAspectFill
        logoImg.translatesAutoresizingMaskIntoConstraints = false
        return logoImg
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor.blue
        view.addSubview(backgroundImageVIew)
        view.addSubview(logoImage)
        view.addSubview(inputContainerView)
        view.addSubview(contentLabel)
        view.addSubview(logoImage2)
        setupBackgroundImage()
        setupLogoImage()
        setupInputView()
        setupContentLabel()
        setupLogoImage2()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupBackgroundImage(){
        backgroundImageVIew.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageVIew.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImageVIew.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        backgroundImageVIew.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupLogoImage(){
        
        logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupInputView(){
        inputContainerView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 30).isActive = true
        inputContainerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        inputContainerView.trailingAnchor.constraint(equalTo: backgroundImageVIew.trailingAnchor, constant:  -30).isActive = true
        inputContainerView.leadingAnchor.constraint(equalTo: backgroundImageVIew.leadingAnchor, constant: 30).isActive = true
        
        view.addSubview(userIdTextField)
        view.addSubview(firstLineseperator)
        view.addSubview(passwordTextField)
        view.addSubview(secondLineseperator)
        view.addSubview(logInButton)
        view.addSubview(registerButton)
        view.addSubview(forgotPasswordButton)
        
        
        userIdTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: 20).isActive = true
        userIdTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        userIdTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 10).isActive = true
        userIdTextField.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -10).isActive = true
        
        firstLineseperator.topAnchor.constraint(equalTo: userIdTextField.bottomAnchor, constant: 0).isActive = true
        firstLineseperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        firstLineseperator.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 10).isActive = true
        firstLineseperator.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -10).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: firstLineseperator.bottomAnchor, constant: 5).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 10).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -10).isActive = true
        
        secondLineseperator.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0).isActive = true
        secondLineseperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        secondLineseperator.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 10).isActive = true
        secondLineseperator.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -10).isActive = true
        
        
        logInButton.topAnchor.constraint(equalTo: secondLineseperator.bottomAnchor, constant: 20).isActive = true
        logInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        logInButton.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 10).isActive = true
        logInButton.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -10).isActive = true
        
        
        registerButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 20).isActive = true
        registerButton.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 10).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        forgotPasswordButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 20).isActive = true
        forgotPasswordButton.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -10).isActive = true
        forgotPasswordButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        forgotPasswordButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        
    }
    
    func setupContentLabel() {
        
        contentLabel.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 60).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: inputContainerView.leadingAnchor, constant: 50).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: inputContainerView.trailingAnchor, constant: -50).isActive = true
        contentLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func setupLogoImage2(){
        
        logoImage2.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 10).isActive = true
        logoImage2.centerXAnchor.constraint(equalTo: backgroundImageVIew.centerXAnchor).isActive = true
        logoImage2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        logoImage2.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    
}

