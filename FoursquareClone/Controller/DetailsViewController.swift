//
//  DetailsViewController.swift
//  FoursquareClone
//
//  Created by Büşra Özkan on 10.01.2023.
//

import UIKit
import MapKit
import Parse

class DetailsViewController: UIViewController , MKMapViewDelegate, CLLocationManagerDelegate {

    
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
        detailsMapKit.delegate = self
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
                        
                        //Maps Ayarları
                        let location = CLLocationCoordinate2D(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
                        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                        let region = MKCoordinateRegion(center: location, span: span)
                        self.detailsMapKit.setRegion(region, animated: true)
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = location
                        annotation.title = self.placeLabel.text
                        self.detailsMapKit.addAnnotation(annotation)
                    }
                }
            }
        }
    }
    
    //pinin özelleşmesi
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "Pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier:reuseId)
            pinView?.canShowCallout = true
            pinView?.tintColor = UIColor.black
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            pinView!.rightCalloutAccessoryView = button
        }else{
            pinView?.annotation = annotation
        }
        return pinView
    }
    //pinin üzerinden navigasyyona bağlanma
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.choosenLatitude != 0.0 && self.choosenLongitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        let mkPlacemark = MKPlacemark(placemark: placemark[0])
                        let item = MKMapItem(placemark: mkPlacemark)
                        item.name = self.placeLabel.text
                        let launchOption = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                        item.openInMaps(launchOptions: launchOption)
                    }
                }
            }
        }
    }
    
}
