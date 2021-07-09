//
//  Review.swift
//  CloudFireStorePractice
//
//  Created by 坂本龍哉 on 2021/07/09.
//

import Foundation

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

final class Review {
    
    var movieReviews = [ReviewInfomation]()
    var movieReview: ReviewInfomation?
    
    func fetch(documents: [QueryDocumentSnapshot]) {
        movieReviews = []
        for document in documents {
            movieReviews.append(ReviewInfomation(data: document))
        }
    }
    
    func fetch(movieData: [String: Any]) {
        let title = movieData["title"] as? String ?? ""
        let score = movieData["score"] as? Int ?? 0
        let date = movieData["date"] as? Date ?? Date()
        movieReview = ReviewInfomation(title: title, score: score, saveDate: date)
    }
    
    func save() {
        
    }
    
    func toString() -> String {
        var strings = String()
        for review in movieReviews {
            strings += "\(review.title) => \(String(review.score))\n"
        }
        return strings
    }
    
    func toStringForOneReview() -> String {
        guard let movieReview = movieReview else { return "" }
        return "\(movieReview.title)\n\(movieReview.score)点\n\(movieReview.saveDate)"
    }
    
}

private extension ReviewInfomation {
    init(data: QueryDocumentSnapshot) {
        self = ReviewInfomation(title: data.data()["title"] as? String ?? "",
                                score: data.data()["score"] as? Int ?? 0,
                                saveDate: data.data()["date"] as? Date ?? Date())
    }
}
