//
//  HomeLocations.swift
//  Herway
//
//  Created by Faizan Ali  on 2022/5/28.
//

import Foundation
import CoreLocation
import Alamofire
import GoogleMaps
import GooglePlacesSearchController


extension HomeVC {
    
    func setupNearbyDriversOnMap() {
        
        var i = 0
        for data in self.nearDrivers{
            if let lat = data.latitude, let long = data.longitude {
                let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
                print("location: \(location)")
                
                if i == 0 {
                    nearbyDriversMarker1.position = location
                    let url = "\(IMAGE_BASE_URL)\(data.avatar ?? "")"
                    
                    if data.avatar != nil && data.avatar != "" {
                        
                    let imageView = UIImageView(image: UIImage.init(named: "mapCarIcon"))
                    imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage.init(named: "mapCarIcon"))
                    
                    DispatchQueue.main.async() {
                            let pinImage = imageView.image
                                let size = CGSize(width: 44, height: 44)
                                UIGraphicsBeginImageContext(size)
                                pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                        self.nearbyDriversMarker1.icon = resizedImage?.circularImage(22)

                            }
                    nearbyDriversMarker1.snippet = ""
                    nearbyDriversMarker1.map = self.googleMapView
                    }
                    
                } else if i == 1 {
                    nearbyDriversMarker2.position = location
                    let url = "\(IMAGE_BASE_URL)\(data.avatar ?? "")"
                    
                    if data.avatar != nil && data.avatar != "" {
                        
                    let imageView = UIImageView(image: UIImage.init(named: "mapCarIcon"))
                    imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage.init(named: "mapCarIcon"))
                    
                    DispatchQueue.main.async() {
                            let pinImage = imageView.image
                                let size = CGSize(width: 44, height: 44)
                                UIGraphicsBeginImageContext(size)
                                pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                        self.nearbyDriversMarker2.icon = resizedImage?.circularImage(22)

                            }
                    nearbyDriversMarker2.snippet = ""
                    nearbyDriversMarker2.map = self.googleMapView
                    }
                    
                } else if i == 2 {
                    nearbyDriversMarker3.position = location
                    let url = "\(IMAGE_BASE_URL)\(data.avatar ?? "")"
                    let imageView = UIImageView(image: UIImage.init(named: "mapCarIcon"))
                    imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage.init(named: "mapCarIcon"))
                    
                    DispatchQueue.main.async() {
                            let pinImage = imageView.image
                                let size = CGSize(width: 44, height: 44)
                                UIGraphicsBeginImageContext(size)
                                pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                        self.nearbyDriversMarker3.icon = resizedImage?.circularImage(22)

                            }
                    nearbyDriversMarker3.snippet = ""
                    nearbyDriversMarker3.map = self.googleMapView
                    
                    
                } else if i == 3 {
                    nearbyDriversMarker4.position = location
                    let url = "\(IMAGE_BASE_URL)\(data.avatar ?? "")"
                    let imageView = UIImageView(image: UIImage.init(named: "mapCarIcon"))
                    imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage.init(named: "mapCarIcon"))
                    DispatchQueue.main.async() {
                            let pinImage = imageView.image
                                let size = CGSize(width: 44, height: 44)
                                UIGraphicsBeginImageContext(size)
                                pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                        self.nearbyDriversMarker4.icon = resizedImage?.circularImage(22)

                            }
                    
                    nearbyDriversMarker4.snippet = ""
                    nearbyDriversMarker4.map = self.googleMapView
                    
                    
                } else if i == 4 {
                    nearbyDriversMarker5.position = location
                    let url = "\(IMAGE_BASE_URL)\(data.avatar ?? "")"
                    let imageView = UIImageView(image: UIImage.init(named: "mapCarIcon"))
                    imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage.init(named: "mapCarIcon"))
                    DispatchQueue.main.async() {
                            let pinImage = imageView.image
                                let size = CGSize(width: 44, height: 44)
                                UIGraphicsBeginImageContext(size)
                                pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                        self.nearbyDriversMarker5.icon = resizedImage?.circularImage(22)

                        }
                    
                    nearbyDriversMarker5.iconView = imageView
                    nearbyDriversMarker5.snippet = ""
                    nearbyDriversMarker5.map = self.googleMapView
                    
                    
                } else if i == 5 {
                    nearbyDriversMarker6.position = location
                    let url = "\(IMAGE_BASE_URL)\(data.avatar ?? "")"
                    let imageView = UIImageView(image: UIImage.init(named: "mapCarIcon"))
                    imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage.init(named: "mapCarIcon"))
                    DispatchQueue.main.async() {
                            let pinImage = imageView.image
                                let size = CGSize(width: 44, height: 44)
                                UIGraphicsBeginImageContext(size)
                                pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                                let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
                        self.nearbyDriversMarker6.icon = resizedImage?.circularImage(22)

                        }
                    
//                    nearbyDriversMarker6.iconView = imageView
                    nearbyDriversMarker6.snippet = ""
                    nearbyDriversMarker6.map = self.googleMapView
                    
                    
                }
                i = i + 1
                
            }
        }
        
    }
    
    func setupMaps() {
//        sourceMarker.position = CLLocationCoordinate2D(latitude: currentLat, longitude: currentLng)
//        sourceMarker.title = ""
//        sourceMarker.snippet = ""
//        sourceMarker.icon = nil// UIImage.init(named: "launchScreenIcon")
//        sourceMarker.map = self.googleMapView
        
        
//        guard let request = self.localRequest else { return }
//
//        if request.status == "STARTED" {
//            destinationLat = request.sLatitude ?? 33.6973
//            destinationLng = request.sLongitude ?? 73.0515
//
//        } else if request.status == "PICKEDUP" {
//            destinationLat = request.dLatitude ?? 33.6973
//            destinationLng = request.dLongitude ?? 73.0515
//        } else {
//            return
//        }
        // MARK: Marker for destination location
        
        if currentState == .initial { return }
        
        if currentState != .search {
            if destinationLat == nil || destinationLng == nil {
                self.destinationLat = self.currentRequest?.dLatitude
                self.destinationLng = self.currentRequest?.dLongitude
                 
            }
        }
        
        if destinationLat == nil || destinationLng == nil {
            return
        }
//        let destinationMarker = GMSMarker()
//        destinationMarker.position = CLLocationCoordinate2D(latitude: destinationLat!, longitude: destinationLng!)
//        destinationMarker.title = ""
//        destinationMarker.snippet = ""
//        destinationMarker.map = self.googleMapView
        
        let currentLocation = CLLocationCoordinate2D(latitude: currentLat, longitude: currentLng)
        let desticationLocation = CLLocationCoordinate2D(latitude: destinationLat!, longitude: destinationLng!)
        
        
        nearbyDriversMarker1.map = nil
        nearbyDriversMarker1 = GMSMarker()
        nearbyDriversMarker2.map = nil
        nearbyDriversMarker2 = GMSMarker()
        nearbyDriversMarker3.map = nil
        nearbyDriversMarker3 = GMSMarker()
        nearbyDriversMarker4.map = nil
        nearbyDriversMarker4 = GMSMarker()
        nearbyDriversMarker5.map = nil
        nearbyDriversMarker5 = GMSMarker()
        nearbyDriversMarker6.map = nil
        nearbyDriversMarker6 = GMSMarker()
        
        drawMap(SourceCordinate: currentLocation, destinationcordinate: desticationLocation)
        
//        getRoute(from: sourceMarker.position, to: destinationMarker.position)
    }
    
    func drawMap(SourceCordinate : CLLocationCoordinate2D, destinationcordinate :CLLocationCoordinate2D)
       {
           self.googleMapView.clear()
           let str = String(format:"https://maps.googleapis.com/maps/api/directions/json?origin=\(SourceCordinate.latitude),\(SourceCordinate.longitude)&destination=\(destinationcordinate.latitude),\(destinationcordinate.longitude)&key=\("AIzaSyDgxUkkfvb-L-bQyr5_WFbj18w2swdn1QY")")
           print(str)
           AF.request(str).responseJSON { (response) -> Void in
            
            switch response.result {
            case let .success(value):
                
                print(value)
                if let resJson = value as? NSDictionary {
                    guard let routes = resJson["routes"] as? NSArray else {
                        print("No")
                        return
                    }
                    if(resJson["status"] as? String == "ZERO_RESULTS"){
                        print("ZERO_RESULTS")
                    } else if(resJson["status"] as? String == "NOT_FOUND"){
                        print("NOT_FOUND")
                    } else if routes.count == 0{
                        print("ZERO")
                    } else{
                        
                        let position = CLLocationCoordinate2D(latitude: SourceCordinate.latitude, longitude: SourceCordinate.longitude)
                        
                                           let pathv : NSArray = routes.value(forKey: "overview_polyline") as! NSArray
                                           let paths : NSArray = pathv.value(forKey: "points") as! NSArray
                                           let newPath = GMSPath.init(fromEncodedPath: paths[0] as! String)
                                           let polyLine = GMSPolyline(path: newPath)
                                           polyLine.strokeWidth = 5
                                           polyLine.strokeColor =  .black
                                           let ThemeOrange = GMSStrokeStyle.solidColor( .black)
                                           let OrangeToBlue = GMSStrokeStyle.gradient(from:  .black, to:  .black)
                                           polyLine.spans = [GMSStyleSpan(style: ThemeOrange),
                                                             GMSStyleSpan(style: ThemeOrange),
                                                             GMSStyleSpan(style: OrangeToBlue)]
                                           polyLine.map = self.googleMapView
                        
                    }
                }
                
                
                
            case let .failure(error):
                print(error.localizedDescription)
        }
            

           }
       }
}


//MARK: GetPlaces Delegate.
extension HomeVC: GooglePlacesAutocompleteViewControllerDelegate {
    
    func viewController(didAutocompleteWith place: PlaceDetails) {
        print(place.description)
        if isFromDestination {

            self.lblDestination.textColor = .primaryColor
            lblDestination.text = place.name
            destinationLat = place.coordinate?.latitude ?? 33.6973
            destinationLng = place.coordinate?.longitude ?? 73.1515
        } else {
            lblPickup.text = place.name
            currentLat = place.coordinate?.latitude ?? 33.5969
            currentLng = place.coordinate?.longitude ?? 73.0528
            
        }
        self.getRideServices { msg, success in
            self.setupStates()
            self.setupMaps()
        }
        
        
        placesSearchController.isActive = false
       
    }
}


//MARK: Setup Location.
extension HomeVC: CLLocationManagerDelegate {
    
    func setupLocation() {
        locationManager = CLLocationManager()
        self.locationSetup()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                
                let currentlocation = CLLocation(latitude: currentLat, longitude: currentLng)
                let distanceInMeters =  currentlocation.distance(from: location)
                if distanceInMeters > 10 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.currentLat = location.coordinate.latitude
                        self.currentLng = location.coordinate.longitude
                        
                        let camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: self.currentLat, longitude: self.currentLng), zoom: 16)
                        self.googleMapView.animate(to: camera)
                        self.googleMapView.clear()
                        self.setupMaps()
                    }
                    
                    print("Found user's location: \(location)")
                }
                
                print("Found user's location NOOO: \(location)")
            }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func locationSetup(showAlert: Bool = false){
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined {
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if status == .denied || status == .restricted {
            if showAlert {
            
                let alert = UIAlertController(title: R.string.localizable.oops(), message: R.string.localizable.mapsMessage(), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .default, handler: {_ in
                    
                    
                }))
                alert.addAction(UIAlertAction(
                    title: R.string.localizable.settings(),
                    style: UIAlertAction.Style.default,
                                    handler: {_ in
                                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                                        
                                        if UIApplication.shared.canOpenURL(settingsUrl) {
                                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                                print("Settings opened: \(success)") // Prints true
                                            })
                                        }
                                        
                                    }))

                self.present(alert, animated: true, completion: nil)

            }
        }
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = 1.0
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }
}
