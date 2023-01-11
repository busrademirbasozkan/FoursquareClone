//
//  AddPlaceViewController.swift
//  FoursquareClone
//
//  Created by Büşra Özkan on 10.01.2023.
//

import UIKit

class AddPlaceViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var atmosphereText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Klavyeyi herhangi bir yere tıklayınca kapatmak için
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesture)
        
        //Resmin tıklanabilir olması için
        imageView.isUserInteractionEnabled = true
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageGesture)
        
    }
    

    
    @IBAction func nextButton(_ sender: Any) {
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
    //Klavyeyi kapatmak için
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    //Görsel seçmek için gerekli iki fonksiyon
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
}
