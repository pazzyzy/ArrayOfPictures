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
    
    @IBOutlet weak var price: UILabel!
    
    var number:Int = 0
    var arrayOfPictures: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstPlaceOfPicture()
        createBikeCatalog()
    }
    
    func firstPlaceOfPicture() {
        image.frame = CGRect(x: CGFloat((containerView.frame.width) / 2 - (image.frame.width / 2)), y: CGFloat((containerView.frame.height) / 2 - (image.frame.height / 2)), width: image.frame.width, height: image.frame.height)
    }
    
    func createBikeCatalog() {
        arrayOfPictures += [UIImage(named: "1.jpg")!, UIImage(named: "2.jpg")!, UIImage(named: "3.jpg")!, UIImage(named: "4.jpg")!, UIImage(named: "5.jpg")!, UIImage(named: "6.jpg")!, UIImage(named: "7.jpg")!, UIImage(named: "8.jpg")!, UIImage(named: "9.jpg")!, UIImage(named: "10.jpg")!, UIImage(named: "11.jpg")!, UIImage(named: "12.jpg")!, UIImage(named: "13.jpg")!, UIImage(named: "14.jpg")!, UIImage(named: "15.jpg")!, UIImage(named: "cat.jpg")!]
        image.image = arrayOfPictures[number]
    }
    
    @IBAction func actionNextImage(_ sender: Any) {
        
        price.text = String(Int.random(in: 300...999))
        
        if number == (arrayOfPictures.count - 1) {
            number = 0
            print("Поехали сначала!")
        }
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn) {
            // перемещаем картинку за правую границу экрана
            self.image.frame = CGRect(x: CGFloat((self.containerView.frame.width) / 2 + 200), y: CGFloat((self.containerView.frame.height) / 2 - (self.image.frame.height / 2)), width: self.image.frame.width, height: self.image.frame.height)
        } completion: { isFinished in
            // после завершения меняем начинку вьюхи другой картинкой
            self.number += 1
            self.image.image = self.arrayOfPictures[self.number]
            //меняем месторасположения картинка (за левую границу экрана)
            self.image.frame = CGRect(x: CGFloat((self.containerView.frame.width) / 2 - 500), y: CGFloat((self.containerView.frame.height) / 2 - (self.image.frame.height / 2)), width: self.image.frame.width, height: self.image.frame.height)
            // перемещаем новую картинку в центр
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseOut) {
                self.image.frame = CGRect(x: CGFloat((self.containerView.frame.width) / 2 - (self.image.frame.width / 2)), y: CGFloat((self.containerView.frame.height) / 2 - (self.image.frame.height / 2)), width: self.image.frame.width, height: self.image.frame.height)
            }
        }
    }
    
}

