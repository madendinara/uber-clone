//
//  AuthService.swift
//  uber-clone
//
//  Created by Динара Зиманова on 12/15/21.
//

import Foundation
import Firebase
import GeoFire

struct Service {
    
    static func signUp(location: CLLocation, email: String, password: String, fullname: String, accountType: Int, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let uid = result?.user.uid else { return }
            let data: [String: Any] = ["email": email, "fullname": fullname, "accountType": accountType]
            
            if accountType == 1 {
                var geofire = GeoFire(firebaseRef: Database.database().reference().child("driver-locations"))
                geofire.setLocation(location, forKey: uid) { error in
                    Database.database().reference().child("users").child(uid).updateChildValues(data) { error, ref in }
                }
            }
                        
            Database.database().reference().child("users").child(uid).updateChildValues(data) { error, ref in
                
            }
        }
    }
    
    static func logIn(email: String, password: String, completion: @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func getUserData(completion: @escaping(User) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(currentUid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String:Any] else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
}
