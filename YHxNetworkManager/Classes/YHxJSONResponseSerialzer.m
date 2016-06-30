//
//  YHxJSONResponseSerialzer.m
//  Pods
//
//  Created by Yousef Hamza on 6/30/16.
//
//

#import "YHxJSONResponseSerialzer.h"

@implementation YHxJSONResponseSerialzer

- (id)objectFromResponseData:(NSData *)data {
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

@end
