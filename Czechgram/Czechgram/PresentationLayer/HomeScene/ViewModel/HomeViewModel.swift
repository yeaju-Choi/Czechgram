//
//  HomeViewModel.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/20.
//

import Foundation
import RxSwift
import RxRelay

final class HomeViewModel {

//    var myPageData: Observable<UserPageEntity?> = Observable(nil)
    let myPageUsecase: ViewMainPageUsecase = ViewDefaultMainPageUsecase()
    
    struct Input {
        let viewDidLoadEvent: Observable<Void>
    }
    
    struct Output {
//        let myPageData = PublishRelay<UserPageEntity>()
        let isFetchAllData = PublishRelay<Bool>()
        let userPageEntity = PublishRelay<UserPageEntity>()
    }
    
    func transform(input: Input, disposeBag: DisposeBag) -> Output {
        let output = Output()
        
        input.viewDidLoadEvent
            .subscribe { [weak self] _ in
                self?.myPageUsecase.executeUserPage()
            }.disposed(by: disposeBag)
        
        self.myPageUsecase.userPageEntity
            .map { $0.mediaCount == $0.media.images.count }
            .bind(to: output.isFetchAllData)
            .disposed(by: disposeBag)
        
        self.myPageUsecase.userPageEntity
            .bind(to: output.userPageEntity)
            .disposed(by: disposeBag)
 
        
        return output
        
    }
}
   
        
//        myPageUsecase.executeUserPage { [weak self] userPage in
//            self?.enquireImages(with: userPage.media, completion: { [weak self] mediaImages in
//                let images = mediaImages.sorted { firstValue, secondValue in
//                    if let firstTime = firstValue.createdTime, let secondTime = secondValue.createdTime {
//                        return firstTime > secondTime
//                    } else {
//                        return firstValue.id > secondValue.id
//                    }
//                }
//                var completedUserPage = userPage
//                completedUserPage.media.images = images
//                self?.myPageData.updateValue(value: completedUserPage)
//            })
//        }
    



