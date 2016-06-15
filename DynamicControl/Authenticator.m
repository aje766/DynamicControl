//
//  Authenticator.m
//  DynamicControl
//
//  Created by Ajay on 15/06/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

#import "Authenticator.h"

@implementation Authenticator

//initialize object with dictionary
-(id)init:(NSDictionary *)dictData
{
    
    self = [super init];
    if (self) {
        
        self.AuthenticatorLabel = [dictData customValueForKey:@"AuthenticatorLabel"];
        self.AuthenticatorMessage = [dictData customValueForKey:@"AuthenticatorMessage"];
        self.FIELDSET_DATATYPE = [dictData customValueForKey:@"FIELDSET_DATATYPE"];
        self.FIELDSET_LENGTH = [dictData customValueForKey:@"FIELDSET_LENGTH"];
        self.FIELDSET_MIN_LENGTH = [dictData customValueForKey:@"FIELDSET_MIN_LENGTH"];
        self.FIELDSET_TYPE = [dictData customValueForKey:@"FIELDSET_TYPE"];
        self.ISMANDETORY = [dictData customValueForKey:@"ISMANDETORY"];
        self.ORDER = [dictData customValueForKey:@"ORDER"];
        self.ProviderId = [dictData customValueForKey:@"ProviderId"];
        self.RegX = [dictData customValueForKey:@"RegX"];
        self.VALIDATION_NAME = [dictData customValueForKey:@"VALIDATION_NAME"];
        
    }
    return self;
}



@end
