//
//  DetailsViewController.swift
//  FoursquareClone
//
//  Created by Büşra Özkan on 10.01.2023.
//

import UIKit
import MapKit
import Parse

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var atmosphereLabel: UILabel!
    @IBOutlet weak var detailsMapKit: MKMapView!
    var choosenPlaceID = ""
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getData()
        
    }
    

    func getData(){
        //Parse İşlemleri
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", contains: choosenPlaceID)
        query.findObjectsInBackground { (objects,error) in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            }else{
                if objects != nil {
                    if objects!.count > 0 {
                        let chosenObject = objects![0]
                        if let placeName = chosenObject.object(forKey: "PlaceName") as? String{
                            self.placeLabel.text = placeName
                        }
                        if let placeType = chosenObject.object(forKey: "PlaceType") as? String{
                            self.typeLabel.text = placeType
                        }
                        if let placeAtmosphere = chosenObject.object(forKey: "PlaceAtmosphere") as? String{
                            self.atmosphereLabel.text = placeAtmosphere
                        }
                        if let placeLatitude = chosenObject.object(forKey: "PlaceLatitude") as? String{
                            if let doubleLatitude = Double(placeLatitude){
                                self.choosenLatitude = doubleLatitude
                            }
                        }
                        if let placeLongitude = chosenObject.object(forKey: "PlaceLongitude") as? String{
                            if let doubleLongitude = Double(placeLongitude){
                                self.choosenLongitude = doubleLongitude
                            }
                        }
                        if let data = chosenObject.object(forKey: "PlaceImage") as? PFFileObject{
                            data.getDataInBackground{ (data, error) in
                                if error != nil {
                                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                                    alert.addAction(okButton)
                                    self.present(alert, animated: true)
                                }else{
                                    if data != nil {
                                        self.detailsImageView.image = UIImage(data: data!)
                                    }
                                }
                                
                            }
                        }
                    }
                }
                
            }
            
        }
        
    }
    
}
