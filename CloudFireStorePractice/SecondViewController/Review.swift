//
//  Review.swift
//  CloudFireStorePractice
//
//  Created by 坂本龍哉 on 2021/07/09.
//

import Foundation

final class Review {
    
    var movieReviews = [ReviewInfomation]()
    var movieReview: ReviewInfomation?
    let useCase = UseCase()
    
    func listener() {
        guard let movieReview = useCase.listener() else { return }
        self.movieReview = movieReview
    }
    
    func removeListener() {
        useCase.removeListener()
    }
    
    func save(title: String, score: Int) {
        useCase.save(title: title, score: score)
    }
    
    func update(score: Int) {
        useCase.updata(score: score)
    }
    
    func delete() {
        useCase.delete()
    }
    
    func fetchOneReview() {
        movieReview = useCase.fetchOneReview()
    }
    
    func fetch(completion: @escaping (Result<[ReviewInfomation], Error>) -> Void) {
        useCase.fetch { result in
            switch result {
            case let .success(reviewInfomation):
                self.movieReviews = reviewInfomation
                completion(.success(reviewInfomation))
            case let .failure(error):
                print(error)
            }
        }
        
    }
    
    func fetchOver90Score(completion: @escaping (Result<[ReviewInfomation], Error>) -> Void) {
        useCase.fetchOver90Score { result in
            switch result {
            case let .success(reviewInfomation):
                self.movieReviews = reviewInfomation
                completion(.success(reviewInfomation))
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func sort(isDesecding: Bool, completion: @escaping (Result<[ReviewInfomation], Error>) -> Void) {
        useCase.sort(isDesecding: isDesecding) { result in
            switch result {
            case let .success(reviewInfomations):
                self.movieReviews = reviewInfomations
                completion(.success(reviewInfomations))
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func add(title: String, score: Int) {
        useCase.add(title: title, score: score)
    }
    
    func fetch(movieData: [String: Any]) {
        let title = movieData["title"] as? String ?? ""
        let score = movieData["score"] as? Int ?? 0
        let date = movieData["date"] as? Date ?? Date()
        movieReview = ReviewInfomation(title: title, score: score, saveDate: date)
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
