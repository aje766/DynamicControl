//
//  DCTextField.m
//  DynamicControl
//
//  Created by Ajay on 15/06/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

#import "DCTextField.h"

@implementation DCTextField
@synthesize isMenuAvailable, authenticatorObject, arrDropdownData, picker;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Default Methods of UIView
- (id)initWithFrame:(CGRect)frame forAuthenticator:(Authenticator*)authObject{
    self = [super initWithFrame:frame];
    if (self) {
        self.authenticatorObject = authObject;
        if ([authObject.FIELDSET_TYPE.uppercaseString isEqualToString:@"DROPDOWN"]) {
            picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 300)];
            arrDropdownData = [authObject.RegX componentsSeparatedByString:@"~"];
            self.inputView = picker;
            picker.delegate = self;
            picker.dataSource = self;
        }
    }
    return self;
}



- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (isMenuAvailable) {
        return YES;
    }
    else
    {
        return NO;
    }
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return arrDropdownData.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [arrDropdownData objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.text = [arrDropdownData objectAtIndex:row];
}




@end
