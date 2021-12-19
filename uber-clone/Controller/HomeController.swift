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
    private let tableView = UITableView()
    private let locationInputViewHeight: CGFloat = 180
    
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
        configureTableView()
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LocationCell.self, forCellReuseIdentifier: "LocationCell")
        tableView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: self.view.frame.height - locationInputViewHeight)
    }
    
    func configureInputView() {
        view.addSubview(locationInputView)
        locationInputView.delegate = self
        locationInputView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.locationInputView.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveLinear) {
                self.tableView.frame.origin.y = self.locationInputViewHeight
            } completion: { _ in
                
            }

        }

        locationInputView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(180)
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
            UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.curveLinear) {
                self.tableView.frame.origin.y = self.view.frame.height
            } completion: { _ in
                
            }
        } completion: { isCompleted in
            self.locationInputView.removeFromSuperview()
            UIView.animate(withDuration: 0.5) {
                self.locationInputActivationView.alpha = 1
            }
        }

    }
    
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}
