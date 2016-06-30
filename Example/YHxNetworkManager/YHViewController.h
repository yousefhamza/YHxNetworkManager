//
//  YHViewController.h
//  YHxNetworkManager
//
//  Created by Yousef Hamza on 06/30/2016.
//  Copyright (c) 2016 Yousef Hamza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHViewPresenter.h"

@interface YHViewController : UIViewController

@property (nonatomic, strong) YHViewPresenter *viewPresenter;

- (void)refresh;

@end
