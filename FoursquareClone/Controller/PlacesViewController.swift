//
//  PlacesViewController.swift
//  FoursquareClone
//
//  Created by Büşra Özkan on 9.01.2023.
//

import UIKit
import Parse

class PlacesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutClicked))
    }
    

    @objc func addClicked(){
        
    }
    
    @objc func logoutClicked() {
        PFUser.logOutInBackground { (error) in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                self.performSegue(withIdentifier: "toMainVC", sender: nil)
            }
            
        }
    }
    

}
