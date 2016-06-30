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
#import "YHxJSONResponseSerialzer.h"


SPEC_BEGIN(JSONResponseSerializerTests)

describe(@"JSON response serializer", ^{
    context(@"Can serialze", ^{
        __block YHxJSONResponseSerialzer *responseSerialzer = nil;
        beforeEach(^{
            responseSerialzer = [[YHxJSONResponseSerialzer alloc] init];
        });
        
        it(@"Dictionaries", ^{
            NSDictionary *dict = [responseSerialzer objectFromResponseData:[@"{\"testKey\":\"testValue\"}" dataUsingEncoding:NSUTF8StringEncoding]];

            [[[dict objectForKey:@"testKey"] should] equal:@"testValue"];
        });
        
        it(@"Arrays", ^{
            NSArray *array = [responseSerialzer objectFromResponseData:[@"[{\"testKey\":\"testValue\"}]" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [[[NSNumber numberWithInteger:array.count] should] equal:@1];
            
            NSDictionary *dict = array[0];
            
            [[[dict objectForKey:@"testKey"] should] equal:@"testValue"];
        });
    });
});

SPEC_END
