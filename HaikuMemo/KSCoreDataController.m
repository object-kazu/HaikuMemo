//  template
//  KSHaikuController.m
//  LastSupper
//
//  Created by 清水 一征 on 12/10/28.
//  Copyright (c) 2012年 momiji-mac.com. All rights reserved.
//

#import "KSCoreDataController.h"

#define ENTITY_NAME @"Haiku"

@interface KSCoreDataController ()

@end

@implementation KSCoreDataController

#pragma mark -
#pragma mark ---------- init ----------

static KSCoreDataController * _sharedInstance = nil;

+ (KSCoreDataController *)sharedManager {
    
    if ( !_sharedInstance ) {
        _sharedInstance = [[KSCoreDataController alloc]init];
    }
    
    return _sharedInstance;
}

#pragma mark -
#pragma mark ---------- property ----------

//debug
- (NSInteger)haikuNumber {
    NSArray    *arr = [self sortedEntity:YES];
    
    return [arr count];
}

- (NSManagedObjectContext *)managedObjectContext {
    
    NSError    *error;
    
    // インスタンス変数のチェック
    
    if ( _managedObjectContext ) {
        return _managedObjectContext;
    }
    
    // 管理対象オブジェクトモデルの作成
    NSManagedObjectModel    *managedObjectModel;
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // 永続ストアコーディネータの作成
    NSPersistentStoreCoordinator    *persistentStoreCoordinator;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                  initWithManagedObjectModel:managedObjectModel];
    
    // 保存ファイルの決定
    NSArray     *paths;
    NSString    *path = nil;
    paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ( [paths count] > 0 ) {
        path = [paths objectAtIndex:0];
        path = [path stringByAppendingPathComponent:@".hiku"];
        path = [path stringByAppendingPathComponent:@"haiku.db"];
    }
    
    if ( !path ) {
        return nil;
    }
    
    // ディレクトリの作成
    NSString         *dirPath;
    NSFileManager    *fileMgr;
    dirPath = [path stringByDeletingLastPathComponent];
    fileMgr = [NSFileManager defaultManager];
    if ( ![fileMgr fileExistsAtPath:dirPath] ) {
        if ( ![fileMgr  createDirectoryAtPath:dirPath
                  withIntermediateDirectories:YES attributes:nil error:&error] ) {
            NSLog(@"Failed to create directory at path %@, erro %@",
                  dirPath, [error localizedDescription]);
        }
    }
    
    // ストアURLの作成
    NSURL    *url = nil;
    url = [NSURL fileURLWithPath:path];
    
    // 永続ストアの追加
    NSPersistentStore    *persistentStore;
    persistentStore = [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                               configuration:nil URL:url options:nil error:&error];
    if ( !persistentStore && error ) {
        NSLog(@"Failed to create add persitent store, %@", [error localizedDescription]);
    }
    
    // 管理対象オブジェクトコンテキストの作成
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    
    // 永続ストアコーディネータの設定
    [_managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    
    return _managedObjectContext;
}

#pragma mark -
#pragma mark ---------- item operate ----------

// アイテムの操作
- (Haiku *)insertNewEntity {
    
    NSManagedObjectContext    *context;
    context = self.managedObjectContext;
    
    Haiku                     *aHaiku;
    aHaiku = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
    
    return aHaiku;
}

- (void)deleteAnItem:(NSString *)deleteFlug {
    
    // 管理対象オブジェクトコンテキストを取得する
    NSManagedObjectContext    *context;
    context = self.managedObjectContext;
    
    // 取得要求を作成する
    NSFetchRequest         *request;
    NSEntityDescription    *entity;
    
    request = [[NSFetchRequest alloc] init];
    
    entity = [NSEntityDescription entityForName:ENTITY_NAME inManagedObjectContext:context];
    
    [request setEntity:entity];
    
    NSPredicate    *predicate = [NSPredicate predicateWithFormat:@"deleteFlug == %@", DELETE_FLUG_YES];
    
    [request setPredicate:predicate];
    [request setFetchBatchSize:1];
    
    // 取得要求を実行する
    NSArray    *result;
    NSError    *error = nil;
    result = [context executeFetchRequest:request error:&error];
    if ( !result ) {
        // エラー
        NSLog(@"executeFetchRequest: failed, %@", [error localizedDescription]);
        
        return;
    }
    for ( NSManagedObject *obj in result ) {
        [context deleteObject:obj];
    }
    
    [self save];
    
}

- (void)deleteItems:(NSString *)identifer {
    
    // 管理対象オブジェクトコンテキストを取得する
    NSManagedObjectContext    *context;
    context = self.managedObjectContext;
    
    // 取得要求を作成する
    NSFetchRequest         *request;
    NSEntityDescription    *entity;
    
    request = [[NSFetchRequest alloc] init];
    
    entity = [NSEntityDescription entityForName:ENTITY_NAME inManagedObjectContext:context];
    
    [request setEntity:entity];
    
    NSPredicate    *predicate = [NSPredicate predicateWithFormat:@"identifer == %@", identifer];
    
    [request setPredicate:predicate];
    [request setFetchBatchSize:1];
    
    // 取得要求を実行する
    NSArray    *result;
    NSError    *error = nil;
    result = [context executeFetchRequest:request error:&error];
    if ( !result ) {
        // エラー
        NSLog(@"executeFetchRequest: failed, %@", [error localizedDescription]);
        
        return;
    }
    for ( NSManagedObject *obj in result ) {
        [context deleteObject:obj];
    }
    
    [self save];
    
}

- (NSArray *)sortedEntity:(BOOL)fromOld_toNew {
    
    // 管理対象オブジェクトコンテキストを取得する
    NSManagedObjectContext    *context;
    context = self.managedObjectContext;
    
    // 取得要求を作成する
    NSFetchRequest         *request;
    NSEntityDescription    *entity;
    NSSortDescriptor       *sortDescriptor;
    request = [[NSFetchRequest alloc] init];
    
    entity = [NSEntityDescription entityForName:ENTITY_NAME inManagedObjectContext:context];
    
    [request setEntity:entity];
    
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:fromOld_toNew]; // "date" should be check!
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    // 取得要求を実行する
    NSArray    *result;
    NSError    *error = nil;
    result = [context executeFetchRequest:request error:&error];
    if ( !result ) {
        // エラー
        NSLog(@"executeFetchRequest: failed, %@", [error localizedDescription]);
        
        return nil;
    }
    
    return result;
    
}

- (NSArray *)extractEntityByChild:(BOOL)isChild {
    
    // 管理対象オブジェクトコンテキストを取得する
    NSManagedObjectContext    *context;
    context = self.managedObjectContext;
    
    // 取得要求を作成する
    NSFetchRequest         *request;
    NSEntityDescription    *entity;
    NSSortDescriptor       *sortDescriptor;
    request = [[NSFetchRequest alloc] init];
    
    entity = [NSEntityDescription entityForName:ENTITY_NAME inManagedObjectContext:context];
    
    [request setEntity:entity];
    
    NSPredicate    *predicate = [NSPredicate predicateWithFormat:@"child == %d", isChild];
    [request setPredicate:predicate];
    [request setFetchBatchSize:1];
    
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    // 取得要求を実行する
    NSArray    *result;
    NSError    *error = nil;
    result = [context executeFetchRequest:request error:&error];
    if ( !result ) {
        // エラー
        NSLog(@"executeFetchRequest: failed, %@", [error localizedDescription]);
        
        return nil;
    }
    
    return result;
}

- (NSArray *)extractEntityByID:(NSString *)identify {
    
    // 管理対象オブジェクトコンテキストを取得する
    NSManagedObjectContext    *context;
    context = self.managedObjectContext;
    
    // 取得要求を作成する
    NSFetchRequest         *request;
    NSEntityDescription    *entity;
    NSSortDescriptor       *sortDescriptor;
    request = [[NSFetchRequest alloc] init];
    
    entity = [NSEntityDescription entityForName:ENTITY_NAME inManagedObjectContext:context];
    
    [request setEntity:entity];
    
    NSPredicate    *predicate = [NSPredicate predicateWithFormat:@"identifer == %@", identify];
    
    [request setPredicate:predicate];
    [request setFetchBatchSize:1];
    
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    // 取得要求を実行する
    NSArray    *result;
    NSError    *error = nil;
    result = [context executeFetchRequest:request error:&error];
    if ( !result ) {
        // エラー
        NSLog(@"executeFetchRequest: failed, %@", [error localizedDescription]);
        
        return nil;
    }
    
    return result;
    
}

#pragma mark -
#pragma mark -- 永続化 --

- (void)save {
    // 保存
    NSError    *error;
    if ( ![self.managedObjectContext save:&error] ) {
        // エラー
        NSLog(@"Error, %@", error);
    }
    
}

@end
