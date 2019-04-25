//
//  Movie.swift
//  MovieRate
//
//  Created by Joseph on 4/23/19.
//  Copyright © 2019 Joseph Parks. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Movies {
    
            var movieArray: [MovieData] = []
    
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
            //print("******\(title), \(poster), \(runtime), \(plot),\(director)")
                self.movieArray.append(MovieData(title: title, poster: poster, runtime: runtime, plot: plot, director: director))
            //}
                print("MOVIE CLASS: \(self.movieArray)")
            case .failure(let error):
                print("ERROR: \(error.localizedDescription) failed to get data from url")
            }
            completed()
        }
    }
}
