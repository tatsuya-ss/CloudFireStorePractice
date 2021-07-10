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
    
    var docRef = Firestore.firestore().collection("movieData").document("movie")
    var movieReview: ReviewInfomation?

    var quoteListener: ListenerRegistration!
    
    init() {
        listener()
    }
    
    // MARK: - movieData -> movie
    func listener() {
        quoteListener = docRef.addSnapshotListener { documentSnapshot, error in
            guard let documentSnapshot = documentSnapshot, documentSnapshot.exists,
                  let movieData = documentSnapshot.data() else { return }
            print(#function, movieData)
            self.movieReview = ReviewInfomation(title: movieData["title"] as? String ?? "",
                                                score: movieData["score"] as? Int ?? 0,
                                                saveDate: movieData["date"] as? Date ?? Date())
        }
    }
    
    func removeListener() {
        quoteListener.remove()
    }
    
    func save(title: String, score: Int) {
        let dataToSave: [String: Any] = ["title": title,
                                         "score": score,
                                         "date": Timestamp(date: Date())]

        docRef.setData(dataToSave) { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Data has been saved!")
            }
        }
    }
    
    func update(score: Int) {
        docRef.updateData(["score": score]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Data has been updated!")
            }
        }
    }
    
    func delete() {
        docRef.delete() { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("removed!!!!!")
            }
        }
    }
    
    // MARK: - movieData
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
    
    func sort(isDesecding: Bool, completion: @escaping (Result<[ReviewInfomation], Error>) -> Void) {
        db.collection("movieData").order(by: "score", descending: isDesecding).getDocuments() { querySnapshot, error in
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
    
    func add(title: String, score: Int) {
        let dataToSave: [String: Any] = ["title": title,
                                         "score": score,
                                         "date": Timestamp(date: Date())]

        var ref: DocumentReference? = nil
        ref = db.collection("movieData").addDocument(data: dataToSave) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Data has been saved! \(ref!.documentID)")
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
