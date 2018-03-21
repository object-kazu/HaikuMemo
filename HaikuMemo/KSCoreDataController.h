//  template
//  KSDietController.h
//  LastSupper
//
//  Created by 清水 一征 on 12/10/28.
//  Copyright (c) 2012年 momiji-mac.com. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "Haiku.h"
#import "def.h"

@interface KSCoreDataController : NSObject
{
    NSManagedObjectContext    *_managedObjectContext;
}

// プロパティ
@property (nonatomic, readonly) NSManagedObjectContext    *managedObjectContext;
@property (nonatomic, readonly) NSInteger                 haikuNumber;

// 初期化
+ (KSCoreDataController *)sharedManager;

// アイテムの操作
- (Haiku *)insertNewEntity;
- (void)deleteItems:(NSString *)identifer;
- (void)deleteAnItem:(NSString *)deleteFlug;
- (NSArray *)sortedEntity:(BOOL)fromOld_toNew;
- (NSArray *)extractEntityByChild:(BOOL)isChild;
- (NSArray *)extractEntityByID:(NSString *)identify;
// 永続化
- (void)save;

@end
