//
//  DCTextField.h
//  DynamicControl
//
//  Created by Ajay on 15/06/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

#import "TextFieldValidator.h"
#import "Authenticator.h"

@interface DCTextField : TextFieldValidator<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic,assign) BOOL isMenuAvailable;

@property (nonatomic) Authenticator *authenticatorObject;
@property (nonatomic) NSArray *arrDropdownData;
@property (nonatomic) UIPickerView *picker;

- (id)initWithFrame:(CGRect)frame forAuthenticator:(Authenticator*)authObject;

@end
