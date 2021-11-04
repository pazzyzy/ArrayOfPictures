//
//  ViewController.swift
//  27.09_ArrayOfPictures
//
//  Created by Ant Zy on 29.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nexBike: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var likeFlag: UILabel!
    
    var number:Int = 0
    var arrayOfPictures: [UIImage] = []
    var arrayOfComents: [String] = []
    var tupleArray: [(picture: UIImage, coment: String, like: Bool)] = []
    let duration = 0.7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settings()
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    func settings() {
        createBikeCatalog()
        registerForKeyboardNotifications()
        print(NSHomeDirectory())
        likeFlag.isHidden = true
        firstPlaceOfPicture()
        nexBike.addShadow()
        nexBike.addGradientWithColor(color: .white)
        nexBike.corner()
    }
    
    func firstPlaceOfPicture() {
        image.frame = CGRect(x: CGFloat((containerView.frame.width) / 2 - (image.frame.width / 2)), y: CGFloat((containerView.frame.height) / 2 - (image.frame.height / 2)), width: image.frame.width, height: image.frame.height)
        image.image = tupleArray[0].0
        if tupleArray[0].1 != "" {
            label.text = tupleArray[0].1
            textField.text = tupleArray[0].1
        }
    }
    
    func createBikeCatalog() {
        
        tupleArray += [(UIImage(named: "1.jpg")!, "", false), (UIImage(named: "2.jpg")!, "", false), (UIImage(named: "3.jpg")!, "", false), (UIImage(named: "4.jpg")!, "", false), (UIImage(named: "5.jpg")!, "", false)]
        getArray()
    }
    
    func checkComments() {
        if tupleArray[number].1 != "" {
            label.text = tupleArray[number].1
            textField.text = tupleArray[number].1
            print(tupleArray[number].1)
        } else {
            label.text = ""
            textField.text = ""
        }
    }
    
    func checkLike() {
        if tupleArray[number].2 {
            print("\(tupleArray[number].1) is already like")
            UILabel.animate(withDuration: 2, delay: 2, options: []) {
                self.likeFlag.isHidden = false
            }
        } else {
            self.likeFlag.isHidden = true
        }
    }
    
    @IBAction func actionNextImage(_ sender: Any) {
        writeArray()
        animateUIView()
    }
    
    @IBAction func actionAddLike(_ sender: Any) {
        print("makeLike")
        tupleArray[number].2 = !tupleArray[number].2
        checkLike()
    }
    
    func animateUIView() {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn) {
            // перемещаем картинку за правую границу экрана
            self.image.frame = CGRect(x: CGFloat((self.containerView.frame.width)), y: CGFloat((self.containerView.frame.height) / 2 - (self.image.frame.height / 2)), width: self.image.frame.width, height: self.image.frame.height)
        } completion: { isFinished in
            self.number += 1
            if self.number == (self.tupleArray.count) {
                self.number = 0
                print("Поехали сначала!")
            }
            
            self.checkComments()
            self.checkLike()
            self.image.image = self.tupleArray[self.number].0
            self.image.frame = CGRect(x: CGFloat(0 - self.image.frame.width), y: CGFloat((self.containerView.frame.height) / 2 - (self.image.frame.height / 2)), width: self.image.frame.width, height: self.image.frame.height)
            
            UIView.animate(withDuration: self.duration, delay: 0, options: .curveEaseOut) {
                self.image.frame = CGRect(x: CGFloat((self.containerView.frame.width) / 2 - (self.image.frame.width / 2)), y: CGFloat((self.containerView.frame.height) / 2 - (self.image.frame.height / 2)), width: self.image.frame.width, height: self.image.frame.height)
            }
        }
    }
    //MARK: - Write & read file
    func writeArray() {
        let defaults = UserDefaults.standard
        defaults.set(tupleArray[number].1, forKey: String(number))
        defaults.set(tupleArray[number].2, forKey: String(number+tupleArray.count))
    }
    
    func getArray() {
        for i in 0..<tupleArray.count {
            let defaults = UserDefaults.standard
            tupleArray[i].1 = defaults.value(forKey: String(i)) as! String
            tupleArray[i].2 = defaults.value(forKey: String(i+tupleArray.count)) as! Bool
        }
        print(tupleArray)
    }
    // MARK: -  work with keyboard
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return }
        let keyBoardScreenEndFrame = keyboardValue.cgRectValue
        let keyBoardViewEndFrame = view.convert(keyBoardScreenEndFrame, from: view.window)
        print("kbWillShow")
        print(keyBoardViewEndFrame.height)
        containerView.transform = CGAffineTransform(translationX: 0, y: -keyBoardViewEndFrame.height)
    }
    
    @objc func kbWillHide(_ notification: Notification) {
        containerView.transform = .identity
        print("kbWillHide")
    }
    
    func writeToLabelFromTextField() {
        if textField.text != nil {
            tupleArray[number].1 = textField.text!
            label.text = textField.text!
        }
    }
    
    @IBAction func actionCloseKeyboard(_ sender: Any) {
        view.endEditing(true)
        writeToLabelFromTextField()
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("shouldChangeCharactersIn")
        return true
    }
}
