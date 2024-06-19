import UIKit

/// Экран оплаты
final class PaymentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let backGroundColor = UIColor(red: 53/255.0, green: 60/255.0, blue: 63/255.0, alpha: 1.0)
    let textColor = UIColor(red: 255/255.0, green: 245/255.0, blue: 255/255.0, alpha: 1.0)
    var dateLabel = UILabel()
    var dateTextField = UITextField()
    var datePicker = UIDatePicker()
    var dateImage = UIImageView(image: UIImage(systemName: "calendar"))
    var sizeImage = UIImageView(image: UIImage(systemName: "shoe.fill"))
    
    var sizeLabel = UILabel()
    var sizeTextField = UITextField()
    var sizePicker = UIPickerView()
    
    var colorLabel = UILabel()
    var colorTextField = UITextField()
    var colorPicker = UIPickerView()
    
    var sizeData = Array(39...45)
    var colorData = ["Красный", "Черный", "Белый", "Синий", "Салатовый"]
    
    var payButton = UIButton(type: .system)
    var priceLabel = UILabel()
    var priceArray = SneakerCharacteristicks()
    var price = Int()
    var selectedSegmentIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backGroundColor
        setupForVC()
        setupForPicker()
        createDatePicker()
        createToolBar()
        createToolBarForPicker()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func getPrice() -> Int {
        if selectedSegmentIndex == 0 {
            price = priceArray.priceArray[0]
            return price
        } else if selectedSegmentIndex == 1 {
            price = priceArray.priceArray[1]
            return price
        } else {
            price = priceArray.priceArray[2]
            return price
        }
    }
    
    private func createDatePicker() {
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.datePickerMode = .date
        }
        datePicker.minimumDate = .now
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = createToolBar()
    }
    
    private func setupForPicker() {
        sizePicker.delegate = self
        sizePicker.dataSource = self
        sizeTextField.inputView = sizePicker
        
        colorPicker.delegate = self
        colorPicker.dataSource = self
        colorTextField.inputView = colorPicker
    }
    
    private func setupForVC() {
        dateLabel.text = "Выберите дату доставки:"
        dateLabel.frame = CGRect(x: 0, y: 100, width: 300, height: 20)
        dateLabel.center.x = view.center.x
        dateLabel.textColor = .white
        dateLabel.textAlignment = .justified
        dateLabel.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(dateLabel)
        
        dateImage.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        dateImage.contentMode = .scaleAspectFit
        dateImage.tintColor = .lightGray
        dateTextField.frame = CGRect(x: 0, y: 130, width: 300, height: 35)
        dateTextField.center.x = view.center.x
        dateTextField.leftView = dateImage
        dateTextField.leftViewMode = .always
        dateTextField.borderStyle = .roundedRect
        dateTextField.backgroundColor = textColor
        dateTextField.placeholder = "Дата"
        view.addSubview(dateTextField)
        
        sizeImage.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        sizeImage.tintColor = .lightGray
        sizeTextField.leftView = sizeImage
        sizeTextField.leftViewMode = .always
        sizeTextField.contentMode = .scaleToFill
        sizeLabel.frame = CGRect(x: 0, y: 180, width: 300, height: 35)
        sizeLabel.center.x = view.center.x
        sizeLabel.text = "Выберите размер:"
        sizeLabel.textColor = .white
        sizeLabel.textAlignment = .justified
        sizeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(sizeLabel)
        
        sizeTextField.frame = CGRect(x: 0, y: 215, width: 300, height: 35)
        sizeTextField.center.x = view.center.x
        sizeTextField.placeholder = "Размер"
        sizeTextField.borderStyle = .roundedRect
        sizeTextField.backgroundColor = textColor
        view.addSubview(sizeTextField)
        
        colorLabel.frame = CGRect(x: 0, y: 265, width: 300, height: 35)
        colorLabel.center.x = view.center.x
        colorLabel.textColor = textColor
        colorLabel.textAlignment = .justified
        colorLabel.font = UIFont.boldSystemFont(ofSize: 20)
        colorLabel.text = "Выберите цвет:"
        view.addSubview(colorLabel)
        
        colorTextField.frame = CGRect(x: 0, y: 305, width: 300, height: 35)
        colorTextField.center.x = view.center.x
        colorTextField.placeholder = "Цвет"
        colorTextField.backgroundColor = textColor
        colorTextField.borderStyle = .roundedRect
        view.addSubview(colorTextField)
        
        priceLabel.frame = CGRect(x: 0, y: 400, width: 500, height: 35)
        priceLabel.center.x = view.center.x
        priceLabel.textColor = textColor
        priceLabel.font = UIFont.boldSystemFont(ofSize: 30)
        priceLabel.textAlignment = .center
        priceLabel.text = "К оплате - \(String(describing: getPrice())) р"
        view.addSubview(priceLabel)
        
        payButton.frame = CGRect(x: 0, y: 450, width: 170, height: 45)
        payButton.center.x = view.center.x
        payButton.setTitle("Оплатить", for: .normal)
        payButton.setTitleColor(.white, for: .normal)
        payButton.layer.cornerRadius = 20
        payButton.backgroundColor = .black
        view.addSubview(payButton)
        payButton.addTarget(self, action: #selector(thanksForThePurchase), for: .touchUpInside)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sizePicker {
            return sizeData.count
        } else {
            return colorData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sizePicker {
            return "\(sizeData[row])"
        } else {
            return "\(colorData[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sizePicker {
            sizeTextField.text = "\(sizeData[row])"
        } else {
            return colorTextField.text = "\(colorData[row])"
        }
    }
    
    
    
    private func createToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexibleSpace, doneButton], animated: true)
        return toolBar
    }
    
    private func createToolBarForPicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        colorTextField.inputAccessoryView = toolbar
        sizeTextField.inputAccessoryView = toolbar
    }
    
    @objc private func donePressed() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        self.dateTextField.text = formatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func thanksForThePurchase() {
        if dateTextField.text!.isEmpty || sizeTextField.text!.isEmpty || colorTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okButton)
            self.present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: "Спасибо за покупку!", message: "Ваш заказ оплачен", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okButton)
            self.present(alertController, animated: true)
        }
    }
}
