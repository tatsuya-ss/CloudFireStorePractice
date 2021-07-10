//
//  SecondViewController.swift
//  CloudFireStorePractice
//
//  Created by 坂本龍哉 on 2021/07/07.
//

import UIKit

final class SecondViewController: UIViewController {
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var scoreLabel: UITextField!
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var allFetchLabel: UILabel!
    
    let review = Review()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        review.listener()
        self.displayLabel.text = review.toStringForOneReview()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        review.removeListener()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        db = Firestore.firestore()
//        docRef = db.collection("movieData").document("movie")
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let titleText = titleLabel.text, !titleText.isEmpty else { return }
        guard let scoreText = scoreLabel.text, !scoreText.isEmpty else { return }
        let score = Int(scoreText) ?? 0
        review.save(title: titleText, score: score)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let titleText = titleLabel.text, !titleText.isEmpty else { return }
        guard let scoreText = scoreLabel.text, !scoreText.isEmpty else { return }
        let score = Int(scoreText) ?? 0
        review.add(title: titleText, score: score)
    }
    
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        guard let scoreText = scoreLabel.text, !scoreText.isEmpty else { return }
        let score = Int(scoreText) ?? 0
        review.update(score: score)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        review.delete()
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
