//
//  ViewController.swift
//  MovieRate
//
//  Created by Joseph on 4/23/19.
//  Copyright © 2019 Joseph Parks. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import GoogleSignIn

class ViewController: UIViewController {
    
    @IBOutlet weak var movieTextField: UITextField!

//
//    var movie: Movie!
    var chosenMovie = ""
    var authUI: FUIAuth!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        authUI = FUIAuth.defaultAuthUI()
        authUI.delegate = self
      
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signIn()
    }
    
//    func formatUserSearch() {
////        var userSearch: String?
////        userSearch = movieTextField.text
////        var newApiURL = apiURL + "&t=" + userSearch!
////        return newApiURL
//
//
//    }
    
    func signIn() {
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
        ]
        let currentUser = authUI.auth?.currentUser
        if authUI.auth?.currentUser == nil {
            self.authUI.providers = providers
            present(authUI.authViewController(), animated: true, completion: nil)
        }
//        } else {
////            tableView.isHidden = false
////            mov = SnackUser(user: currentUser!)
////            snackUser.saveIfNewUser()
//        }
    }
    
    @IBAction func movieTextFieldChanged(_ sender: UITextField) {
        let newMovie = sender.text!
        chosenMovie = newMovie.replacingOccurrences(of: " ", with: "_")
        print(chosenMovie)
    }
    
    
    @IBAction func signOutPressed(_ sender: Any) {
        do {
            try authUI.signOut()
            dismiss(animated: true, completion: nil)
            //try! Auth.auth().signOut()
            print("^^^ Successfully signed out!")
            //tableView.isHidden = true
            signIn()
        } catch {
            //tableView.isHidden = true
            print("*** ERROR: Couldn't sign out")
        }
    }
    

    
    
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        movieTextField.resignFirstResponder()
        movieTextField.text = ""
        performSegue(withIdentifier: "ShowMovieList", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let nav = segue?.destinationViewController as! UINavigationController
//        let svc = nav.topViewController as! SearchViewController
//        svc.toPassSearchKeyword = searchKeyword;
        if segue.identifier != "viewToFavorites" {
            let vc = segue.destination as! MovieDetailViewController
            vc.finalMovie = self.chosenMovie
        }
    }
    

    
}

extension ViewController: FUIAuthDelegate {
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        // handle user and error as necessary
        if let user = user {
            print("We signed in with user \(user.email)")
            }
        }
    }

