//
//  MovieDetailViewController.swift
//  MovieRate
//
//  Created by Joseph on 4/23/19.
//  Copyright © 2019 Joseph Parks. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingStackView: UIStackView!
    
    var movie = Movies()
    var viewController = ViewController()
    
    var finalMovie = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("***\(finalMovie)")
        movie.getMovies(movieSearched: finalMovie) {
            //if self.movie.movieArray[0].title == "" {
                print("VIEW CONTROLLER: \(self.movie.movieArray)")
                self.titleLabel.text = self.movie.movieArray[0].title
                self.summaryTextView.text = self.movie.movieArray[0].plot
                //posterImageView.image = movie.movieArray[0].poster
            //} else {
                self.titleLabel.text = "Whoops! No movie was found with this title."
                self.summaryTextView.text = "Please return to the home screen and try again."
           // }
            
        }
        
        
        
    }
    


}
