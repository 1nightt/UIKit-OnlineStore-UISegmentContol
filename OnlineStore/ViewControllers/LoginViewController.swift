import UIKit

/// Экран входа
final class LoginViewController: UIViewController, UITextFieldDelegate {
    private let imageLogo = UIImageView()
    private var welcomeLabel = UILabel()
    private var loginLabel = UILabel()
    private var passwordLabel = UILabel()
    private var loginTextField = UITextField()
    private var passwordTextField = UITextField()
    private var nextScreenButton = UIButton(type: .system)
    private var hidePasswordButton = UIButton()
    private var loginImage = UIImageView(image: UIImage(systemName: "person.fill"))
    private var passwordImage = UIImageView(image: UIImage(systemName: "lock.fill"))
    
    private var textColor = UIColor(red: 255/255.0, green: 245/255.0, blue: 255/255.0, alpha: 1.0)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
        
        
        view.backgroundColor = UIColor(red: 53/255.0, green: 60/255.0, blue: 63/255.0, alpha: 1.0)
        
        setupForView()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Private Methods
    private func setupForView() {
        imageLogo.frame = CGRect(x: 0, y: 50, width: 350, height: 234)
        imageLogo.center.x = view.center.x
        imageLogo.image = .nike
        view.addSubview(imageLogo)
        
        welcomeLabel.text = "Welcome to shop"
        welcomeLabel.font = .systemFont(ofSize: 30)
        welcomeLabel.frame = CGRect(x: 0, y: 300, width: 300, height: 50)
        welcomeLabel.center.x = view.center.x
        welcomeLabel.textAlignment = .center
        welcomeLabel.textColor = textColor
        view.addSubview(welcomeLabel)
        
        loginLabel.text = "Login"
        loginLabel.textColor = textColor
        loginLabel.font = .systemFont(ofSize: 20)
        loginLabel.frame = CGRect(x: 60, y: 400, width: 100, height: 25)
        view.addSubview(loginLabel)
        
        loginImage.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        loginImage.contentMode = .scaleAspectFit
        loginImage.tintColor = .lightGray
        loginTextField.leftView = loginImage
        loginTextField.leftViewMode = .always
        loginTextField.borderStyle = .roundedRect
        loginTextField.textColor = .black
        loginTextField.placeholder = "Введите логин"
        loginTextField.backgroundColor = textColor
        loginTextField.frame = CGRect(x: 0, y: 430, width: 300, height: 35)
        loginTextField.center.x = view.center.x
        loginTextField.returnKeyType = .done
        view.addSubview(loginTextField)
        
        passwordLabel.text = "Пароль"
        passwordLabel.textColor = textColor
        passwordLabel.font = .systemFont(ofSize: 20)
        passwordLabel.frame = CGRect(x: 60, y: 485, width: 100, height: 25)
        view.addSubview(passwordLabel)
        
        passwordImage.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        passwordImage.tintColor = .lightGray
        passwordTextField.leftView = passwordImage
        passwordTextField.leftViewMode = .always
        passwordTextField.contentMode = .scaleToFill
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.textColor = .black
        passwordTextField.backgroundColor = textColor
        passwordTextField.placeholder = "Введите пароль"
        passwordTextField.frame = CGRect(x: 0, y: 515, width: 300, height: 35)
        passwordTextField.center.x = view.center.x
        passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = .done
        view.addSubview(passwordTextField)
        
        hidePasswordButton.frame = CGRect(x: 310, y: 517 , width: 52, height: 31)
        hidePasswordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        hidePasswordButton.imageView?.tintColor = .black
        view.addSubview(hidePasswordButton)
        hidePasswordButton.addTarget(self, action: #selector(showHidePassword(target:)), for: .touchUpInside)
        
        nextScreenButton.setTitle("Войти", for: .normal)
        nextScreenButton.backgroundColor = .black
        nextScreenButton.setTitleColor(textColor, for: .normal)
        nextScreenButton.layer.cornerRadius = 20
        nextScreenButton.frame = CGRect(x: 0, y: 600, width: 150, height: 40)
        nextScreenButton.center.x = view.center.x
        view.addSubview(nextScreenButton)
        nextScreenButton.addTarget(self, action: #selector(nextScreen(target: )), for: .touchUpInside)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    @objc private func showHidePassword(target: UIButton) {
        if self.passwordTextField.isSecureTextEntry {self.passwordTextField.isSecureTextEntry = false}
        else { self.passwordTextField.isSecureTextEntry = true }
        
        if !passwordTextField.isSecureTextEntry {
            self.hidePasswordButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            self.hidePasswordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
    @objc private func nextScreen(target: UIButton) {
        if passwordTextField.text!.isEmpty && loginTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Ошибка", message: "Введите все данные", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okButton)
            self.present(alertController, animated: true, completion: nil)
        } else if loginTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Ошибка", message: "Введите логин", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okButton)
            self.present(alertController, animated: true, completion: nil)
        } else if passwordTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Ошибка", message: "Введите пароль", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okButton)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let secondVC = ChoosingSneakersViewController()
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
}

