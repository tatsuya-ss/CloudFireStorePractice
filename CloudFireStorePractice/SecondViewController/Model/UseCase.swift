//
//  UseCase.swift
//  CloudFireStorePractice
//
//  Created by 坂本龍哉 on 2021/07/09.
//

import Foundation


final class UseCase {
    var firebase = Firebase()
    
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
    
    
}
