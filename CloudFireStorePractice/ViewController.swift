//
//  ViewController.swift
//  CloudFireStorePractice
//
//  Created by 坂本龍哉 on 2021/07/06.
//

import UIKit

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MovieElement {
    var title: String
    var crew: String
    var releaseDay: Date
    var score: Int
}

class ViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var crewTextField: UITextField!
    @IBOutlet weak var scoreTextField: UITextField!
    @IBOutlet weak var displayLabel: UILabel!
    
    var data = [[String: Any]]()
    
    var db: Firestore!
    var quoteListener: ListenerRegistration!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        quoteListener = db.collection("movie").addSnapshotListener { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                let myData = querySnapshot!.documents[0]
                let title = myData["title"] as? String ?? ""
                let crew = myData["crew"] as? String ?? ""
                let release = myData["releaseDay"] as? Date ?? Date()
                let score = myData["score"] as? Int ?? 0
                self.displayLabel.text = "\(title)\n\(crew)\n\(release)\n\(score)"
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        quoteListener.remove()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        let title = titleTextField.text ?? ""
        let crew = crewTextField.text ?? ""
        let score = Int(scoreTextField.text!) ?? 0
        let dataToSave: [String: Any] = ["title": title, "crew": crew, "releaseDay": Timestamp(date: Date()), "score": score]
        db.collection("movie").document().setData(dataToSave) { (error) in
            if let error = error {
                print(error)
            } else {
                print("saved")
            }
        }
    }
    
    
    @IBAction func displayButtonTapped(_ sender: Any) {
            data = []
            db.collection("movie").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    DispatchQueue.global().async {
                        for document in querySnapshot!.documents {
                            self.data.append(document.data())
                        }
                        DispatchQueue.main.async {
                            let title = self.data[0]["title"] as? String ?? ""
                            let crew = self.data[0]["crew"] as? String ?? ""
                            let release = self.data[0]["releaseDay"] as? Date ?? Date()
                            let score = self.data[0]["score"] as? Int ?? 0
                            self.displayLabel.text = "\(title)\n\(crew)\n\(release)\n\(score)"
                        }
                    }
                }
            }

    }
    
}
