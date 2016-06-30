//
//  YHxResponseSerializerProtocol.h
//  Pods
//
//  Created by Yousef Hamza on 6/30/16.
//
//

#import <Foundation/Foundation.h>

@protocol YHxResponseSerializerProtocol <NSObject>

- (id)objectFromResponseData:(NSData *)data;

@end
