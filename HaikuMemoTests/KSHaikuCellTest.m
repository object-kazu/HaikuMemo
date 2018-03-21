//
//  KSHaikuCellTest.m
//  HaikuMemo
//
//  Created by kazuyuki shimizu on 2013/12/05.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "KSHaikuCell.h"

@interface KSHaikuCellTest : SenTestCase

@property (nonatomic,retain) KSHaikuCell* hcell;

@end

@implementation KSHaikuCellTest

- (void)setUp
{
    [super setUp];
    self.hcell = [KSHaikuCell new];
    
                

}

- (void)tearDown
{
    self.hcell = nil;
    [super tearDown];
}

-(void) test_rRect{
    CGRect origin = CGRectMake(0, 0, 100, 50);
    CGRect trans = [self.hcell rRectMake:0 y:0 width:100 height:50];
    
}



@end
