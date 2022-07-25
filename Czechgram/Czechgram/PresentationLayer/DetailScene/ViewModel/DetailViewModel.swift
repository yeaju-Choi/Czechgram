//
//  DetailViewModel.swift
//  Czechgram
//
//  Created by juntaek.oh on 2022/07/25.
//

import Foundation

final class DetailViewModel {

    let mediaImageEntity: MediaImageEntity
    private var detailUsecase: ViewDetailPostUsecase = ViewDefaultDetailPostUsecase()
    
    private var postMedias: [MediaImageEntity]? {
        didSet {
            
        }
    }

    init(cellEntity: MediaImageEntity) {
        self.mediaImageEntity = cellEntity
    }

    func enquireImages(with completion: @escaping (MediaEntity) -> Void) {
        detailUsecase.executePostData(with: mediaImageEntity.id) { [weak self] mediaImageEntities in
            self?.postMedias = mediaImageEntities
        }
    }
}
