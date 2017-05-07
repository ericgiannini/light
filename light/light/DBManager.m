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

/* 
 
 There is no sense in accessing the database directly; these 
 properties facilate access to a copy.
 
*/
@property (nonatomic, strong) NSString *documentDirectory;

@property (nonatomic, strong) NSString *databaseFilename;

@end

@implementation DBManager

- (instancetype)initWithDatabaseFilename:(NSString *)dbFilename {
    self = [super init];
    if (self) {
        
        // Set the documents directoy path to the documentsDirectory property.
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentDirectory = [paths objectAtIndex:0];
        
        // assign global variable for filepath to its local counterpart
        self.databaseFilename = dbFilename;
        
        // Copy the database file into the documents directory if necessary
        [self copyDatabaseIntoDocumentsDirectory];
        
        
        
    }
    
    return self;
}

@end

