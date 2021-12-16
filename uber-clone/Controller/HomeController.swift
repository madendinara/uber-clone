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
    private lazy var mapView = MKMapView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserLoggedIn()
//        signOut()
    }
    
    // MARK: - Methods
    func configureView() {
        [mapView].forEach { view.addSubview($0) }
        makeConstaints()
    }
    
    func makeConstaints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
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
