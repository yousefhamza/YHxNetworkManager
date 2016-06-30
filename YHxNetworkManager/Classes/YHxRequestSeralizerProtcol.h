//
//  YHxRequestSeralizerProtcol.h
//  Pods
//
//  Created by Yousef Hamza on 6/29/16.
//
//

#import <Foundation/Foundation.h>

@protocol YHxRequestSeralizerProtcol <NSObject>

- (NSURLRequest *)URLRequestForURL:(NSURL *)url HTTPVerb:(NSString *)verb parameters:(id)parameters;

@end
