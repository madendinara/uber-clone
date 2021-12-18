//
//  HomeController.swift
//  uber-clone
//
//  Created by Динара Зиманова on 12/15/21.
//

import UIKit
import Firebase
import MapKit

class HomeController: UIViewController {
    
    // MARK: - Properties
    private let locationInputView = LocationInputView()
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let locationInputActivationView = LocationInputActivationView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserLoggedIn()
        configureView()
//        signOut()
        enableLocationServices()
    }
    
    // MARK: - Methods
    func configureView() {
        locationInputActivationView.delegate = self
        configureMapView()
        view.addSubview(locationInputActivationView)
        locationInputView.alpha = 0
        makeConstaints()
        locationInputActivationView.alpha = 0
        
        UIView.animate(withDuration: 2) {
            self.locationInputActivationView.alpha = 1
        }
    }
    
    func configureInputView() {
        view.addSubview(locationInputView)
        locationInputView.delegate = self
        locationInputView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.locationInputView.alpha = 1
        } completion: { isCompleted in
            print("Success")
        }

        locationInputView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    func configureMapView() {
        view.addSubview(mapView)
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        let region = MKCoordinateRegion(center: mapView.centerCoordinate, span: MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta * 1.05, longitudeDelta: mapView.region.span.longitudeDelta * 1.05))
        self.mapView.setRegion(region, animated: true)
        
    }
    
    func makeConstaints() {
        mapView.frame = view.frame
        locationInputActivationView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            make.size.equalTo(CGSize(width: view.frame.width * 0.75, height: 50))
        }
    }
    
    // MARK: - Providers
    func checkIfUserLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                if #available(iOS 13.0, *) {
                    nav.isModalInPresentation = true
                }
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
        else {
            configureView()
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("Error of signing out is \(error.localizedDescription)")
        }
    }
}

// MARK: - Location Services
extension HomeController: CLLocationManagerDelegate {
    func enableLocationServices () {
        locationManager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .restricted, .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
}

// MARK: - LocationInputActivationViewDelegate
extension HomeController: LocationInputActivationViewDelegate {
    
    func presentLocation() {
        locationInputActivationView.alpha = 0
        configureInputView()
    }
}

extension HomeController: LocationInputViewDelegate {
    
    func dismissView() {
        UIView.animate(withDuration: 0.5) {
            self.locationInputView.alpha = 0
        } completion: { isCompleted in
            UIView.animate(withDuration: 0.5) {
                self.locationInputActivationView.alpha = 1
            }
        }

    }
    
}
