//
//  SecondViewController.m
//  Test04
//
//  Created by HuHongbing on 9/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
@interface FirstViewController ()

@end

@implementation FirstViewController
@synthesize tableView = _tableView;
@synthesize headViewArray;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadModel];    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(-10, 0,340,460) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}


- (void)loadModel{
    _currentRow = -1;
    headViewArray = [[NSMutableArray alloc]init ];
    for(int i = 0;i< 5 ;i++)
	{
		HeadView* headview = [[HeadView alloc] init];
        headview.delegate = self;
		headview.section = i;
        [headview.backBtn setTitle:[NSString stringWithFormat:@"第%d组",i] forState:UIControlStateNormal];
		[self.headViewArray addObject:headview];
		[headview release];
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _tableView= nil;
}

#pragma mark - TableViewdelegate&&TableViewdataSource

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HeadView* headView = [self.headViewArray objectAtIndex:indexPath.section];
    
    return headView.open?45:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self.headViewArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    HeadView* headView = [self.headViewArray objectAtIndex:section];
    return headView.open?5:0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.headViewArray count];
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier] autorelease];
        UIButton* backBtn=  [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 340, 45)];
        backBtn.tag = 20000;
        [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_on"] forState:UIControlStateHighlighted];
        backBtn.userInteractionEnabled = NO;
        [cell.contentView addSubview:backBtn];
        [backBtn release];
        
        
        UIImageView* line = [[UIImageView alloc]initWithFrame:CGRectMake(0, 44, 340, 1)];
        line.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:line];
        [line release];
        
    }
    UIButton* backBtn = (UIButton*)[cell.contentView viewWithTag:20000];
    HeadView* view = [self.headViewArray objectAtIndex:indexPath.section];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_2_nomal"] forState:UIControlStateNormal];
    
    if (view.open) {
        if (indexPath.row == _currentRow) {
            [backBtn setBackgroundImage:[UIImage imageNamed:@"btn_nomal"] forState:UIControlStateNormal];
        }
    }
    
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d-%d",indexPath.section,indexPath.row];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _currentRow = indexPath.row;
    [_tableView reloadData];
}


#pragma mark - HeadViewdelegate
-(void)selectedWith:(HeadView *)view{
    _currentRow = -1;
    if (view.open) {
        for(int i = 0;i<[headViewArray count];i++)
        {
            HeadView *head = [headViewArray objectAtIndex:i];
            head.open = NO;
            [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
        }
        [_tableView reloadData];
        return;
    }
    _currentSection = view.section;
    [self reset];
    
}

//界面重置
- (void)reset
{
    for(int i = 0;i<[headViewArray count];i++)
    {
        HeadView *head = [headViewArray objectAtIndex:i];
        
        if(head.section == _currentSection)
        {
            head.open = YES;
            [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_nomal"] forState:UIControlStateNormal];
            
        }else {
            [head.backBtn setBackgroundImage:[UIImage imageNamed:@"btn_momal"] forState:UIControlStateNormal];
            
            head.open = NO;
        }
        
    }
    [_tableView reloadData];
}

- (void)dealloc{
    [_tableView release];
    [headViewArray release];
    [super dealloc];
}

@end
