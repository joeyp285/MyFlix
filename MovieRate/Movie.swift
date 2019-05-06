//
//  Movie.swift
//  MovieRate
//
//  Created by Joseph on 4/23/19.
//  Copyright © 2019 Joseph Parks. All rights reserved.
//

import Foundation
//import Alamofire
//import SwiftyJSON
import Firebase


class Movie {
    
    var title: String
    var poster: String
    var runtime: String
    var plot: String
    var director: String
    var postingUserID: String
    var documentID: String
    
    var dictionary: [String: Any] {
        return ["title": title, "poster": poster, "runtime": runtime, "plot": plot,  "director": director, "postingUserID": postingUserID]
    }
    
    init(title: String, poster: String, runtime: String, plot: String, director: String, postingUserID: String, documentID: String) {
        self.title = title
        self.poster = poster
        self.runtime = runtime
        self.plot = plot
        self.director = director
        self.postingUserID = postingUserID
        self.documentID = documentID
    }
    
    convenience init() {
        self.init(title: "", poster: "", runtime: "", plot: "", director: "", postingUserID: "", documentID: "")
    }
    
    convenience init(dictionary: [String: Any]) {
        let title = dictionary["title"] as! String? ?? ""
        let poster = dictionary["poster"] as! String? ?? ""
        let runtime = dictionary["rutime"] as! String? ?? ""
        let plot = dictionary["plot"] as! String? ?? ""
        let director = dictionary["director"] as! String? ?? ""
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        let documentID = dictionary["documentID"] as! String? ?? ""
        self.init(title: title, poster: poster, runtime: runtime, plot: plot, director: director, postingUserID: postingUserID, documentID: "")
    }
    

//    var movieArray: [MovieData] = []
//    var movieArray: [Movie] = []
//    
//    
//    func getMovies(movieSearched: String, completed: @escaping () -> () ) {
//        let apiURL = "http://www.omdbapi.com?apikey=8a31907c&t=\(movieSearched)"
////        let apiURL = string + "&t=" + movieSearched
//        Alamofire.request(apiURL).responseJSON { response in
//            //print("@@@**@*@*@*@*@*@*@*@*@*@*@*@\(apiURL)")
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                //not sure if I can loop through this like our previous URLs because it seems like you can only get movie details when searching
//                //self.totalMovies = json["count"].intValue
//                //self.apiURL = json["next"].stringValue
//                //let numberOfMovies = json["Title"].count
//                //for index in 0..<numberOfMovies {
//                let title = json["Title"].stringValue
//                let poster = json["Poster"].stringValue
//                //poster value is a URL, not sure if I can display image with that
//                let runtime = json["Runtime"].stringValue
//                let plot = json["Plot"].stringValue
//                let director = json["Director"].stringValue
//            //print("******\(title), \(poster), \(runtime), \(plot),\(director)")
//                self.movieArray.append(Movie(title: title, poster: poster, runtime: runtime, plot: plot, director: director))
//            //}
//                print("MOVIE CLASS: \(self.movieArray)")
//            case .failure(let error):
//                print("ERROR: \(error.localizedDescription) failed to get data from url")
//            }
//            completed()
//        }
//    }
    

    

    
    func saveData(completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        // Grab the userID
        guard let postingUserID = (Auth.auth().currentUser?.uid) else {
            print("*** ERROR: Could not save data because we don't have a valid postingUserID")
            return completed(false)
        }
        self.postingUserID = postingUserID
        // Create the dictionary representing the data we want to save
        let dataToSave = self.dictionary
        // if we HAVE saved a record, we'll have a documentID
        if self.documentID != "" {
            let ref = db.collection("movies").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("*** ERROR: updating document \(self.documentID) \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("^^^ Document updated with ref ID \(ref.documentID)")
                    completed(true)
                }
            }
        } else {
            var ref: DocumentReference? = nil // Let firestore create the new documentID
            ref = db.collection("movies").addDocument(data: dataToSave) { error in
                if let error = error {
                    print("*** ERROR: creating new document \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("^^^ new document created with ref ID \(ref?.documentID ?? "unknown")")
                    self.documentID = ref!.documentID
                    completed(true)
                }
            }
        }
    }
    
}

