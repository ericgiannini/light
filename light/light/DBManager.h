//
//  DBManager.h
//  light
//
//  Created by Eric Giannini on 5/7/17.
//  Copyright © 2017 Unicorn Mobile, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;

@property (nonatomic, strong) NSMutableArray *arrColumnNames;

@property (nonatomic) int affectedRows;

@property (nonatomic) long long lastInsertedRowID;

@end
