//
//  MapViewController.swift
//  FoursquareClone
//
//  Created by Büşra Özkan on 10.01.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapKit: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelClicked))
    }
    

    @objc func saveClicked() {
        
    }
    
    @objc func cancelClicked() {
        dismiss(animated: true)
    }
    

}
