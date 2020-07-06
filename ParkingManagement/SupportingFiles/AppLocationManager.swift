//
//  AppLocationManager.swift
//  ParkingManagement
//
//  Created by iOSDev on 02/07/20.
//  Copyright © 2020 Test. All rights reserved.
//

import Foundation
import CoreLocation

enum LocationPermissions {
    case allowed
    case notAllowed
    case notDetermine
}

typealias locationCompletion =  (_ userLatitude:Double,_ userLongtitude:Double) -> Void
typealias LocationPermission =  (_ isGranted:LocationPermissions) -> Void

class AppLocationHandler: NSObject,CLLocationManagerDelegate {
    static  var csCLLocation =  CLLocationManager()
    static var  onLocationCom : locationCompletion? = nil
    var locationPer : LocationPermission? = nil
    private var  geoCoder = CLGeocoder()
    var lastFetchedLocation:CLLocation?
    private static var sharedLocationObject: AppLocationHandler = {
        let locationObject = AppLocationHandler()
        csCLLocation.delegate = locationObject
        csCLLocation.desiredAccuracy=kCLLocationAccuracyBest
        csCLLocation.distanceFilter = 200
//        csCLLocation.allowsBackgroundLocationUpdates = true
        csCLLocation.startUpdatingLocation()
//        csCLLocation.startMonitoringSignificantLocationChanges()
        return locationObject
    }()
    class func sharedLocation() -> AppLocationHandler {
        return sharedLocationObject
    }
    func checkForAuthorization(completion:@escaping LocationPermission) -> Void {
        switch( CLLocationManager.authorizationStatus() ){
        case .notDetermined:
            AppLocationHandler.csCLLocation.requestWhenInUseAuthorization()
            locationPer = completion
            break
        case .authorizedAlways , .authorizedWhenInUse:
            completion(.allowed)
            break
        case .denied:
            completion(.notAllowed)
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways,.authorizedWhenInUse:
            locationPer?(.allowed)
        case .notDetermined,.restricted:
            locationPer?(.notDetermine)
        default:
            locationPer?(.notAllowed)
        }
    }
    
    
    
    func startLocationTrack (completion:@escaping locationCompletion)->Void{
        AppLocationHandler.onLocationCom = completion
        startLocationUpdate()
    }
    func startLocationUpdate(){
        AppLocationHandler.csCLLocation.startUpdatingLocation()
//        LocationManager.csCLLocation.startMonitoringSignificantLocationChanges()
    }
    func stopLocationTrack() {
        AppLocationHandler.csCLLocation.stopUpdatingLocation()
//        LocationManager.csCLLocation.stopMonitoringSignificantLocationChanges()
    }
    //MARK: location delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locationArray = locations as NSArray
        let locationObj = locationArray.firstObject as! CLLocation
        stopLocationTrack()
        lastFetchedLocation = locationObj
        AppLocationHandler.onLocationCom?((lastFetchedLocation?.coordinate.latitude)!, (lastFetchedLocation?.coordinate.longitude)!)
    }
}
