//
//  YHxSessionManager.h
//  Pods
//
//  Created by Yousef Hamza on 6/29/16.
//
//

#import <Foundation/Foundation.h>

@interface YHxSessionManager : NSObject

@property (readonly, atomic, strong) NSURLSession *session;

/*
 Conveninet methods
 */
- (void)setAuthentication:(NSString *)username password:(NSString *)password;

/*
 Custom configuration methods
 */
- (void)setHeaders:(NSDictionary *)dict;
- (void)addHeader:(NSString *)header headerValue:(NSString *)headerValue;
- (NSString *)headerForKey:(NSString *)headerKey;

@end
