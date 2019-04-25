//
//  ViewController.swift
//  MovieRate
//
//  Created by Joseph on 4/23/19.
//  Copyright © 2019 Joseph Parks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var chosenMovie = ""
    
    @IBOutlet weak var movieTextField: UITextField!

    
    var movie = Movies()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
//    func formatUserSearch() -> String {
//        var userSearch: String?
//        userSearch = movieTextField.text
//        var newApiURL = apiURL + "&t=" + userSearch!
//        return newApiURL
//
//    }
    
    @IBAction func movieTextFieldChanged(_ sender: UITextField) {
        chosenMovie = sender.text!
        print(chosenMovie)
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
        var vc = segue.destination as! MovieDetailViewController
        vc.finalMovie = self.chosenMovie
    }

}

