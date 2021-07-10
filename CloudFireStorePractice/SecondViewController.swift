//
//  SecondViewController.swift
//  CloudFireStorePractice
//
//  Created by 坂本龍哉 on 2021/07/07.
//

import UIKit

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

final class SecondViewController: UIViewController {
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var scoreLabel: UITextField!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var allFetchLabel: UILabel!
    
    var db: Firestore!
    var docRef: DocumentReference!
    var quoteListener: ListenerRegistration!
    let review = Review()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        quoteListener = docRef.addSnapshotListener { documentSnapshot, error in
//            guard let documentSnapshot = documentSnapshot, documentSnapshot.exists,
//                  let movieData = documentSnapshot.data() else { return }
//            self.review.fetch(movieData: movieData)
//            self.displayLabel.text = self.review.toStringForOneReview()
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        quoteListener.remove()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        db = Firestore.firestore()
//        docRef = db.collection("movieData").document("movie")
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
//        guard let titleText = titleLabel.text, !titleText.isEmpty else { return }
//        guard let scoreText = scoreLabel.text, !scoreText.isEmpty else { return }
//        let dataToSave: [String: Any] = ["title": titleText,
//                                         "score": Int(scoreText) ?? 0,
//                                         "date": Timestamp(date: Date())]
//        docRef.setData(dataToSave) { (error) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                print("Data has been saved!")
//            }
//        }
    }
    @IBAction func addButtonTapped(_ sender: Any) {
//        guard let titleText = titleLabel.text, !titleText.isEmpty else { return }
//        guard let scoreText = scoreLabel.text, !scoreText.isEmpty else { return }
//        let dataToSave: [String: Any] = ["title": titleText,
//                                         "score": Int(scoreText) ?? 0,
//                                         "date": Timestamp(date: Date())]
//
//        var ref: DocumentReference? = nil
//        ref = db.collection("movieData").addDocument(data: dataToSave) { error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                print("Data has been saved! \(ref!.documentID)")
//            }
//        }
    }
    
    
    @IBAction func updateButtonTapped(_ sender: Any) {
//        guard let scoreText = scoreLabel.text, !scoreText.isEmpty else { return }
//
//        docRef.updateData(["score": scoreText]) { error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                print("Data has been updated!")
//            }
//        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
//        docRef.delete() { error in
//            if let error = error {
        //                print(error.localizedDescription)
        //            } else {
        //                print("removed!!!!!")
        //            }
        //        }
    }
    
    @IBAction func displayButtonTapped(_ sender: Any) {
        review.fetch { result in
            switch result {
            case .success:
                self.allFetchLabel.text = self.review.toString()
            case let .failure(error):
                print(error)
            }
        }
        
    }
    
    @IBAction func over90ButtonTapped(_ sender: Any) {
        review.fetchOver90Score { result in
            switch result {
            case .success:
                self.allFetchLabel.text = self.review.toString()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    @IBAction func ascendingButtonTapped(_ sender: Any) {
        review.sort(isDesecding: false) { result in
            switch result {
            case .success:
                self.allFetchLabel.text = self.review.toString()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    @IBAction func descendingButton(_ sender: Any) {
        review.sort(isDesecding: true) { result in
            switch result {
            case .success:
                self.allFetchLabel.text = self.review.toString()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    
}
