//
//  Authenticator.h
//  DynamicControl
//
//  Created by Ajay on 15/06/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+TMW_DictionaryCategory.h"

@interface Authenticator : NSObject


@property (nonatomic) NSString * AuthenticatorLabel;
@property (nonatomic) NSString * AuthenticatorMessage;
@property (nonatomic) NSString * FIELDSET_DATATYPE;
@property (nonatomic) NSString * FIELDSET_LENGTH;
@property (nonatomic) NSString * FIELDSET_MIN_LENGTH;
@property (nonatomic) NSString * FIELDSET_TYPE;
@property (nonatomic) NSString * ISMANDETORY;
@property (nonatomic) NSString * ORDER;
@property (nonatomic) NSString * ProviderId;
@property (nonatomic) NSString * RegX;
@property (nonatomic) NSString * VALIDATION_NAME;


-(id)init:(NSDictionary *)dictData;



@end
