//
//  UIImageView+YHxNetworkManager.m
//  Pods
//
//  Created by Yousef Hamza on 6/30/16.
//
//

#import "UIImageView+YHxNetworkManager.h"
#import "YHxNetworkManager.h"

@implementation UIImageView (YHxNetworkManager)

- (void)setImageWithURL:(NSString *)url {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    CGRect bounds = self.bounds;
    CGFloat centerX = bounds.size.width / 2.0;
    CGFloat centerY = bounds.size.height / 2.0;
    
    activityIndicator.center = CGPointMake(centerX, centerY);
    [activityIndicator startAnimating];
    [self addSubview:activityIndicator];
    
    YHxNetworkManager *networkManager = [[YHxNetworkManager alloc] init];
    
    __weak UIImageView *weakSelf = self;
    [networkManager getImage:url parameters:nil sucesss:^(UIImage *image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicator stopAnimating];
            [activityIndicator removeFromSuperview];
            weakSelf.image = image;
        });
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [activityIndicator stopAnimating];
            [activityIndicator removeFromSuperview];
        });
    }];
}

@end
