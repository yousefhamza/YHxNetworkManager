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

@property (atomic, strong) YHxSessionManager *sessionManager;

@end

@implementation YHxNetworkManager

/*
 Singleton method
 */
+ (YHxNetworkManager *)sharedManager {
    static YHxNetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] initManager];
    });
    return sharedManager;
}

- (id)initManager {
    self = [super init];
    if (self) {
        self.sessionManager = [[YHxSessionManager alloc] init];
    }
    return self;
}

//- (id)init {
//    // TODO: Throw exception
//}

- (void)makeRequestWithHTTPVerb:(NSString *)verb URL:(NSString *)url parameters:(id)parameters sucesss:(void(^)(NSData *data, NSURLResponse *response))sucess failure:(void(^)(NSError *error))failure {
    [[self sessionDataTaskForHTTPVerb:verb URL:url parameters:parameters sucesss:sucess failure:failure] resume];
}

- (void)GET:(NSString *)url parameters:(id)parameters sucesss:(void(^)(NSData *data, NSURLResponse *response))sucess failure:(void(^)(NSError *error))failure {

    [[self sessionDataTaskForHTTPVerb:@"GET" URL:url parameters:parameters sucesss:sucess failure:failure] resume];
}
- (void)POST:(NSString *)url parameters:(id)parameters sucesss:(void(^)(NSData *data, NSURLResponse *response))sucess failure:(void(^)(NSError *error))failure {

    [[self sessionDataTaskForHTTPVerb:@"POST" URL:url parameters:parameters sucesss:sucess failure:failure] resume];
}
- (void)PUT:(NSString *)url parameters:(id)parameters sucesss:(void(^)(NSData *data, NSURLResponse *response))sucess failure:(void(^)(NSError *error))failure {

    [[self sessionDataTaskForHTTPVerb:@"PUT" URL:url parameters:parameters sucesss:sucess failure:failure] resume];
}
- (void)DELETE:(NSString *)url parameters:(id)parameters sucesss:(void(^)(NSData *data, NSURLResponse *response))sucess failure:(void(^)(NSError *error))failure {

    [[self sessionDataTaskForHTTPVerb:@"DELETE" URL:url parameters:parameters sucesss:sucess failure:failure] resume];
}

- (void)getImage:(NSString *)URL parameters:(id)parameters sucesss:(void(^)(UIImage * image))sucess failure:(void(^)(NSError *error))failure {
    
    NSURL *requestURL = [NSURL URLWithString:URL relativeToURL:self.baseURL];

    [[self.sessionManager.session downloadTaskWithURL:requestURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            sucess([UIImage imageWithData:[NSData dataWithContentsOfURL:location]]);
        } else {
            failure(error);
        }
    }] resume];
}

#pragma mark - Refactoring method

- (NSURLSessionDataTask *)sessionDataTaskForHTTPVerb:(NSString *)verb URL:(NSString *)URL parameters:(id)parameters sucesss:(void(^)(NSData *data, NSURLResponse *response))sucess failure:(void(^)(NSError *error))failure {

    NSURL *requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", self.baseURL, URL]];

    NSURLRequest *request = [self.requestSerializer
                             URLRequestForURL:requestURL
                             HTTPVerb:verb
                             parameters:parameters];
    return [self.sessionManager.session
            dataTaskWithRequest:request
            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (!error) {
                    sucess(data, response);
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

- (void)setAuthentication:(NSString *)username password:(NSString *)password {
    [self.sessionManager setAuthentication:username password:password];
}

#pragma mark - Custom Getter

- (id<YHxRequestSeralizerProtcol>)requestSerializer {
    if (_requestSerializer == nil) {
        _requestSerializer = [[YHxJSONSerializer alloc] init];
        [self.sessionManager addHeader:@"Content-Type" headerValue:@"Application/json"];
    }
    return _requestSerializer;
}

@end
