//
//  YHMoviesTableViewCell.m
//  YHxNetworkManager
//
//  Created by Yousef Hamza on 6/30/16.
//  Copyright © 2016 Yousef Hamza. All rights reserved.
//

#import "YHMoviesTableViewCell.h"
#import "Masonry.h"

@implementation YHMoviesTableViewCell

- (id)init {
    self = [super init];
    if (self) {
        self.movieImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        self.movieTitle = [[UILabel alloc] init];
        self.movieYear = [[UILabel alloc] init];
        
        [self addSubview:self.movieImage];
        [self addSubview:self.movieTitle];
        [self addSubview:self.movieYear];
    }
    return self;
}

- (void)layoutSubviews {
    __weak YHMoviesTableViewCell *weakSelf = self;
    
    [self.movieImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(5);
        make.left.equalTo(weakSelf.mas_left).offset(5);
        make.height.equalTo(@50);
        make.width.equalTo(@50);
    }];
    
    [self.movieTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(5);
        make.left.equalTo(weakSelf.movieImage.mas_right).offset(5);
        make.right.equalTo(weakSelf.mas_right).offset(-5);
    }];
    
    [self.movieYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.movieTitle.mas_bottom).offset(5);
        make.left.equalTo(weakSelf.movieTitle.mas_left);
        make.right.equalTo(weakSelf.mas_right).offset(-5);
    }];
    [super layoutSubviews];
}

@end
