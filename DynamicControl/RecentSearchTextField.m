//
//  RecentSearchTextField.m
//  DynamicControl
//
//  Created by Ajay on 16/06/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

#import "RecentSearchTextField.h"




@implementation RecentSearchTextField
@synthesize arrHistoryText, strKEY, tblHint, arrHistoryTextSearched, presentInView;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setDelegate:(id)newDelegate{
    delegate = newDelegate;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    [self setup];
    self.text = @"vijay";
    [self saveTextForHistory];
    return self;
}

-(void)setup
{
    strKEY = @"TEXTID";
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    id temp = [userDefault objectForKey:strKEY];
    if(temp)
    {
        arrHistoryText = [NSKeyedUnarchiver unarchiveObjectWithData:temp];
    }
    if (!arrHistoryText) {
        arrHistoryText = [[NSMutableArray alloc] init];
    }
    
    tblHint = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 90)];
    tblHint.delegate = self;
    tblHint.dataSource = self;
//    tblHint.hidden = YES;
    
    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    
}

-(void)didMoveToSuperview
{
    CGRect showOnRect=[self convertRect:self.frame toView:presentInView];
    CGRect fieldFrame=[self.superview convertRect:self.frame toView:presentInView];
    
    //[presentInView addSubview:tblHint];
}



-(void)textFieldDidChange:(UITextField*)textfield
{
    arrHistoryTextSearched = [self searchForWalletTransactionWithText:textfield.text];
    
    [tblHint reloadData];
    if (arrHistoryTextSearched.count <= 0) {
        tblHint.hidden = YES;
    }
    else
    {
        tblHint.hidden = NO;
    }
//    [self.superview addSubview:tblHint];
    [delegate RecentSearchTextFieldChange:textfield forTableList:tblHint];
    
    
}


- (NSMutableArray*)searchForWalletTransactionWithText:(NSString *)searchText
{
    [self.arrHistoryTextSearched removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    
    return [[arrHistoryText filteredArrayUsingPredicate:predicate1] mutableCopy];
}



-(void)saveTextForHistory
{
    if ([arrHistoryText containsObject:self.text]) {
        return;
    }
    [arrHistoryText addObject:self.text];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrHistoryText];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:data forKey:strKEY];
    [userDefault synchronize];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrHistoryTextSearched.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    
    cell.textLabel.text = [arrHistoryTextSearched objectAtIndex:indexPath.row];
    
    return cell;
}






@end
