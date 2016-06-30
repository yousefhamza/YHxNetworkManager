//
//  YHViewPresenter.h
//  YHxNetworkManager
//
//  Created by Yousef Hamza on 6/30/16.
//  Copyright © 2016 Yousef Hamza. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YHViewController;

@interface YHViewPresenter : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) YHViewController *view;

- (void)loadMovies;

@end
