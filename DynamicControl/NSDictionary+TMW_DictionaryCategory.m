//
//  NSDictionary+TMW_DictionaryCategory.m
//  themobilewallet
//
//  Created by Ajay on 29/03/16.
//  Copyright © 2016 TMW. All rights reserved.
//

#import "NSDictionary+TMW_DictionaryCategory.h"

@implementation NSDictionary (TMW_DictionaryCategory)

-(NSString*)customValueForKey:(NSString*)key
{
    NSString *value = ([self valueForKey:key] != nil)?((![[self valueForKey:key] isKindOfClass:[NSNull class]])?[self valueForKey:key]:@""):@"";
    return value;
}

@end
