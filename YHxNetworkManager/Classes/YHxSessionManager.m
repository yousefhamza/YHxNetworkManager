//
//  YHxSessionManager.m
//  Pods
//
//  Created by Yousef Hamza on 6/29/16.
//
//

#import "YHxSessionManager.h"
#import "Reachability.h"

@interface YHxSessionManager ()

@property (nonatomic, strong) NSURLSessionConfiguration *config;
@property (atomic, strong) NSOperationQueue *queue;

@end

@implementation YHxSessionManager

- (id)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkTypeChanged:) name:kReachabilityChangedNotification object:nil];

        Reachability *reachability = [Reachability reachabilityForInternetConnection];
        [reachability startNotifier];

        NetworkStatus status = [reachability currentReachabilityStatus];

        self.config = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.config.HTTPAdditionalHeaders = @{
                                              @"Content-Type": @"Applicaion/json"
                                              };
        if (status == ReachableViaWWAN) {
            self.config.HTTPMaximumConnectionsPerHost = 2;
        } else if (status == ReachableViaWiFi) {
            self.config.HTTPMaximumConnectionsPerHost = 6;
        }

        self.queue = [[NSOperationQueue alloc] init];
        _session = [NSURLSession sessionWithConfiguration:self.config delegate:nil delegateQueue:self.queue];
    }
    return self;
}

/*
 Conveninet methods
 */
- (void)setAuthentication:(NSString *)username password:(NSString *)password {
    
    /*
     Basic Authenticion is by setting "Authorization" header to "Base base64(username:password)"
     */
    NSString *authString = [[[NSString stringWithFormat:@"%@:%@", username, password]
                             dataUsingEncoding:NSUTF8StringEncoding]
                            base64EncodedStringWithOptions:0];
    [self addHeader:@"Authorization" headerValue:[NSString stringWithFormat:@"Base %@", authString]];
}

/*
 Custom configuration methods
 */
- (void)setHeaders:(NSDictionary *)dict {
    NSURLSessionConfiguration *config = self.config;
    config.HTTPAdditionalHeaders = dict;
    self.config = config;
}

- (void)addHeader:(NSString *)header headerValue:(NSString *)headerValue {
    NSURLSessionConfiguration *config = self.config;
    NSMutableDictionary *headers =  [NSMutableDictionary dictionaryWithDictionary:self.config.HTTPAdditionalHeaders];

    [headers setObject:headerValue forKey:header];
    
    config.HTTPAdditionalHeaders = headers;
    self.config = config;
}

- (NSString *)headerForKey:(NSString *)headerKey {
    return [self.config.HTTPAdditionalHeaders objectForKey:headerKey];
}

#pragma mark - Notification center observer

- (void)networkTypeChanged:(NSNotification *)notification {
    Reachability *reachability = [notification object];
    NetworkStatus status = [reachability currentReachabilityStatus];
    NSURLSessionConfiguration *config = self.config;

    if (status == ReachableViaWiFi) {
        config.HTTPMaximumConnectionsPerHost = 6;
    } else if (status == ReachableViaWWAN) {
        config.HTTPMaximumConnectionsPerHost = 2;
    }
    self.config = config;
}

#pragma mark - Custom setter


/*
 Re-init NSURLSession every time NSURLSessionConfiguration changes
 */
- (void)setConfig:(NSURLSessionConfiguration *)config {
    _session = [NSURLSession sessionWithConfiguration:self.config delegate:nil delegateQueue:self.queue];
    _config = config;
}

@end
