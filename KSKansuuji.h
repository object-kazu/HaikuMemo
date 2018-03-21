//
//  KSKansuuji.h
//  HaikuMemo
//
//  Created by 清水 一征 on 13/04/07.
//  Copyright (c) 2013年 momiji-mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSKansuuji : NSObject

- (NSString *)waTuki:(NSInteger)number;
- (NSString *)suKanTranslateByUnit:(NSString *)num;
- (NSString *)suKanTranslate:(NSString *)numbers;
- (NSString *)dateForHaikuMemo:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end
