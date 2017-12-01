//
//  HTUserStoreManager.m
//  School
//
//  Created by hublot on 17/9/2.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTUserStoreManager.h"
#import <sqlite3.h>
#import "HTUserManager.h"

@implementation HTUserStoreManager

static NSString *kHTUserStoryTableName = @"story";

+ (BOOL)isStoredWithModel:(HTUserStoreModel *)model {
    BOOL isStored = false;
    [self createSqliteTable];
    sqlite3 *sqlite;
    sqlite3_stmt *statement;
    
    NSInteger uid = [HTUserManager currentUser].uid.integerValue;
    NSString *selectedSqliteString = [NSString stringWithFormat:@"select * from %@ where uid = %ld and type = %ld and lookID = %ld", kHTUserStoryTableName, uid, model.type, model.lookId.integerValue];
    if ((sqlite = [self openSqlite])) {
        if (sqlite3_prepare_v2(sqlite, [selectedSqliteString UTF8String], - 1, &statement, nil) == SQLITE_OK) {
            if (sqlite3_step(statement) == SQLITE_ROW) {
                isStored = true;
            }
        }
        sqlite3_finalize(statement);
        [self closeSqlite:sqlite];
    }
    return isStored;
}

+ (void)switchStoreStateWithModel:(HTUserStoreModel *)model {
    NSString *sqliteString = @"";
    [self createSqliteTable];
    NSInteger uid = [HTUserManager currentUser].uid.integerValue;
    if ([self isStoredWithModel:model]) {
        sqliteString = [NSString stringWithFormat:@"delete from %@ where uid = %ld and type = %ld and lookID = %ld", kHTUserStoryTableName, uid, model.type, model.lookId.integerValue];
    } else {
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
        model.lookTime = (NSInteger)time;
        NSDictionary *keyValue = model.mj_keyValues;
        
        
        NSString *keyValueString = @"";
        @try {
            if ([NSJSONSerialization isValidJSONObject:keyValue]) {
                NSError *error;
                NSData *keyValueData = [NSJSONSerialization dataWithJSONObject:keyValue options:NSJSONWritingPrettyPrinted error:&error];
                if (keyValueData) {
                    keyValueString = [[NSString alloc] initWithData:keyValueData encoding:NSUTF8StringEncoding];
                }
            }
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        NSInteger type = model.type;
        NSInteger createTime = model.lookTime;
        sqliteString = [NSString stringWithFormat:@"insert into '%@' ('%@', '%@', '%@', '%@', '%@') values ('%ld', '%ld', '%ld', '%ld', '%@')", kHTUserStoryTableName, @"uid", @"type", @"lookID", @"createTime", @"keyValue", uid, type, model.lookId.integerValue, createTime, keyValueString];
    }
    [self execSqliteString:sqliteString];
}

+ (NSInteger)allStoreCount {
    NSInteger storeCount = 0;
    [self createSqliteTable];
    sqlite3 *sqlite;
    sqlite3_stmt *statement;
    
    NSInteger uid = [HTUserManager currentUser].uid.integerValue;
    NSString *selectedSqliteString = [NSString stringWithFormat:@"select * from %@ where uid = %ld", kHTUserStoryTableName, uid];
    if ((sqlite = [self openSqlite])) {
        if (sqlite3_prepare_v2(sqlite, [selectedSqliteString UTF8String], - 1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                storeCount ++;
            }
        }
        sqlite3_finalize(statement);
        [self closeSqlite:sqlite];
    }
    return storeCount;
}

+ (NSMutableArray <HTUserStoreManager *> *)selectedStoreModelArrayWithType:(HTUserStoreType)type pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage {
    [self createSqliteTable];
    sqlite3 *sqlite;
    sqlite3_stmt *statement;
    
    NSInteger uid = [HTUserManager currentUser].uid.integerValue;
    NSString *selectedSqliteString = [NSString stringWithFormat:@"select * from %@ where uid = %ld and type = %ld order by %@ desc limit %ld offset %ld ", kHTUserStoryTableName, uid, type, @"createTime", pageSize.integerValue, (currentPage.integerValue - 1) * pageSize.integerValue];
    NSMutableArray *modelArray = [@[] mutableCopy];
    if ((sqlite = [self openSqlite])) {
        if (sqlite3_prepare_v2(sqlite, [selectedSqliteString UTF8String], - 1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                int ID = sqlite3_column_int(statement, 0);
                char *keyValueChar = (char *)sqlite3_column_text(statement, 5);
                NSString *keyValueString = [[NSString alloc] initWithUTF8String:keyValueChar];
                NSData *keyValueData = [keyValueString dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *keyValue = [NSJSONSerialization JSONObjectWithData:keyValueData options:NSJSONReadingMutableContainers error:nil];
                HTUserStoreModel *model = [HTUserStoreModel mj_objectWithKeyValues:keyValue];
                model.ID = ID;
                [modelArray addObject:model];
            }
        }
        sqlite3_finalize(statement);
        [self closeSqlite:sqlite];
    }
    return modelArray;
}



+ (NSString *)storeSqlitePath {
    NSString *diretionPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject];
    NSString *fileName = @"ht_user_log.sqlite";
    NSString *storePath = [diretionPath stringByAppendingPathComponent:fileName];
    return storePath;
}

+ (void)createSqliteTable {
    NSString *creatTableSqliteString = [NSString stringWithFormat:@"create table if not exists '%@'(id integer primary key autoincrement, uid integer, type integer, lookID integer, createTime integer, keyValue text)", kHTUserStoryTableName];
    [self execSqliteString:creatTableSqliteString];
}

+ (sqlite3 *)openSqlite {
    sqlite3 *sqlite;
    BOOL isOpen = sqlite3_open([[self storeSqlitePath] UTF8String], &sqlite) == SQLITE_OK;
    if (isOpen) {
        return sqlite;
    } else {
        return nil;
    }
}

+ (BOOL)execSqliteString:(NSString *)sqliteString {
    char *error;
    sqlite3 *sqlite;
    if ((sqlite = [self openSqlite])) {
        BOOL success = sqlite3_exec(sqlite, [sqliteString UTF8String], NULL, NULL, &error) == SQLITE_OK;
        [self closeSqlite:sqlite];
        return success;
    }
    return false;
}

+ (void)closeSqlite:(sqlite3 *)sqlite {
    sqlite3_close(sqlite);
}

@end
