//
//  HTUserHistoryManager.m
//  School
//
//  Created by hublot on 2017/8/31.
//  Copyright © 2017年 hublot. All rights reserved.
//

#import "HTUserHistoryManager.h"
#import "HTUserManager.h"
#import <sqlite3.h>

@implementation HTUserHistoryManager

static NSString *kHTUserHistoryTableName = @"history";

+ (void)appendHistoryModel:(HTUserHistoryModel *)model {
	[self crateSqliteTable];
	
    NSInteger uid = [HTUserManager currentUser].uid.integerValue;
    
	NSString *deleteSqliteString = [NSString stringWithFormat:@"delete from %@ where type = %ld and lookID = %ld and uid = %ld", kHTUserHistoryTableName, model.type, model.lookId.integerValue, uid];
	[self execSqliteString:deleteSqliteString];
	
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
	NSString *execSqliteString = [NSString stringWithFormat:@"insert into '%@' ('%@', '%@', '%@', '%@', '%@') values ('%ld', '%ld', '%ld', '%ld', '%@')", kHTUserHistoryTableName, @"uid", @"type", @"lookID", @"createTime", @"keyValue", uid, type, model.lookId.integerValue, createTime, keyValueString];
	[self execSqliteString:execSqliteString];
	
}

+ (NSMutableArray <HTUserHistoryModel *> *)selectedHistoryModelArrayWithType:(HTUserHistoryType)type pageSize:(NSString *)pageSize currentPage:(NSString *)currentPage {
	[self crateSqliteTable];
	sqlite3 *sqlite;
	sqlite3_stmt *statement;
    
    NSInteger uid = [HTUserManager currentUser].uid.integerValue;
	NSString *selectedSqliteString = [NSString stringWithFormat:@"select * from %@ where uid = %ld and type = %ld order by %@ desc limit %ld offset %ld ", kHTUserHistoryTableName, uid, type, @"createTime", pageSize.integerValue, (currentPage.integerValue - 1) * pageSize.integerValue];
	NSMutableArray *modelArray = [@[] mutableCopy];
	if ((sqlite = [self openSqlite])) {
		if (sqlite3_prepare_v2(sqlite, [selectedSqliteString UTF8String], - 1, &statement, nil) == SQLITE_OK) {
			while (sqlite3_step(statement) == SQLITE_ROW) {
				int ID = sqlite3_column_int(statement, 0);
				char *keyValueChar = (char *)sqlite3_column_text(statement, 5);
				NSString *keyValueString = [[NSString alloc] initWithUTF8String:keyValueChar];
				NSData *keyValueData = [keyValueString dataUsingEncoding:NSUTF8StringEncoding];
                NSDictionary *keyValue = [NSJSONSerialization JSONObjectWithData:keyValueData options:NSJSONReadingMutableContainers error:nil];
				HTUserHistoryModel *model = [HTUserHistoryModel mj_objectWithKeyValues:keyValue];
				model.ID = ID;
				[modelArray addObject:model];
			}
		}
		sqlite3_finalize(statement);
		[self closeSqlite:sqlite];
	}
	return modelArray;
}

+ (void)deleteHistoryModel:(HTUserHistoryModel *)model {
	[self crateSqliteTable];
    NSInteger uid = [HTUserManager currentUser].uid.integerValue;
	NSString *execSqliteString = [NSString stringWithFormat:@"delete from %@ where %@ = %ld and %@ = %ld", kHTUserHistoryTableName, @"id", model.ID, @"uid", uid];
	[self execSqliteString:execSqliteString];
}

+ (void)deleteAllHistoryModel {
	[self crateSqliteTable];
    NSInteger uid = [HTUserManager currentUser].uid.integerValue;
	NSString *execSqliteString = [NSString stringWithFormat:@"delete from '%@' where %@ = %ld", kHTUserHistoryTableName, @"uid", uid];
	[self execSqliteString:execSqliteString];
}

+ (NSString *)historySqlitePath {
	NSString *diretionPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true) lastObject];
	NSString *fileName = @"ht_user_log.sqlite";
	NSString *historyPath = [diretionPath stringByAppendingPathComponent:fileName];
	return historyPath;
}

+ (void)crateSqliteTable {
	NSString *creatTableSqliteString = [NSString stringWithFormat:@"create table if not exists '%@'(id integer primary key autoincrement, uid integer, type integer, lookID integer, createTime integer, keyValue text)", kHTUserHistoryTableName];
	[self execSqliteString:creatTableSqliteString];
}

+ (sqlite3 *)openSqlite {
	sqlite3 *sqlite;
	BOOL isOpen = sqlite3_open([[self historySqlitePath] UTF8String], &sqlite) == SQLITE_OK;
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
