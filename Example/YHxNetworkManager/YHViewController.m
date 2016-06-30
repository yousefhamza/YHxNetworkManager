//
//  YHViewController.m
//  YHxNetworkManager
//
//  Created by Yousef Hamza on 06/30/2016.
//  Copyright (c) 2016 Yousef Hamza. All rights reserved.
//

#import "YHViewController.h"
#import "YHViewPresenter.h"
#import "YHxNetworkManager.h"
#import "YHMoviesTableViewCell.h"
#import "Masonry.h"

@interface YHViewController ()

@property (atomic, strong) UITableView *tableView;

@end

@implementation YHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStylePlain];
    self.viewPresenter = [[YHViewPresenter alloc] init];
    self.viewPresenter.view = self;

    self.tableView.dataSource = self.viewPresenter;
    self.tableView.delegate = self.viewPresenter;
    [self.tableView registerClass:[YHMoviesTableViewCell class] forCellReuseIdentifier:@"cell"];

    [self.view addSubview:self.tableView];
    
    [self.viewPresenter loadMovies];
}

- (void)updateViewConstraints {
    __weak YHViewController *weakSelf = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top);
        make.left.equalTo(weakSelf.view.mas_left);
        make.height.equalTo(weakSelf.view.mas_height);
        make.width.equalTo(weakSelf.view.mas_width);
    }];
    [super updateViewConstraints];
}

#pragma mark - Presenter calls

- (void)refresh {
    [self.tableView reloadData];
}


@end
