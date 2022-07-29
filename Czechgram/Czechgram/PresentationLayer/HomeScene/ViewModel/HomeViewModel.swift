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

    let myPageUsecase: ViewMainPageUsecase = ViewDefaultMainPageUsecase()
    
    struct Input {
        let viewDidLoadEvent: Observable<Void>
    }
    
    struct Output {
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
    
    func enquireNextImages() {
        myPageUsecase.executeNextMediaImage()
    }
}
    



