//
//  UIAutoTestTests.m
//  UIAutoTestTests
//
//  Created by Gemtek_Phineas_Huang on 2015/1/15.
//  Copyright (c) 2015年 SunXiaoShan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface UIAutoTestTests : XCTestCase
{
    

}
@end

@implementation UIAutoTestTests

int test;

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
     test = 99;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

+ (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
   
}

+ (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(NO, @"Pass");
    NSLog(@"Hello World");
    NSLog(@"test log");
}

- (void)testExample2 {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
    NSLog(@"Hello World");
    NSLog(@"test log");
    
    
    NSString *str = @"fefe";
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
