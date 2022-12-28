//
//  FeedViewController.swift
//  PhotoSharingApp
//
//  Created by Harun Demirkaya on 26.12.2022.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func fetchData(){
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("Post").order(by: "date", descending: true)
            .addSnapshotListener { snapshot, err in
            if err != nil{
                self.alertMessage(title: "Error", description: err!.localizedDescription)
            } else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.posts.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents{
                        if let postAuthor = document.get("email") as? String, let postImage = document.get("img") as? String, let postDescription = document.get("description") as? String{
                            let post = Post(postAuthor: postAuthor, postImage: postImage, postDescription: postDescription)
                            self.posts.append(post)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.lblPostAuthor.text = self.posts[indexPath.row].postAuthor
        cell.lblPostDescription.text = self.posts[indexPath.row].postDescription
        cell.imgViewPostImage.sd_setImage(with: URL(string: self.posts[indexPath.row].postImage))
        return cell
    }
    
    func alertMessage(title: String, description: String){
        let alertMessage = UIAlertController(title: title, message: description, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Okey", style: UIAlertAction.Style.default)
        alertMessage.addAction(okButton)
        self.present(alertMessage, animated: true)
    }

}
