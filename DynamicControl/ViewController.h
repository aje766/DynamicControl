//
//  ViewController.h
//  DynamicControl
//
//  Created by Ajay on 13/06/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Authenticator.h"
#import "DCTextField.h"//for custom textfield

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet TextFieldValidator *temp;
- (IBAction)testButton:(id)sender;

@end

