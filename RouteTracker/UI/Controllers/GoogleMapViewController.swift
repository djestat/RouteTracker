//
//  ViewController.swift
//  RouteTracker
//
//  Created by Igor on 29.03.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import RxSwift
//import AVFoundation

final class GoogleMapViewController: UIViewController, HeaderControlViewDelegate, FooterControlViewDelegate, FooterStartViewDelegate {

    var header: HeaderControlView?
    var gMapView: GoogleMapView?
    var footerStart: FooterStartView?
    var footerControl: FooterControlView?
    var routeName: String = ""
    let routePath: GMSMutablePath = GMSMutablePath()
    let locationManager = LocationManager.instance
    let avatarManager = AvatarMarkerManager()
    let realmAdapter = RealmAdapter()
    let dateFormatter: DateFormatterHelper = DateFormatterHelper()
    let bag = DisposeBag()

    var onLogin: (() -> Void)?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addSubviews()
        configureLocationManager()
    }
    
    // MARK: - Add Subviews
    
    func addSubviews() {
        addHeaderControlView()
        addGoogleMapView()
        addFooterControlView()
        addFooterStartView()
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
        let originX: CGFloat = 0
        let originY: CGFloat = 100
        let width: CGFloat = self.view.frame.size.width
        let height: CGFloat = self.view.frame.size.height - originY

        let frame = CGRect(x: originX, y: originY, width: width, height: height)
        let mapView = GoogleMapView(frame: frame)
        gMapView = mapView

        self.view.addSubview(gMapView!)
    }
    
    func addFooterControlView() {
        let width: CGFloat = self.view.frame.size.width
        let height: CGFloat = 128
        let originX: CGFloat = 0
        let originY: CGFloat = self.view.frame.size.height - height
        
        let frame = CGRect(x: originX, y: originY, width: width, height: height)
        let footerView = FooterControlView(frame: frame)
        footerView.delegate = self
        footerControl = footerView
                
        self.view.addSubview(footerView)
    }
    
    func addFooterStartView() {
        let width: CGFloat = 90
        let height: CGFloat = width
        let originX: CGFloat = self.view.frame.midX - width / 2
        let originY: CGFloat = footerControl!.frame.origin.y - height / 2

        let frame = CGRect(x: originX, y: originY, width: width, height: height)
        let footerStartView = FooterStartView(frame: frame)
        footerStartView.delegate = self
        footerStart = footerStartView
        
        self.view.addSubview(footerStartView)
        
        footerControl?.layer.mask = ViewPathDrawing.draw.createFooterControlShapeLayer(firstView: footerControl!, secondView: footerStart!)
        footerControl?.clipsToBounds = true
        
        footerStart?.layer.mask = ViewPathDrawing.draw.createFooterStartShapeLayer(firstView: footerStart!)
        footerStart?.clipsToBounds = true
    }
    
    // MARK: - Header location button functions
    
    func startTracker() {
        locationManager.startUpdatingLocation()
    }
    
    func stopTracker() {
        locationManager.stopUpdatingLocation()
    }
    
    func didPressedLogoutButton() {
        print("didPressedLogoutButton")
        UserDefaults.standard.set(false, forKey: "isLogin")
        onLogin?()
    }
    
    func didPressedShowLastRouteButton() {
        print("didPressedShowLastRouteButton")
        if Tracker.shared.isStarted {
            showAlert()
        } else if !Tracker.shared.isStarted {
            //gMapView?.showRouteTestsPath()
            showLastRoute()
        }
    }
    
    func didPressedStartTrackerButton() {
        print("didPressedStartTrackerButton")
        if Tracker.shared.isStarted {
            setNameForRoute()
            gMapView?.clear()
            startTracker()
            print("Start tracker")
        } else if !Tracker.shared.isStarted {
            stopTracker()
            clearPathAndNameForRoute()
            print("Stop tracker")
        }
    }
    
    func didPressedZoomButton() {
        print("didPressedZoomButton")
        gMapView?.zoomNewValue = 17
    }
    
    //MARK: - Realm function for show and save Track

    func showLastRoute() {
        let path: GMSMutablePath = realmAdapter.getLastRoute()
        gMapView?.showLastRoute(path)
    }
    
    func saveRouteIntoRealm(_ newPosition: CLLocationCoordinate2D) {
        let date = Date.init(timeIntervalSinceNow: 0)
        let time = dateFormatter.convertDateToInt(date.description)
        realmAdapter.saveRoutePathDotsPosition(time, routeName, newPosition)
        routePath.add(newPosition)
        gMapView?.drawRoute(newPosition, routePath)
    }
    
    //MARK: - State configure function for show and save Track
    
    func setNameForRoute() {
        let date: Date = Date(timeIntervalSinceNow: 0)
        print(date)
        let dateFormat = self.dateFormatter.convertDateToName(date.description)
        print(dateFormat)
        routeName = dateFormat
    }
    
    func clearPathAndNameForRoute() {
        routeName = ""
        routePath.removeAllCoordinates()
    }
    
    //MARK: - Configure and subscribe to location manager coordinate updates

    func configureLocationManager() {
        locationManager
            .location
            .asObservable()
            .bind { [weak self] location in
                guard let lastLocation = location else { return }
                print("Now position: \(lastLocation.coordinate.latitude) \(lastLocation.coordinate.longitude)")
                let position: CLLocationCoordinate2D = lastLocation.coordinate
                if Tracker.shared.isStarted {
                    self?.saveRouteIntoRealm(position)
                }
        }.disposed(by: bag)
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
        routePath.removeAllCoordinates()
        footerStart?.setInStartStateTrackerButton()
        showLastRoute()
    }

}

extension GoogleMapViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func didPressedAddAvatarCameraButton() {
        print("didPressedAddAvatarButton")
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true)
    }
    
    func didPressedAddAvatarAlbumButton() {
        print("didPressedAddAvatarButton")
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true)
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("didFinishPickingMediaWithInfo")
        guard let image = info[.editedImage] as? UIImage else { return }
        avatarManager.saveAvatarToDisk(image)
        dismiss(animated: true, completion: nil)
    }
    
}
