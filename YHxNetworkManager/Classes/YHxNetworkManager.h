//
//  YHxNetworkManager.h
//  Pods
//
//  Created by Yousef Hamza on 6/29/16.
//
//

#import <Foundation/Foundation.h>
#import "YHxRequestSeralizerProtcol.h"
#import "YHxResponseSerializerProtocol.h"

@interface YHxNetworkManager : NSObject

@property (atomic, strong) NSURL *baseURL;
@property (nonatomic, strong) id<YHxRequestSeralizerProtcol> requestSerializer;
@property (nonatomic, strong) id<YHxResponseSerializerProtocol> responseSerializer;

/*
 Singleton method
 */
+ (YHxNetworkManager *)sharedManager;


/*
 Required interface
 */
- (void)makeRequestWithHTTPVerb:(NSString *)verb URL:(NSString *)url parameters:(id)parameters
                        sucesss:(void(^)(id responseObject, NSURLResponse *response))sucess
                        failure:(void(^)(NSError *error))failure;

/*
 AFNetworking like interface for making request
 */
- (void)GET:(NSString *)URL parameters:(id)parameters
    sucesss:(void(^)(id responseObject, NSURLResponse *response))sucess
    failure:(void(^)(NSError *error))failure;

- (void)POST:(NSString *)URL parameters:(id)parameters
     sucesss:(void(^)(id responseObject, NSURLResponse *response))sucess
     failure:(void(^)(NSError *error))failure;

- (void)PUT:(NSString *)URL parameters:(id)parameters
    sucesss:(void(^)(id responseObject, NSURLResponse *response))sucess
    failure:(void(^)(NSError *error))failure;

- (void)DELETE:(NSString *)URL parameters:(id)parameters
       sucesss:(void(^)(id responseObject, NSURLResponse *response))sucess
       failure:(void(^)(NSError *error))failure;

/*
 Seperate API for loading images
 */
- (void)getImage:(NSString *)URL parameters:(id)parameters sucesss:(void(^)(UIImage * image))sucess failure:(void(^)(NSError *error))failure;


/*
 Proxy methods for Session Manager
 */

- (void)addHeader:(NSString *)header headerValue:(NSString *)headerValue;
- (void)setHeaders:(NSDictionary *)dict;
- (NSString *)headerForKey:(NSString *)headerKey;
- (void)setAuthentication:(NSString *)username password:(NSString *)password;
@end
