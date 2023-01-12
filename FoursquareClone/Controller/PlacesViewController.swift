//
//  PlacesViewController.swift
//  FoursquareClone
//
//  Created by Büşra Özkan on 9.01.2023.
//

import UIKit
import Parse

class PlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var placeNameArray = [String]()
    var placeIDArray = [String]()
    var selectedPlaceID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutClicked))
        
        getDatafromParse()
    }
    
    
    //Parse'dan verileri çekmek
    func getDatafromParse(){
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { (objects,error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                if objects != nil {
                    self.placeNameArray.removeAll(keepingCapacity: false)
                    self.placeIDArray.removeAll(keepingCapacity: false)
                    
                    for object in objects! {
                        if let placeName = object.object(forKey: "PlaceName") as? String{
                            if let placeID = object.objectId {
                                self.placeNameArray.append(placeName)
                                self.placeIDArray.append(placeID)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //istenen cell tıklanınca yapılacak işlemler
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlaceID = placeIDArray[indexPath.row]
        self.performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let destination = segue.destination as! DetailsViewController
            destination.choosenPlaceID = selectedPlaceID
        }
    }
    

    @objc func addClicked(){
        performSegue(withIdentifier: "toAddVC", sender: nil)
        
    }
    
    // Log out işlemleri
    @objc func logoutClicked() {
        PFUser.logOutInBackground { (error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                self.performSegue(withIdentifier: "toMainVC", sender: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArray[indexPath.row]
        return cell
    }
    

}
