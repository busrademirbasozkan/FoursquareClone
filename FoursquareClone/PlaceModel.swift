//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Büşra Özkan on 11.01.2023.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    
    private init(){
        
    }
}
