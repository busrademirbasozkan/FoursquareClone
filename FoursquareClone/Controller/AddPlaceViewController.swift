//
//  AddPlaceViewController.swift
//  FoursquareClone
//
//  Created by Büşra Özkan on 10.01.2023.
//

import UIKit

class AddPlaceViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var typeText: UITextField!
    @IBOutlet weak var atmosphereText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Klavyeyi herhangi bir yere tıklayınca kapatmak için
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gesture)
        
    }
    

    
    @IBAction func nextButton(_ sender: Any) {
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
}
