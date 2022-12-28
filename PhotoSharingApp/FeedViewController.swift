//
//  FeedViewController.swift
//  PhotoSharingApp
//
//  Created by Harun Demirkaya on 26.12.2022.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.lblPostAuthor.text = "Harun"
        cell.lblPostDescription.text = "Sample Description"
        cell.imgViewPostImage.image = UIImage(named: "select")
        return cell
    }

}
