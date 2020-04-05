//
//  ViewController.swift
//  RouteTracker
//
//  Created by Igor on 29.03.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import CoreLocation

class GoogleMapViewController: UIViewController, HeaderControlViewDelegate {

    var header: HeaderControlView?
    var gMapView: GoogleMapView?
    let locationManager = LocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.manager?.delegate = self
        addSubviews()
    }
    
    // MARK: - Add Subviews
    
    func addSubviews() {
        addHeaderControlView()
        addGoogleMapView()
    }
    
    func addHeaderControlView() {
        
        let originX: Int = 0
        let originY: Int = 0
        let width: Int = Int(self.view.frame.size.width)
        let height: Int = 100

        let frame = CGRect(x: originX, y: originY, width: width, height: height)
        let headerView = HeaderControlView(frame: frame)
        headerView.delegate = self
        header = headerView
        
        self.view.addSubview(header!)
    }
    
    func addGoogleMapView() {
        let originX: Int = 0
        let originY: Int = 100
        let width: Int = Int(self.view.frame.size.width)
        let height: Int = Int(self.view.frame.size.height) - originY

        let frame = CGRect(x: originX, y: originY, width: width, height: height)
        let mapView = GoogleMapView(frame: frame)
        gMapView = mapView

        self.view.addSubview(gMapView!)
    }
    
    // MARK: - Location button functions
    
    func startTracker() {
        locationManager.manager?.startUpdatingLocation()
    }
    
    func stopTracker() {
        locationManager.manager?.stopUpdatingLocation()
    }
    
    func didPressedShowLastRouteButton() {
        print("didPressedShowLastRouteButton")
        if let isStarted = header?.isStartedTracker {
            if isStarted {
                showAlert()
            } else if !isStarted {
                gMapView?.showRouteTestsPath()
            }
        }
    }
    
    func didPressedStartTrackerButton() {
        if let isStoped = header?.isStartedTracker {
            if isStoped {
                gMapView?.clear()
                startTracker()
                print("Start tracker")
            } else if !isStoped {
                stopTracker()
                print("Stop tracker")
            }
        }
    }
    
    //MARK: - Alert and function for Show Last Track
    
    func showAlert() {
        let alert = UIAlertController(title: "Show Last Track!", message: "Your tracking is in progress. Stop tracking your route?", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) {
            UIAlertAction in
            self.okAlert()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            UIAlertAction in
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func okAlert() {
        gMapView?.clear()
        stopTracker()
        header?.setInStartStateTrackerButton()
        gMapView?.showRouteTestsPath()
    }

}

extension GoogleMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let lastLocation = locations.last {
            print(lastLocation)
            let position: CLLocationCoordinate2D = lastLocation.coordinate
            if let isStarted = header?.isStartedTracker {
                if isStarted {
                    gMapView?.drawRoute(position)
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
