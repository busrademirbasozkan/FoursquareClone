//
//  MapViewController.swift
//  FoursquareClone
//
//  Created by Büşra Özkan on 10.01.2023.
//

import UIKit
import MapKit
import CoreLocation
import Parse

class MapViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapKit: MKMapView!
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MapKit ayarları
        mapKit.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        
        //Pinleme İşlemi
        let gestureAnnotation = UILongPressGestureRecognizer(target: self, action: #selector(selectLocation(gestureAnnotation:)))
        gestureAnnotation.minimumPressDuration = 2
        mapKit.addGestureRecognizer(gestureAnnotation)

        
        
        //UIBarButtonItemler eklendi
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelClicked))
    }
    
    
    //lokasyon seçme
    @objc func selectLocation(gestureAnnotation : UILongPressGestureRecognizer) {
        if gestureAnnotation.state == .began {
            let touchedPoint = gestureAnnotation.location(in: self.mapKit)
            let touchedCoordinate = self.mapKit.convert(touchedPoint, toCoordinateFrom: self.mapKit)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinate
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            self.mapKit.addAnnotation(annotation)
            
            PlaceModel.sharedInstance.placeLatitude = String(touchedCoordinate.latitude)
            PlaceModel.sharedInstance.placeLongitude = String(touchedCoordinate.longitude)
        }
    }

    //seçilen lokasyonu kaydetme
    @objc func saveClicked() {
        //parse'a konumu kaydetme işlemi
        let placeModel = PlaceModel.sharedInstance
        
        let object = PFObject(className: "Places")
        object["PlaceName"] = placeModel.placeName
        object["PlaceType"] = placeModel.placeType
        object["PlaceAtmosphere"] = placeModel.placeAtmosphere
        object["PlaceLatitude"] = placeModel.placeLatitude
        object["PlaceLongitude"] = placeModel.placeLongitude
        //parse'a görsel kaydetmek
        if let data = placeModel.placeImage.jpegData(compressionQuality: 0.5){
            object["PlaceImage"] = PFFileObject(name: "image.jpg", data: data)
        }
        
        object.saveInBackground { (success, error) in
            if error != nil {
                let alert = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            }else{
                self.performSegue(withIdentifier: "fromMaptoPlaces", sender: nil)
            }
        }
    }
    
    //lokasyon seçmeden geri dönme
    @objc func cancelClicked() {
        dismiss(animated: true)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        let region = MKCoordinateRegion(center: location, span: span)
        mapKit.setRegion(region, animated: true)
    }

}
