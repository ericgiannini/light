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

/*
 
 private custom class for copying the SQLitedatabase into the documents directory
 
*/

-(void)copyDatabaseIntoDocumentsDirectory;

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

// The above method will be called every time that an object of the DBManager class is initialized

-(void)copyDatabaseIntoDocumentsDirectory {
    
    NSString *destinationPath = [self.documentDirectory stringByAppendingString:self.databaseFilename];
    
    // If the database file won’t be found in the documents directory, then the code in the condition block will be executed, otherwise it will be skipped.
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath  = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:self.databaseFilename];
        
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
    
        // Check if any error occurred during copying and display it
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        
    }
    
}


@end

