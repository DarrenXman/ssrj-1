//
//  FirstViewController.h
//  Test04
//
//  Created by HuHongbing on 9/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadView.h"
@interface FirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,HeadViewDelegate>{
    UITableView* _tableView;
    NSInteger _currentSection;
    NSInteger _currentRow;
    
}
@property(nonatomic, retain) NSMutableArray* headViewArray;
@property(nonatomic, retain) UITableView* tableView;
@end
