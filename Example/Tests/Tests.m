//
//  YHxNetworkManagerTests.m
//  YHxNetworkManagerTests
//
//  Created by Yousef Hamza on 06/30/2016.
//  Copyright (c) 2016 Yousef Hamza. All rights reserved.
//

// https://github.com/kiwi-bdd/Kiwi

#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>
#import <Kiwi/Kiwi.h>
#import "YHxNetworkMAnager.h"
#import "YHxSessionMAnager.h"


SPEC_BEGIN(InitialTests)

describe(@"Network Manager", ^{

    context(@"Can make requests", ^{
        beforeAll(^{
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
                return [[request.HTTPMethod uppercaseString] isEqualToString:@"GET"];
            } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
                NSDictionary *getResDict = @{@"get": @"sucess"};
                return [OHHTTPStubsResponse responseWithData:[NSJSONSerialization dataWithJSONObject:getResDict options:0 error:nil] statusCode:200 headers:@{@"Content-Type": @"Application/json"}];
            }];
            
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
                return [[request.HTTPMethod uppercaseString] isEqualToString:@"POST"];
            } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
                NSDictionary *getResDict = @{@"post": @"sucess"};
                return [OHHTTPStubsResponse responseWithData:[NSJSONSerialization dataWithJSONObject:getResDict options:0 error:nil] statusCode:200 headers:@{@"Content-Type": @"Application/json"}];
            }];
            
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
                return [[request.HTTPMethod uppercaseString] isEqualToString:@"PUT"];
            } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
                NSDictionary *getResDict = @{@"put": @"sucess"};
                return [OHHTTPStubsResponse responseWithData:[NSJSONSerialization dataWithJSONObject:getResDict options:0 error:nil] statusCode:200 headers:@{@"Content-Type": @"Application/json"}];
            }];
            
            [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest * _Nonnull request) {
                return [[request.HTTPMethod uppercaseString] isEqualToString:@"DELETE"];
            } withStubResponse:^OHHTTPStubsResponse * _Nonnull(NSURLRequest * _Nonnull request) {
                NSDictionary *getResDict = @{@"delete": @"sucess"};
                return [OHHTTPStubsResponse responseWithData:[NSJSONSerialization dataWithJSONObject:getResDict options:0 error:nil] statusCode:200 headers:@{@"Content-Type": @"Application/json"}];
            }];
        });

        [[YHxNetworkManager sharedManager] setBaseURL:[NSURL URLWithString:@"http://example.com"]];

        it(@"can do GET request", ^{
            __block NSDictionary *testResponse = nil;
            __block NSError *testError = nil;
            [[YHxNetworkManager sharedManager] GET:@"/get" parameters:nil sucesss:^(NSData *data, NSURLResponse *response) {
                testResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            } failure:^(NSError *error) {
                testError = error;
            }];

            [[expectFutureValue(testError) shouldEventually] beNil];
            [[expectFutureValue([testResponse objectForKey:@"get"]) shouldEventually] equal:@"sucess"];
        });

        it(@"can do POST request", ^{
            __block NSDictionary *testResponse = nil;
            __block NSError *testError = nil;
            [[YHxNetworkManager sharedManager] POST:@"/post" parameters:nil sucesss:^(NSData *data, NSURLResponse *response) {
                testResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            } failure:^(NSError *error) {
                testError = error;
            }];
            
            [[expectFutureValue(testError) shouldEventually] beNil];
            [[expectFutureValue([testResponse objectForKey:@"post"]) shouldEventually] equal:@"sucess"];
      });
    
      it(@"can do PUT request", ^{
          __block NSDictionary *testResponse = nil;
          __block NSError *testError = nil;
          [[YHxNetworkManager sharedManager] PUT:@"/put" parameters:nil sucesss:^(NSData *data, NSURLResponse *response) {
              testResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
          } failure:^(NSError *error) {
              testError = error;
          }];
          
          [[expectFutureValue(testError) shouldEventually] beNil];
          [[expectFutureValue([testResponse objectForKey:@"put"]) shouldEventually] equal:@"sucess"];
      });
      
      it(@"can do DELETE request", ^{
          __block NSDictionary *testResponse = nil;
          __block NSError *testError = nil;
          [[YHxNetworkManager sharedManager] DELETE:@"/delete" parameters:nil sucesss:^(NSData *data, NSURLResponse *response) {
              testResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
          } failure:^(NSError *error) {
              testError = error;
          }];

          [[expectFutureValue(testError) shouldEventually] beNil];
          [[expectFutureValue([testResponse objectForKey:@"delete"]) shouldEventually] equal:@"sucess"];
      });
  });
  
});

SPEC_END

