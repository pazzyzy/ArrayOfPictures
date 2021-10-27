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
    
    @IBOutlet weak var constrainsForContainerVierw: NSLayoutConstraint!
    
    var number:Int = 0
    var arrayOfPictures: [UIImage] = []
    let duration = 0.7
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForKeyboardNotifications()
        
        firstPlaceOfPicture()
        createBikeCatalog()
        nexBike.addShadow()
        nexBike.addGradientWithColor(color: .white)
        nexBike.corner()
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    func firstPlaceOfPicture() {
        image.frame = CGRect(x: CGFloat((containerView.frame.width) / 2 - (image.frame.width / 2)), y: CGFloat((containerView.frame.height) / 2 - (image.frame.height / 2)), width: image.frame.width, height: image.frame.height)
    }
    
    func createBikeCatalog() {
        arrayOfPictures += [UIImage(named: "1.jpg")!, UIImage(named: "2.jpg")!, UIImage(named: "3.jpg")!, UIImage(named: "4.jpg")!, UIImage(named: "5.jpg")!, UIImage(named: "6.jpg")!, UIImage(named: "7.jpg")!, UIImage(named: "8.jpg")!, UIImage(named: "9.jpg")!, UIImage(named: "10.jpg")!, UIImage(named: "11.jpg")!, UIImage(named: "12.jpg")!, UIImage(named: "13.jpg")!, UIImage(named: "14.jpg")!, UIImage(named: "15.jpg")!, UIImage(named: "cat.jpg")!]
        image.image = arrayOfPictures[number]
    }
    
    @IBAction func actionNextImage(_ sender: Any) {
                
        if number == (arrayOfPictures.count - 1) {
            number = 0
            print("Поехали сначала!")
        }
        animateUIView()
    }
    
    func animateUIView() {
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn) {
            // перемещаем картинку за правую границу экрана
            self.image.frame = CGRect(x: CGFloat((self.containerView.frame.width)), y: CGFloat((self.containerView.frame.height) / 2 - (self.image.frame.height / 2)), width: self.image.frame.width, height: self.image.frame.height)
        } completion: { isFinished in
            // после завершения меняем начинку вьюхи другой картинкой
            self.number += 1
            self.image.image = self.arrayOfPictures[self.number]
            //меняем месторасположения картинка (за левую границу экрана)
            self.image.frame = CGRect(x: CGFloat(0 - self.image.frame.width), y: CGFloat((self.containerView.frame.height) / 2 - (self.image.frame.height / 2)), width: self.image.frame.width, height: self.image.frame.height)
            // перемещаем новую картинку в центр
            UIView.animate(withDuration: self.duration, delay: 0, options: .curveEaseOut) {
                self.image.frame = CGRect(x: CGFloat((self.containerView.frame.width) / 2 - (self.image.frame.width / 2)), y: CGFloat((self.containerView.frame.height) / 2 - (self.image.frame.height / 2)), width: self.image.frame.width, height: self.image.frame.height)
            }
        }
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
//        containerView.frame = CGRect(x: containerView.frame.minX, y: (containerView.frame.minY - keyBoardViewEndFrame.height), width: containerView.frame.width, height: containerView.frame.height)
        
        constrainsForContainerVierw.constant -= keyBoardViewEndFrame.height
        }
    
    @objc func kbWillHide(_ notification: Notification) {
        print("kbWillHide")
    }
}

