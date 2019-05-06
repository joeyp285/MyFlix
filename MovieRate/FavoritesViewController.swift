//
//  FavoritesViewController.swift
//  MovieRate
//
//  Created by Joseph on 4/25/19.
//  Copyright © 2019 Joseph Parks. All rights reserved.
//

import UIKit
import Firebase

class FavoritesViewController: UIViewController {

    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
    var movies: Movies!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movies = Movies()
        
        
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        movies.loadData {
            self.favoritesTableView.reloadData()
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        getLocation()
//        navigationController?.setToolbarHidden(false, animated: false)
//        spots.loadData {
//            self.sortBasedOnSegmentPressed()
//            self.tableView.reloadData()
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMovieDetail" {
            let destination = segue.destination as! MovieDetailViewController
            let selectedIndexPath = favoritesTableView.indexPathForSelectedRow
            destination.finalMovie = movies.favoritesArray[selectedIndexPath!.row].title
            let currentMovie = movies.favoritesArray[selectedIndexPath!.row]
            movies.selectedMovie = currentMovie
        
            if let selectedPath = favoritesTableView.indexPathForSelectedRow {
                favoritesTableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }

    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        if favoritesTableView.isEditing {
            favoritesTableView.setEditing(false, animated: true)
            favoritesTableView.backgroundColor = UIColor(named: "Mercury")
            editBarButton.title = "Edit"
        } else {
            favoritesTableView.setEditing(true, animated: true)
            editBarButton.title = "Done"
            print(editBarButton.title)
           
            
        }
    }
    
    
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.favoritesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = movies.favoritesArray[indexPath.row].title
        cell.detailTextLabel?.text = movies.favoritesArray[indexPath.row].director
        return cell

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let db = Firestore.firestore()
        if editingStyle == .delete {
            let movieToDelete = movies.favoritesArray[indexPath.row]
            let ref = db.collection("movies").document(movieToDelete.documentID)
            print(movieToDelete.documentID)
            ref.delete { (error) in
                if let error = error {
                    print("ERROR DELETING MOVIE")
                } else {
                    print("GREAT SUCCESS")
                }
            }
            
            
            
            movies.favoritesArray.remove(at: indexPath.row)
            favoritesTableView.deleteRows(at: [indexPath], with: .fade)
            
            
        }
    }
    

    
    
}

