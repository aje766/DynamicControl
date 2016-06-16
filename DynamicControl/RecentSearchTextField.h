//
//  RecentSearchTextField.h
//  DynamicControl
//
//  Created by Ajay on 16/06/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RecentSearchTextFieldDelegate //<NSObject>

@optional
-(void)RecentSearchTextFieldChange:(UITextField*)textfield forTableList:(UITableView*)hintView;

@end

@interface RecentSearchTextField : UITextField <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    id  delegate;
}

@property (nonatomic) NSString* strKEY;
@property (nonatomic) NSMutableArray* arrHistoryText;
@property (nonatomic) NSMutableArray* arrHistoryTextSearched;
@property (nonatomic) UITableView* tblHint;

@property (nonatomic,retain) IBOutlet UIView *presentInView;

- (void) setDelegate:(id)newDelegate;

@end
