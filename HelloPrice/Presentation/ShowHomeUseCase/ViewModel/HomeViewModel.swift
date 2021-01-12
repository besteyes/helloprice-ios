//
//  HomeViewModel.swift
//  HelloPrice
//
//  Created by devming on 2020/11/13.
//  Copyright © 2020 besteyes. All rights reserved.
//

import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    struct Input: ViewModelInput {
        let fetchCategories: PublishRelay<Void>
        let fetchCategoryItems: PublishRelay<Int>
    }
    
    struct Output: ViewModelOutput {
        let categories = PublishRelay<[SectionOfDomainObject<HomeCategory>]>()
        let products = PublishRelay<[SectionOfDomainObject<Product>]>()
        let productsCount = PublishRelay<Int>()
    }
    
    var useCase: HomeUseCase
    
    init(useCase: HomeUseCase) {
        self.useCase = useCase
        
        super.init()
    }
    
    func transform(input: Input) -> Output {
    
        let output = Output()
        
        input.fetchCategories
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .withUnretained(self)
            .flatMap { `self`, _ in self.useCase.fetchCategories() }
            .map { [SectionOfDomainObject<HomeCategory>(items: $0)] }
            .bind(to: output.categories)
            .disposed(by: 👜)
        
        input.fetchCategoryItems
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .withUnretained(self)
            .flatMap { `self`, item in self.useCase.fetchCategoryItems(categoryId: item)}
            .map { [SectionOfDomainObject<Product>(items: $0)] }
            .bind(to: output.products)
            .disposed(by: 👜)
            
        return output
    }
    
//    func loadInit(completionHandler: () -> Void) {
//        
//        
//        inputs?.fetchCategories.accept(())
//        inputs?.fetchCategoryItems.accept(0)
//    }
}
