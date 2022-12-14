//
//  MoviesTableViewController.swift
//  MoviesApp
import UIKit

class MoviesTableViewController: UITableViewController {

    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLocalJson()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           let vc = segue.destination as! MovieViewController
           guard let row = tableView.indexPathForSelectedRow?.row else {return}
           let movie = movies[row]
           vc.movie = movie
       }
       
       func loadLocalJson(){
           guard let jsonURL = Bundle.main.url(forResource: "movies", withExtension: "json"), let data = try? Data(contentsOf: jsonURL) else {return}
           
           do{
               movies = try JSONDecoder().decode([Movie].self, from: data)
               
           } catch {
               print(error.localizedDescription)
           }
       }
    
    // MARK: - Table view data source

     override func numberOfSections(in tableView: UITableView) -> Int {
           // #warning Incomplete implementation, return the number of sections
           return 1
       }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
           return movies.count
       }

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
           let movie = movies[indexPath.row]
           cell.prepare(with: movie)
           return cell
       }

    