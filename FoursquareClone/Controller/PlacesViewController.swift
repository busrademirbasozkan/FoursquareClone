//
//  PlacesViewController.swift
//  FoursquareClone
//
//  Created by Büşra Özkan on 9.01.2023.
//

import UIKit

class PlacesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addClicked))
    }
    

    @objc func addClicked(){
        
    }

}
