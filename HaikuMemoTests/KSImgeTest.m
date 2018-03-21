//
//  KSImgeTest.m
//  HaikuMemo
//
//  Created by 清水 一征 on 13/03/28.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSImgeTest.h"
#import "def.h"

@implementation KSImgeTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    _ksimg = [[KSImage alloc]init];
    STAssertNotNil(_ksimg, @"Could not create _ksimg.");

    _testImg = [UIImage imageNamed:DEFAULT_IMG];
    
}

- (void)tearDown
{
    // Tear-down code here.
    _ksimg = nil;

    [super tearDown];
}


-(void)test_CropImage_Small{
    UIImage *target = [_ksimg cropImageView:_testImg isSmall:YES];
    STAssertTrue(target.size.width < _testImg.size.width, nil);
    STAssertEquals(target.size.width, (float)SMALL_THUMIMAGE_SIZE, nil);
    
}

-(void)test_CropImage_Big{
    UIImage *target = [_ksimg cropImageView:_testImg isSmall:NO];

    STAssertEquals(target.size.width, (float)THUMIMAGE_SIZE, nil);
}

-(void)test_isThumbSize{
    //_testImg size 75 x 75
    // thumbnail size = 290

    STAssertEquals(YES, [_ksimg isThumbSize:_testImg],nil);
    STAssertTrue([_ksimg isThumbSize:_testImg], nil);
    
}

-(void)test_isSmallThumbsize{
    //_testImg size 75 x 75
    // small thumbnail size = 38

    STAssertFalse([_ksimg isSmallThumbSize:_testImg], nil);

}

-(void)test_GetThumbImg{
    //testImg size 75 x 75
    //target size 75 x 75

    UIImage* target = [_ksimg getThumbImage:_testImg];
    STAssertEquals(target.size.width, _testImg.size.width, nil);
    STAssertEquals(target.size.width, 75.0f, nil);
    
    
}

@end
