import UIKit

/// VC Выбора кроссовок
final class ChoosingSneakersViewController: UIViewController {
    private var modelLabel = UILabel()
    private var sneakerImage = UIImageView()
    private var backgroundColor = UIColor(red: 53/255.0, green: 60/255.0, blue: 63/255.0, alpha: 1.0)
    private var textColor = UIColor(red: 255/255.0, green: 245/255.0, blue: 255/255.0, alpha: 1.0)
    private let sneakerCharacteristics = SneakerCharacteristicks()
    private var nameAndPriceLabel = UILabel()
    private var descriptionTextView = UITextView()
    private var entryButton = UIButton(type: .system)
    private var segmentControl = UISegmentedControl()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backgroundColor
        
        setupForVC()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Private Methods
    private func setupForVC() {
        modelLabel.text = "Выберите модель"
        modelLabel.font = .systemFont(ofSize: 30)
        modelLabel.textColor = .white
        modelLabel.textAlignment = .center
        modelLabel.frame = CGRect(x: 0, y: 100, width: 300, height: 30)
        modelLabel.center.x = view.center.x
        view.addSubview(modelLabel)
        
        sneakerImage.frame = CGRect(x: 0, y: 150, width: 400, height: 300)
        sneakerImage.layer.cornerRadius = sneakerImage.frame.size.width / 2
        sneakerImage.clipsToBounds = true
        sneakerImage.center.x = view.center.x
        sneakerImage.image = sneakerCharacteristics.pictureArray[0]
        sneakerImage.layer.cornerRadius = 20
        view.addSubview(sneakerImage)
        
        nameAndPriceLabel.text = "\(sneakerCharacteristics.sneakerName[0])"
        nameAndPriceLabel.textColor = textColor
        nameAndPriceLabel.textAlignment = .center
        nameAndPriceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameAndPriceLabel.frame = CGRect(x: 0, y: 470, width: 300, height: 20)
        nameAndPriceLabel.center.x = view.center.x
        view.addSubview(nameAndPriceLabel)
        
        segmentControl = UISegmentedControl(items: sneakerCharacteristics.sneakerName)
        segmentControl.selectedSegmentTintColor = .white
        segmentControl.selectedSegmentIndex = 0
        segmentControl.frame = CGRect(x: 0, y: 505, width: 400, height: 35)
        segmentControl.center.x = view.center.x
        view.addSubview(segmentControl)
        segmentControl.addTarget(self, action: #selector(changedSegmentControll(sender:)), for: .valueChanged)
        
        entryButton.setTitle("Выбрать", for: .normal)
        entryButton.backgroundColor = .black
        entryButton.setTitleColor(.white, for: .normal)
        entryButton.frame = CGRect(x: 0, y: 560, width: 170, height: 45)
        entryButton.center.x = view.center.x
        entryButton.layer.cornerRadius = 20
        view.addSubview(entryButton)
        entryButton.addTarget(self, action: #selector(nextView), for: .touchUpInside)
        
        descriptionTextView.frame = CGRect(x: 0, y: 620, width: 365, height: 220)
        descriptionTextView.center.x = view.center.x
        descriptionTextView.textColor = .white
        descriptionTextView.font = .systemFont(ofSize: 15)
        descriptionTextView.textAlignment = .justified
        descriptionTextView.isEditable = false
        descriptionTextView.backgroundColor = backgroundColor
        descriptionTextView.text = sneakerCharacteristics.descriptionArray[0]
        view.addSubview(descriptionTextView)
    }
    
    @objc func changedSegmentControll(sender: UISegmentedControl) {
        sneakerImage.image = sneakerCharacteristics.pictureArray[sender.selectedSegmentIndex]
        nameAndPriceLabel.text = sneakerCharacteristics.sneakerName[sender.selectedSegmentIndex]
        descriptionTextView.text = sneakerCharacteristics.descriptionArray[sender.selectedSegmentIndex]
    }
    
    @objc private func nextView() {
        let thirdVC = PaymentViewController()
        thirdVC.selectedSegmentIndex = segmentControl.selectedSegmentIndex
        navigationController?.pushViewController(thirdVC, animated: true)
    }
}
