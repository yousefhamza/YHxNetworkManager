//
//  YHxJSONSerializer.m
//  Pods
//
//  Created by Yousef Hamza on 6/29/16.
//
//

#import "YHxJSONRequestSerializer.h"

@implementation YHxJSONRequestSerializer

- (NSURLRequest *)URLRequestForURL:(NSURL *)url HTTPVerb:(NSString *)verb parameters:(id)parameters {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = verb;
    
    if (parameters) {
        NSData *bodyData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
        if (bodyData) {
            request.HTTPBody = bodyData;
            return request;
        } else {
            return nil;
        }
    }
    return request;
}

@end