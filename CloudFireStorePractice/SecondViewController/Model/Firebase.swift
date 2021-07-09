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
    
    
    func fetch(completion: @escaping (Result<[ReviewInfomation], Error>) -> Void) {
        var movieReviews = [ReviewInfomation]()

        db.collection("movieData").getDocuments() { querySnapshot, error in
            if let error = error {
                completion(.failure(error))
            } else {
                    for document in querySnapshot!.documents {
                        movieReviews.append(ReviewInfomation(data: document))
                    }
                completion(.success(movieReviews))
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
