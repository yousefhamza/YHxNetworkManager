//
//  YHViewPresenter.m
//  YHxNetworkManager
//
//  Created by Yousef Hamza on 6/30/16.
//  Copyright © 2016 Yousef Hamza. All rights reserved.
//

#import "YHViewPresenter.h"
#import "YHMovie.h"
#import "YHxNetworkManager.h"
#import "YHxJSONResponseSerialzer.h"
#import "YHMoviesTableViewCell.h"
#import "UIImageView+YHxNetworkManager.h"
#import "YHViewController.h"

@interface YHViewPresenter ()

@property (atomic, strong) YHxNetworkManager *networkManager;
@property (atomic, strong) NSArray *movies;

@end

@implementation YHViewPresenter

- (id)init {
    self = [super init];
    if (self) {
        self.networkManager = [[YHxNetworkManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/facebook/react-native/master/docs"]];
        self.networkManager.responseSerializer = [[YHxJSONResponseSerialzer alloc] init];
    }
    return self;
}

- (void)loadMovies {
    __weak YHViewPresenter *weakSelf = self;
    [self.networkManager GET:@"/MoviesExample.json" parameters:nil sucesss:^(id responseObject, NSURLResponse *response) {
        NSDictionary *moviesResponse = responseObject;
        NSArray *movies = moviesResponse[@"movies"];
        NSMutableArray *movieObjects = [[NSMutableArray alloc] init];
        
        for (NSDictionary *movie in movies) {
            YHMovie *movieObject = [[YHMovie alloc] init];
            movieObject.imageURL = movie[@"posters"][@"thumbnail"];
            movieObject.title = movie[@"title"];
            movieObject.year = [NSString stringWithFormat:@"%ld", (long)movie[@"year"]];
            [movieObjects addObject:movieObject];
        }
        weakSelf.movies = [NSArray arrayWithArray:movieObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.view refresh];
        });
    } failure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - TableView delegate and data source methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.movies) {
        return self.movies.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHMoviesTableViewCell *cell = nil;
    if (!cell) {
        cell = [[YHMoviesTableViewCell alloc] init];
    }
    YHMovie *movie = self.movies[indexPath.row];
    [cell.movieImage setImageWithURL:movie.imageURL];
    cell.movieTitle.text = movie.title;
    cell.movieYear.text = movie.year;
    return cell;
}

@end
