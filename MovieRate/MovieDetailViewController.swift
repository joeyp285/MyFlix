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
    @IBOutlet weak var directorNameLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    
    var movie: Movie!
    var movies: Movies!
    
    var finalMovie = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("***\(finalMovie)")
        finalMovie = finalMovie.replacingOccurrences(of: " ", with: "_")
        movies = Movies()
        movies.getMovies(movieSearched: finalMovie) {
            
            print("***VIEW CONTROLLER TITLE: \(self.movies.selectedMovie)")
            if self.movies.selectedMovie.title != "" {
                print("VIEW CONTROLLER: \(self.movies.selectedMovie)")
                self.titleLabel.text = self.movies.selectedMovie.title
                self.summaryTextView.text = self.movies.selectedMovie.plot
                self.directorNameLabel.text = self.movies.selectedMovie.director
                self.runTimeLabel.text = self.movies.selectedMovie.runtime
                guard let imageURL = URL(string: self.movies.selectedMovie.poster)
                    else { return }
                do {
                    let data = try Data(contentsOf: imageURL)
                    self.posterImageView.image = UIImage(data: data)
                } catch {
                    print("cant get the data frmo URL \(self.movies.selectedMovie.poster)")
                }
                self.movie = self.movies.selectedMovie
            } else {
                self.titleLabel.text = "Whoops! No movie was found with this title."
                self.summaryTextView.text = "Please return to the home screen and try again."
            }
        }
        
    }
    
    
//    func leaveViewController() {
//        let isPresentingInAddMode = presentingViewController is UINavigationController
//        if isPresentingInAddMode {
//            dismiss(animated: true, completion: nil)
//        } else {
//            navigationController?.popViewController(animated: true)
//        }
//    }
    
//    @IBAction func backButtonPressed(_ sender: Any) {
//        performSegue(withIdentifier: "ReturnToViewController", sender: self)
//    }
    
    @IBAction func favoritesButtonPressed(_ sender: UIButton) {
        movie.saveData { success in
            if success {
//                self.leaveViewController()
                self.performSegue(withIdentifier: "showFavorites", sender: self)
            } else {
                print("*** ERROR: Couldn't leave this view controller because data wasn't saved.")
            }
        }
        
    }
    
    
}


