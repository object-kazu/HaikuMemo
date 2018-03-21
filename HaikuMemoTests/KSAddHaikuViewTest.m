//
//  KSAddHaikuViewTest.m
//  HaikuMemo
//
//  Created by 清水 一征 on 13/03/29.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import "KSAddHaikuViewTest.h"


@interface KSAddHaikuViewController (Private)

@property (nonatomic,assign)    BOOL    isPhotoButtonTouch;
@property (nonatomic,assign)    BOOL    isTouchEnd;
@property (nonatomic)           CGRect  initPosi_touchResultView;
@property (nonatomic)           float   touchResultViewCenter;

@property (nonatomic)           float   moveAmount;
@property (nonatomic)           BOOL    isOverLowLimit;
@property (nonatomic)           BOOL    isOverHighLimit;
//@property (nonatomic)           touchDirection direct;



- (void) popupView:(UIView *)view act:(ACTION)act;
- (void) actionAfterTouch;



@end


@implementation KSAddHaikuViewTest

- (void)setUp
{
    
    [super setUp];

    _editView = [[KSAddHaikuViewController alloc]init];
}

- (void)tearDown
{
    // Tear-down code here.
    _editView = nil;
    
    [super tearDown];
}



-(void)test_CGRectOfNabiBarEdit{
    CGRect rec = _editView.initPosi_NaviBarEdit;
    
    STAssertTrue((rec.origin.x == 0), nil);
    STAssertTrue((rec.origin.y == 0), nil);
    STAssertTrue((rec.size.width == 0 ), nil);

}



@end
