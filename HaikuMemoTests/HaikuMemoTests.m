//
//  HaikuMemoTests.m
//  HaikuMemoTests
//
//  Created by 清水 一征 on 13/03/21.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "HaikuMemoTests.h"

@implementation HaikuMemoTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
   
    KSListViewController* listView = [[KSListViewController alloc]init];
    STAssertNil(listView.selectedIndexPath, nil);
    
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

@end
