//
//  UseCase.swift
//  CloudFireStorePractice
//
//  Created by 坂本龍哉 on 2021/07/09.
//

import Foundation

final class UseCase {
    var firebase = Firebase()
    
    func listener() -> ReviewInfomation? {
        firebase.movieReview
    }
    
    func removeListener() {
        firebase.removeListener()
    }
    
    func fetchOneReview() -> ReviewInfomation? {
        firebase.fetchOneReview()
    }
    
    func save(title: String, score: Int) {
        firebase.save(title: title, score: score)
    }
    
    func updata(score: Int) {
        firebase.update(score: score)
    }
    
    func delete() {
        firebase.delete()
    }
    
    func fetch(completion: @escaping (Result<[ReviewInfomation], Error>) -> Void) {
        firebase.fetch { result in
            switch result {
            case let .success(reviewInfomation):
                completion(.success(reviewInfomation))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchOver90Score(completion: @escaping (Result<[ReviewInfomation], Error>) -> Void) {
        firebase.fetchOver90Score { result in
            switch result {
            case let .success(reviewInfomation):
                completion(.success(reviewInfomation))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func sort(isDesecding: Bool, completion: @escaping (Result<[ReviewInfomation], Error>) -> Void) {
        firebase.sort(isDesecding: isDesecding) { result in
            switch result {
            case let .success(reviewInfomations):
                completion(.success(reviewInfomations))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func add(title: String, score: Int) {
        firebase.add(title: title, score: score)
    }
    
}
