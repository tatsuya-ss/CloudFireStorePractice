//
//  Firebase.swift
//  CloudFireStorePractice
//
//  Created by 坂本龍哉 on 2021/07/09.
//

import Foundation

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift


final class Firebase {
    var db = Firestore.firestore()
    var movieReviews = [ReviewInfomation]()
    
    func fetch(completion: @escaping (Result<[ReviewInfomation], Error>) -> Void) {
        db.collection("movieData").getDocuments() { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                self.movieReviews.removeAll()
                for document in querySnapshot!.documents {
                    self.movieReviews.append(ReviewInfomation(data: document))
                }
                completion(.success(self.movieReviews))
            }
        }
    }
    
    func fetchOver90Score(completion: @escaping (Result<[ReviewInfomation], Error>) -> Void) {
        db.collection("movieData").whereField("score", isGreaterThanOrEqualTo: 90).getDocuments { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.movieReviews.removeAll()
                for document in querySnapshot!.documents {
                    self.movieReviews.append(ReviewInfomation(data: document))
                }
                completion(.success(self.movieReviews))
            }
        }
    }
    
    func ascending(completion: @escaping (Result<[ReviewInfomation], Error>) -> Void) {
        db.collection("movieData").order(by: "score", descending: false).getDocuments() { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.movieReviews.removeAll()
                for document in querySnapshot!.documents {
                    self.movieReviews.append(ReviewInfomation(data: document))
                }
                completion(.success(self.movieReviews))
            }
        }
    }
    
}

private extension ReviewInfomation {
    init(data: QueryDocumentSnapshot) {
        self = ReviewInfomation(title: data.data()["title"] as? String ?? "",
                                score: data.data()["score"] as? Int ?? 0,
                                saveDate: data.data()["date"] as? Date ?? Date())
    }
}
