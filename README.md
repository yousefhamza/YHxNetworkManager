# YHxNetworkManager

[![CI Status](http://img.shields.io/travis/Yousef Hamza/YHxNetworkManager.svg?style=flat)](https://travis-ci.org/Yousef Hamza/YHxNetworkManager)
[![Version](https://img.shields.io/cocoapods/v/YHxNetworkManager.svg?style=flat)](http://cocoapods.org/pods/YHxNetworkManager)
[![License](https://img.shields.io/cocoapods/l/YHxNetworkManager.svg?style=flat)](http://cocoapods.org/pods/YHxNetworkManager)
[![Platform](https://img.shields.io/cocoapods/p/YHxNetworkManager.svg?style=flat)](http://cocoapods.org/pods/YHxNetworkManager)

## Introduction

This library is lightweight wrapper around NSURLSession that covers most of your use cases and
extensible to support other use cases as well

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

Your key player is YHxNetworkManager it's ready to use right a way with no configuration:

```objective-c
YHxNetworkManager *networkManager = [YHxNetworkManager alloc] init];
```

All the way to fully configured YHxNetworkManager which still minimal:

```objective-c
YHxNetworkManager *networkManager = [YHxNetworkManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://example.com"];
networkManager.requestSerializer = [YHxJSONRequestSerializer alloc] init];
networkManager.responseSerializer = [YHxJSONResponseSerialzer alloc] init];
```

To issue an HTTP request you can by providing the HTTP verb, URL and the parameters:

```objective-c
[networkManager makeRequestWithHTTPVerb:@"GET" URL:@"/d1/d2" parameters:nil 
sucesss:^(id responseObject, NSURLResponse *response) {
    NSLog(@"sucess and response: %@", responseObject);
} failure:^(NSError *error) {
    NSLog(@"Error: %@", error);
}];
```

Or you can use more convenient method:

```objective-c
[networkManager GET:@"/d1/d2" parameters:nil
sucesss:^(id responseObject, NSURLResponse *response) {
    NSLog(@"sucess and response: %@", responseObject);
} failure:^(NSError *error) {
    NSLog(@"Error: %@", error);
}];
```

there's also POST, PUT, DELETE.

Also it provides a simple API for loading images asynchronously

```objective-c
[networkManager getImage:@"/image/1" parameters:nil
sucesss:^(UIImage *image) {
    NSLog(@"sucess");
} failure:^(NSError *error) {
    NSLog(@"Error: %@", error);
}];
```

## Installation

YHxNetworkManager is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "YHxNetworkManager"
```

## Author

Yousef Hamza, jo.adam.93@gmail.com

## License

YHxNetworkManager is available under the MIT license. See the LICENSE file for more info.
