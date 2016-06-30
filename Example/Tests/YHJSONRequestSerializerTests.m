//
//  YHSessionManagerTests.m
//  YHxNetworkManager
//
//  Created by Yousef Hamza on 6/30/16.
//  Copyright © 2016 Yousef Hamza. All rights reserved.
//

#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>
#import <Kiwi/Kiwi.h>
#import "YHxJSONRequestSerializer.h"


SPEC_BEGIN(JSONRequestSerializerTests)

describe(@"JSON request serializer", ^{
    context(@"Can serialze", ^{
        __block YHxJSONSerializer *requestSerialzer = nil;
        beforeEach(^{
            requestSerialzer = [[YHxJSONSerializer alloc] init];
        });
        
        it(@"Dictionaries", ^{
            NSURLRequest *request = [requestSerialzer URLRequestForURL:[NSURL URLWithString:@"http://www.example.com"] HTTPVerb:@"GET" parameters:@{@"testKey": @"testValue"}];
            
            NSString *requestBodyString = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
            [[requestBodyString should] equal:@"{\"testKey\":\"testValue\"}"];
        });
        
        it(@"Arrays", ^{
            NSURLRequest *request = [requestSerialzer URLRequestForURL:[NSURL URLWithString:@"http://www.example.com"] HTTPVerb:@"GET" parameters:@[@{@"testKey": @"testValue"}]];
            
            NSString *requestBodyString = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
            [[requestBodyString should] equal:@"[{\"testKey\":\"testValue\"}]"];
        });
    });
});

SPEC_END
