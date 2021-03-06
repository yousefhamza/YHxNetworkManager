//
//  YHxNetworkManager.m
//  Pods
//
//  Created by Yousef Hamza on 6/29/16.
//
//

#import "YHxNetworkManager.h"
#import "YHxSessionManager.h"
#import "YHxJSONRequestSerializer.h"

@interface YHxNetworkManager ()

/*
 Session manager basically handle NSURLSession changes due
 to configuration changes
 */
@property (atomic, strong) YHxSessionManager *sessionManager;

@end

@implementation YHxNetworkManager

- (id)init {
    self = [super init];
    if (self) {
        self.sessionManager = [[YHxSessionManager alloc] init];
    }
    return self;
}

- (id)initWithBaseURL:(NSURL *)baseURL {
    self = [self init];
    if (self) {
        self.baseURL = baseURL;
    }
    return self;
}

- (void)makeRequestWithHTTPVerb:(NSString *)verb URL:(NSString *)url parameters:(id)parameters
                        sucesss:(void(^)(id responseObject, NSURLResponse *response))sucess
                        failure:(void(^)(NSError *error))failure {

    [[self sessionDataTaskForHTTPVerb:[verb uppercaseString] URL:url parameters:parameters sucesss:sucess failure:failure] resume];
}

- (void)GET:(NSString *)url parameters:(id)parameters
    sucesss:(void(^)(id responseObject, NSURLResponse *response))sucess
    failure:(void(^)(NSError *error))failure {

    [[self sessionDataTaskForHTTPVerb:@"GET" URL:url parameters:parameters sucesss:sucess failure:failure] resume];
}
- (void)POST:(NSString *)url parameters:(id)parameters
     sucesss:(void(^)(id responseObject, NSURLResponse *response))sucess
     failure:(void(^)(NSError *error))failure {

    [[self sessionDataTaskForHTTPVerb:@"POST" URL:url parameters:parameters sucesss:sucess failure:failure] resume];
}
- (void)PUT:(NSString *)url parameters:(id)parameters
    sucesss:(void(^)(id responseObject, NSURLResponse *response))sucess
    failure:(void(^)(NSError *error))failure {

    [[self sessionDataTaskForHTTPVerb:@"PUT" URL:url parameters:parameters sucesss:sucess failure:failure] resume];
}
- (void)DELETE:(NSString *)url parameters:(id)parameters
       sucesss:(void(^)(id responseObject, NSURLResponse *response))sucess
       failure:(void(^)(NSError *error))failure {

    [[self sessionDataTaskForHTTPVerb:@"DELETE" URL:url parameters:parameters sucesss:sucess failure:failure] resume];
}

- (void)getImage:(NSString *)url parameters:(id)parameters
         sucesss:(void(^)(UIImage * image))sucess
         failure:(void(^)(NSError *error))failure {
    
    NSURL *requestURL = nil;
    if (self.baseURL) {
        requestURL = [self.baseURL URLByAppendingPathComponent:url];
    } else {
        requestURL =[NSURL URLWithString:url];
    }

    [[self.sessionManager.session downloadTaskWithURL:requestURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            sucess([UIImage imageWithData:[NSData dataWithContentsOfURL:location]]);
        } else {
            failure(error);
        }
    }] resume];
}

#pragma mark - Refactoring method

- (NSURLSessionDataTask *)sessionDataTaskForHTTPVerb:(NSString *)verb URL:(NSString *)url parameters:(id)parameters
                                             sucesss:(void(^)(id responseObject, NSURLResponse *response))sucess
                                             failure:(void(^)(NSError *error))failure {
    NSURL *requestURL = nil;
    if (self.baseURL) {
        requestURL = [self.baseURL URLByAppendingPathComponent:url];
    } else {
        requestURL =[NSURL URLWithString:url];
    }

    NSURLRequest *request = [self.requestSerializer
                             URLRequestForURL:requestURL
                             HTTPVerb:verb
                             parameters:parameters];
    __weak YHxNetworkManager *weakSelf = self;
    return [self.sessionManager.session
            dataTaskWithRequest:request
            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (!error) {
                    if (weakSelf.responseSerializer) {
                        NSDictionary  *responseObject = [weakSelf.responseSerializer objectFromResponseData:data];
                        sucess(responseObject, response);
                    } else {
                        sucess(data, response);
                    }
                } else {
                    failure(error);
                }
            }];
}

#pragma mark - Proxy methods for YHxSessionManager


- (void)addHeader:(NSString *)header headerValue:(NSString *)headerValue {
    [self.sessionManager addHeader:header headerValue:headerValue];
}

- (void)setHeaders:(NSDictionary *)dict {
    [self.sessionManager setHeaders:dict];
}

- (NSString *)headerForKey:(NSString *)headerKey {
    return [self.sessionManager headerForKey:headerKey];
}

#pragma mark - Custom Getter

- (id<YHxRequestSeralizerProtcol>)requestSerializer {
    if (_requestSerializer == nil) {
        _requestSerializer = [[YHxJSONRequestSerializer alloc] init];
        [self.sessionManager addHeader:@"Content-Type" headerValue:@"Application/json"];
    }
    return _requestSerializer;
}

@end
