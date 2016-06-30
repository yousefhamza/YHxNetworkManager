//
//  YHSessionManagerTests.m
//  YHxNetworkManager
//
//  Created by Yousef Hamza on 6/30/16.
//  Copyright © 2016 Yousef Hamza. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "YHxNetworkMAnager.h"
#import "YHxSessionMAnager.h"


SPEC_BEGIN(SessionManagerTests)

describe(@"Sesion Manager", ^{
    __block YHxSessionManager *sessionManager = nil;
    context(@"Can change headers", ^{
        beforeEach(^{
            sessionManager = [[YHxSessionManager alloc] init];
        });

        it(@"Can set session headers", ^{
            [sessionManager setHeaders:@{@"testHeader": @"testValue"}];
            [[[sessionManager.session.configuration.HTTPAdditionalHeaders objectForKey:@"testHeader"] should] equal:@"testValue"];
        });

        it(@"Can add to exsiting headers", ^{
            [sessionManager addHeader:@"testHeader1" headerValue:@"testValue1"];
            [sessionManager addHeader:@"testHeader2" headerValue:@"testValue2"];
            
            [[[sessionManager.session.configuration.HTTPAdditionalHeaders objectForKey:@"testHeader1"] should] equal:@"testValue1"];
            [[[sessionManager.session.configuration.HTTPAdditionalHeaders objectForKey:@"testHeader2"] should] equal:@"testValue2"];
        });
        
        it(@"Can set authorization", ^{
            [sessionManager setAuthentication:@"username" password:@"password"];
            
            [[[sessionManager.session.configuration.HTTPAdditionalHeaders objectForKey:@"Authorization"] shouldNot] beNil];
        });
        
        it(@"Can get existing headers", ^{
            [sessionManager setHeaders:@{@"testHeader": @"testValue"}];

            [[[sessionManager headerForKey:@"testHeader"] should] equal:@"testValue"];
        });
    });
});

SPEC_END
