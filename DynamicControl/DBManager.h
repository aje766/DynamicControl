//
//  DbHandler.h
//  
//
//  Created by Rajesh Vegad on 3/26/16.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject
{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;
-(BOOL)createDB;
-(BOOL) saveData:(NSString*)registerNumber name:(NSString*)name
      department:(NSString*)department year:(NSString*)year;
- (NSMutableArray*) findByBank:(NSString *)strBank state:(NSString *)strState city:(NSString *)strCity branch:(NSString *)strBranch OrIFSC:(NSString*)strIFSC;

- (NSMutableArray*) findByBank:(NSString *)strBank state:(NSString *)strState city:(NSString *)strCity branch:(NSString *)strBranch OrMICR:(NSString*)strMICR;



- (NSMutableArray*) findBankByBank:(NSString *)strBank state:(NSString *)strState city:(NSString *)strCity branch:(NSString *)strBranch OrIFSC:(NSString*)strIFSC;

- (NSMutableArray*) findStateByBank:(NSString *)strBank state:(NSString *)strState city:(NSString *)strCity branch:(NSString *)strBranch OrIFSC:(NSString*)strIFSC;

- (NSMutableArray*) findCityByBank:(NSString *)strBank state:(NSString *)strState city:(NSString *)strCity branch:(NSString *)strBranch OrIFSC:(NSString*)strIFSC;

- (NSMutableArray*) findBranchByBank:(NSString *)strBank state:(NSString *)strState city:(NSString *)strCity branch:(NSString *)strBranch OrIFSC:(NSString*)strIFSC;



+(NSData*)encodeDictionary:(NSDictionary*)dictionary;

@end
