//
//  DBManager.m
//  light
//
//  Created by Eric Giannini on 5/7/17.
//  Copyright © 2017 Unicorn Mobile, LLC. All rights reserved.
//

#import "DBManager.h"

#import <sqlite3.h>

@interface DBManager ()

//extension of DBManager() with private class files
@property (nonatomic, strong) NSString *documentDirectory;
@property (nonatomic, strong) NSString *databaseFilename;

@end

@implementation DBManager

- (instancetype)initWithDatabaseFilename:(NSString *)dbFilename {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

@end

