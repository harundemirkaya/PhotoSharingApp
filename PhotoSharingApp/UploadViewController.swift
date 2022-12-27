//
//  UploadViewController.swift
//  PhotoSharingApp
//
//  Created by Harun Demirkaya on 26.12.2022.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgViewPhoto: UIImageView!
    @IBOutlet weak var txtFieldDescription: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        imgViewPhoto.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selecImage))
        imgViewPhoto.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func selecImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imgViewPhoto.image = info[.editedImage] as? UIImage
        picker.dismiss(animated: true)
    }

    @IBAction func btnUpload(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        let id = UUID().uuidString
        
        if let data = imgViewPhoto.image?.jpegData(compressionQuality: 0.5){
            let imageReference = mediaFolder.child("\(id).jpg")
            imageReference.putData(data) { StorageMetadata, err in
                if err != nil{
                    self.alertMessage(title: "Error", description: err!.localizedDescription)
                } else{
                    imageReference.downloadURL { url, error in
                        if error == nil{
                            let imageUrl = url?.absoluteString
                            if let imageUrl = imageUrl{
                                let fireStoreDB = Firestore.firestore()
                                let fireStorePost = ["img": imageUrl, "description": self.txtFieldDescription.text!, "email": Auth.auth().currentUser!.email!,
                                                     "date": FieldValue.serverTimestamp()] as [String:Any]
                                fireStoreDB.collection("Post").addDocument(data: fireStorePost) { err in
                                    if err != nil{
                                        self.alertMessage(title: "Error", description: err!.localizedDescription)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func alertMessage(title: String, description: String){
        let alert = UIAlertController(title: title, message: description, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Okey", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
