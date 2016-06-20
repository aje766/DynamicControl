//
//  DbHandler.m
//  
//
//  Created by Rajesh Vegad on 3/26/16.
//
//




#import "DBManager.h"
static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

+(DBManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;
}

-(BOOL)createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:
                    [docsDir stringByAppendingPathComponent: @"db_bank.db"]];
    BOOL isSuccess = YES;
    
    NSString* source=[[NSBundle mainBundle] pathForResource:@"db_bank" ofType:@"db"];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        
        [filemgr copyItemAtPath:source toPath:databasePath error:nil];
        const char *dbpath = [databasePath UTF8String];
//        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
//        {
//            char *errMsg;
//            const char *sql_stmt = "create table if not exists tblbank (bid integer primary key, BANK TEXT, IFSC TEXT, MICRCODE TEXT, BRANCH TEXT, ADDRESS TEXT, CONTACT TEXT, CITY TEXT, DISTRICT TEXT, STATE TEXT, Version TEXT)";
//            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg)
//                != SQLITE_OK)
//            {
//                isSuccess = NO;
//                NSLog(@"Failed to create table");
//            }
//            sqlite3_close(database);
//            return  isSuccess;
//        }
//        else {
//            isSuccess = NO;
//            NSLog(@"Failed to open/create database");
//        }
    }
    return isSuccess;
}


- (NSMutableArray*) findByBank:(NSString *)strBank state:(NSString *)strState city:(NSString *)strCity branch:(NSString *)strBranch OrMICR:(NSString*)strMICR
{
    
    NSString *queryKey = @"";
    
    if (![strBank isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND BANK LIKE '%@%%'",strBank];
    }
    
    if (![strState isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND STATE LIKE '%@%%'",strState];
    }
    
    if (![strCity isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND CITY LIKE '%@%%'",strCity];
    }
    
    if (![strBranch isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND BRANCH LIKE '%@%%'",strBranch];
    }
    
    if (![strMICR isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND MICRCODE LIKE '%@%%'",strMICR];
    }
    
    
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *strFinalQuery = queryKey;
        
        NSString *querySQL = [NSString stringWithFormat: @"select bid, BANK, IFSC, MICRCODE, BRANCH, ADDRESS, CONTACT, CITY, DISTRICT, STATE, Version from tblbank where 1=1 %@", strFinalQuery];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultMainArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //if (sqlite3_step(statement) == SQLITE_ROW){
                
                NSMutableArray *resultArray = [[NSMutableArray alloc]init];
                NSNumber* bid = [[NSNumber alloc] initWithInt: sqlite3_column_int(statement, 0)];
                
                [resultArray addObject:bid];
                NSString *BANK = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:BANK];
                NSString *IFSC = [[NSString alloc]initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 2)];
                [resultArray addObject:IFSC];
                
                NSString *MICRCODE = [[NSString alloc]initWithUTF8String:
                                      (const char *) sqlite3_column_text(statement, 3)];
                [resultArray addObject:MICRCODE];
                
                NSString *BRANCH = [[NSString alloc]initWithUTF8String:
                                    (const char *) sqlite3_column_text(statement, 4)];
                [resultArray addObject:BRANCH];
                
                NSString *ADDRESS = [[NSString alloc]initWithUTF8String:
                                     (const char *) sqlite3_column_text(statement, 5)];
                [resultArray addObject:ADDRESS];
                
                NSString *CONTACT = [[NSString alloc]initWithUTF8String:
                                     (const char *) sqlite3_column_text(statement, 6)];
                [resultArray addObject:CONTACT];
                
                NSString *CITY = [[NSString alloc]initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 7)];
                [resultArray addObject:CITY];
                
                NSString *DISTRICT = [[NSString alloc]initWithUTF8String:
                                      (const char *) sqlite3_column_text(statement, 8)];
                [resultArray addObject:DISTRICT];
                
                NSString *STATE = [[NSString alloc]initWithUTF8String:
                                   (const char *) sqlite3_column_text(statement, 9)];
                [resultArray addObject:STATE];
                
                NSString *Version = [[NSString alloc]initWithUTF8String:
                                     (const char *) sqlite3_column_text(statement, 10)];
                [resultArray addObject:Version];
                
                [resultMainArray addObject:resultArray];
                
            }
            
            NSLog(@"%s", sqlite3_errmsg(database));
            sqlite3_reset(statement);
        }
        
        
        return resultMainArray;
    }
    return nil;
}
                                
- (NSMutableArray*) findByBank:(NSString *)strBank state:(NSString *)strState city:(NSString *)strCity branch:(NSString *)strBranch OrIFSC:(NSString*)strIFSC
{

    NSString *queryKey = @"";
    
    if (![strBank isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND BANK LIKE '%@%%'",strBank];
    }
    
    if (![strState isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND STATE LIKE '%@%%'",strState];
    }
    
    if (![strCity isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND CITY LIKE '%@%%'",strCity];
    }
    
    if (![strBranch isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND BRANCH LIKE '%@%%'",strBranch];
    }
    
    if (![strIFSC isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND IFSC LIKE '%@%%'",strIFSC];
    }
    
    
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *strFinalQuery = queryKey;
        
        NSString *querySQL = [NSString stringWithFormat: @"select bid, BANK, IFSC, MICRCODE, BRANCH, ADDRESS, CONTACT, CITY, DISTRICT, STATE, Version from tblbank where 1=1 %@", strFinalQuery];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultMainArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW) {
            //if (sqlite3_step(statement) == SQLITE_ROW){
                
                NSMutableArray *resultArray = [[NSMutableArray alloc]init];
                NSNumber* bid = [[NSNumber alloc] initWithInt: sqlite3_column_int(statement, 0)];
                
                [resultArray addObject:bid];
                NSString *BANK = [[NSString alloc] initWithUTF8String:
                                        (const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:BANK];
                NSString *IFSC = [[NSString alloc]initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 2)];
                [resultArray addObject:IFSC];
                
                NSString *MICRCODE = [[NSString alloc]initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 3)];
                [resultArray addObject:MICRCODE];
                
                NSString *BRANCH = [[NSString alloc]initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 4)];
                [resultArray addObject:BRANCH];
                
                NSString *ADDRESS = [[NSString alloc]initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 5)];
                [resultArray addObject:ADDRESS];
                
                NSString *CONTACT = [[NSString alloc]initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 6)];
                [resultArray addObject:CONTACT];
                
                NSString *CITY = [[NSString alloc]initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 7)];
                [resultArray addObject:CITY];
                
                NSString *DISTRICT = [[NSString alloc]initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 8)];
                [resultArray addObject:DISTRICT];
                
                NSString *STATE = [[NSString alloc]initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 9)];
                [resultArray addObject:STATE];
                
                NSString *Version = [[NSString alloc]initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 10)];
                [resultArray addObject:Version];
                
                [resultMainArray addObject:resultArray];

            }
            
            NSLog(@"%s", sqlite3_errmsg(database));
            sqlite3_reset(statement);
        }
        
        
        return resultMainArray;
    }
    return nil;
}


- (NSMutableArray*) findBankByBank:(NSString *)strBank state:(NSString *)strState city:(NSString *)strCity branch:(NSString *)strBranch OrIFSC:(NSString*)strIFSC
{
    
    NSString *queryKey = @"";
    
    if (![strBank isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND BANK LIKE '%@%%'",strBank];
    }
    
    if (![strState isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND STATE LIKE '%@%%'",strState];
    }
    
    if (![strCity isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND CITY LIKE '%@%%'",strCity];
    }
    
    if (![strBranch isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND BRANCH LIKE '%@%%'",strBranch];
    }
    
    if (![strIFSC isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND IFSC LIKE '%@%%'",strIFSC];
    }
    
    
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *strFinalQuery = queryKey;
        
        NSString *querySQL = [NSString stringWithFormat: @"select DISTINCT BANK from tblbank where 1=1 %@", strFinalQuery];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultMainArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //if (sqlite3_step(statement) == SQLITE_ROW){
                
                NSMutableArray *resultArray = [[NSMutableArray alloc]init];
                
                
                NSString *BANK = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:BANK];
                
                
                [resultMainArray addObject:resultArray];
                
            }
            
            NSLog(@"%s", sqlite3_errmsg(database));
            sqlite3_reset(statement);
        }
        
        
        return resultMainArray;
    }
    return nil;
}


- (NSMutableArray*) findStateByBank:(NSString *)strBank state:(NSString *)strState city:(NSString *)strCity branch:(NSString *)strBranch OrIFSC:(NSString*)strIFSC
{
    
    NSString *queryKey = @"";
    
    if (![strBank isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND BANK LIKE '%@%%'",strBank];
    }
    
    if (![strState isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND STATE LIKE '%@%%'",strState];
    }
    
    if (![strCity isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND CITY LIKE '%@%%'",strCity];
    }
    
    if (![strBranch isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND BRANCH LIKE '%@%%'",strBranch];
    }
    
    if (![strIFSC isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND IFSC LIKE '%@%%'",strIFSC];
    }
    
    
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *strFinalQuery = queryKey;
        
        NSString *querySQL = [NSString stringWithFormat: @"select DISTINCT STATE from tblbank where 1=1 %@", strFinalQuery];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultMainArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //if (sqlite3_step(statement) == SQLITE_ROW){
                
                NSMutableArray *resultArray = [[NSMutableArray alloc]init];
                
                
                NSString *BANK = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:BANK];
                
                
                [resultMainArray addObject:resultArray];
                
            }
            
            NSLog(@"%s", sqlite3_errmsg(database));
            sqlite3_reset(statement);
        }
        
        
        return resultMainArray;
    }
    return nil;
}


- (NSMutableArray*) findCityByBank:(NSString *)strBank state:(NSString *)strState city:(NSString *)strCity branch:(NSString *)strBranch OrIFSC:(NSString*)strIFSC
{
    
    NSString *queryKey = @"";
    
    if (![strBank isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND BANK LIKE '%@%%'",strBank];
    }
    
    if (![strState isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND STATE LIKE '%@%%'",strState];
    }
    
    if (![strCity isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND CITY LIKE '%@%%'",strCity];
    }
    
    if (![strBranch isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND BRANCH LIKE '%@%%'",strBranch];
    }
    
    if (![strIFSC isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND IFSC LIKE '%@%%'",strIFSC];
    }
    
    
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *strFinalQuery = queryKey;
        
        NSString *querySQL = [NSString stringWithFormat: @"select DISTINCT CITY from tblbank where 1=1 %@", strFinalQuery];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultMainArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //if (sqlite3_step(statement) == SQLITE_ROW){
                
                NSMutableArray *resultArray = [[NSMutableArray alloc]init];
                
                
                NSString *BANK = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:BANK];
                
                
                [resultMainArray addObject:resultArray];
                
            }
            
            NSLog(@"%s", sqlite3_errmsg(database));
            sqlite3_reset(statement);
        }
        
        
        return resultMainArray;
    }
    return nil;
}


- (NSMutableArray*) findBranchByBank:(NSString *)strBank state:(NSString *)strState city:(NSString *)strCity branch:(NSString *)strBranch OrIFSC:(NSString*)strIFSC
{
    
    NSString *queryKey = @"";
    
    if (![strBank isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND BANK LIKE '%@%%'",strBank];
    }
    
    if (![strState isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND STATE LIKE '%@%%'",strState];
    }
    
    if (![strCity isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND CITY LIKE '%@%%'",strCity];
    }
    
    if (![strBranch isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND BRANCH LIKE '%@%%'",strBranch];
    }
    
    if (![strIFSC isEqualToString:@""]) {
        queryKey = [queryKey stringByAppendingFormat:@" AND IFSC LIKE '%@%%'",strIFSC];
    }
    
    
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        NSString *strFinalQuery = queryKey;
        
        NSString *querySQL = [NSString stringWithFormat: @"select DISTINCT BRANCH from tblbank where 1=1 %@", strFinalQuery];
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultMainArray = [[NSMutableArray alloc]init];
        if (sqlite3_prepare_v2(database,
                               query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //if (sqlite3_step(statement) == SQLITE_ROW){
                
                NSMutableArray *resultArray = [[NSMutableArray alloc]init];
                
                
                NSString *BANK = [[NSString alloc] initWithUTF8String:
                                  (const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:BANK];
                
                
                [resultMainArray addObject:resultArray];
                
            }
            
            NSLog(@"%s", sqlite3_errmsg(database));
            sqlite3_reset(statement);
        }
        
        
        return resultMainArray;
    }
    return nil;
}






- (BOOL) saveData:(NSArray*)registerNumber
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK)
    {
        
//        /CREATE TABLE "tblbank" (
//                                 `bid`	INTEGER PRIMARY KEY AUTOINCREMENT,
//                                 `BANK`	TEXT,
//                                 `IFSC`	TEXT,
//                                 `MICRCODE`	TEXT,
//                                 `BRANCH`	TEXT,
//                                 `ADDRESS`	TEXT,
//                                 `CONTACT`	TEXT,
//                                 `CITY`	TEXT,
//                                 `DISTRICT`	TEXT,
//                                 `STATE`	TEXT,
//                                 `Version`	INTEGER
//                                 )
        
        NSString *strFinalInsertSQL = @"";
        for (int i = 0; i < registerNumber.count; i++) {
            
            NSString *insertSQL = [NSString stringWithFormat:@"insert into tblbank (BANK, IFSC, MICRCODE, BRANCH, ADDRESS, CONTACT, CITY, DISTRICT, STATE, Version) values (\"%@\",\"%@\",\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\"); ", ];
            
            strFinalInsertSQL = [strFinalInsertSQL stringByAppendingString:insertSQL];
        }
        
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        }
        else {
            return NO;
        }
        sqlite3_reset(statement);
    }
    return NO;
}


+(NSData*)encodeDictionary:(NSDictionary*)dictionary {
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}
@end
