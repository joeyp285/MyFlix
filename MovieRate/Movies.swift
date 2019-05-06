//
//  Movies.swift
//  MovieRate
//
//  Created by Joseph on 4/26/19.
//  Copyright © 2019 Joseph Parks. All rights reserved.
//

import Foundation
import Firebase
import Alamofire
import SwiftyJSON

class Movies {
    
    var db: Firestore!
    
    var favoritesArray = [Movie]()
    var selectedMovie = Movie()
    
    init() {
        db = Firestore.firestore()
    }
    
    
    func loadData(completed: @escaping () -> ())  {
        db.collection("movies").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.favoritesArray = []
            // there are querySnapshot!.documents.count documents in teh spots snapshot
            for document in querySnapshot!.documents {
                let movie = Movie(dictionary: document.data())
                movie.documentID = document.documentID
                self.favoritesArray.append(movie)
            }
            completed()
        }
    }
    
    
    
    
    func getMovies(movieSearched: String, completed: @escaping () -> () ) {
        let apiURL = "http://www.omdbapi.com?apikey=8a31907c&t=\(movieSearched)"
        //        let apiURL = string + "&t=" + movieSearched
        Alamofire.request(apiURL).responseJSON { response in
            //print("@@@**@*@*@*@*@*@*@*@*@*@*@*@\(apiURL)")
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //not sure if I can loop through this like our previous URLs because it seems like you can only get movie details when searching
                //self.totalMovies = json["count"].intValue
                //self.apiURL = json["next"].stringValue
                //let numberOfMovies = json["Title"].count
                //for index in 0..<numberOfMovies {
                let title = json["Title"].stringValue
                let poster = json["Poster"].stringValue
                //poster value is a URL, not sure if I can display image with that
                let runtime = json["Runtime"].stringValue
                let plot = json["Plot"].stringValue
                let director = json["Director"].stringValue
                let movie = Movie()
                movie.title = title
                movie.poster = poster
                movie.runtime = runtime
                movie.plot = plot
                movie.director = director
                self.selectedMovie = movie
                print("@@@@@@@\(self.selectedMovie)")
//                self.movieArray.append(movie)
                //print("******\(title), \(poster), \(runtime), \(plot),\(director)")
//                self.movieArray.append(Movie(title: title, poster: poster, runtime: runtime, plot: plot, director: director))
                //}
                print("MOVIE CLASS: \(self.selectedMovie)")
            case .failure(let error):
                print("ERROR: \(error.localizedDescription) failed to get data from url")
            }
            completed()
        }
    }
}




