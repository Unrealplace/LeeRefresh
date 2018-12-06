//
//  refreshVC.m
//  LeeRefreshDemo
//
//  Created by LiYang on 17/2/5.
//  Copyright © 2017年 LiYang. All rights reserved.
//

#import "refreshVC.h"
#import "LeeCommonHeader.h"
#import "LeeRefresh.h"

@interface refreshVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong )UITableView * tableView;
@property (nonatomic ,strong )NSMutableArray     * dataSource;
@property (nonatomic ,strong)UIButton *btn;
@end

@implementation refreshVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LeeColorWhite;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    LeeAddView(self.view, self.tableView);
    
    _dataSource = @[@"oliver",@"lee",@"oliver",@"oliver",@"oliver",@"oliver",@"oliver",@"oliver",@"oliver",@"oliver",@"oliver",@"oliver",@"oliver",@"oliver",@"oliver"].mutableCopy;
    
    [self setupHeader];
    [self setupFooter];
    
}

- (void)setupHeader
{

    [self.tableView addRefreshHeaderWithAutoFresh:YES WithTarget:self andAction:@selector(refresh)];

}

- (void)setupFooter
{
    [self.tableView addRefreshFooterWithAutoFresh:NO WithTarget:self andAction:@selector(upLoad)];
    
}


-(void)upLoad{

    NSLog(@"开始上啦加载更多了");
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        [self.tableView footerEndRefreshing];
        [self.dataSource addObject:@"test name"];
        [self.tableView reloadData];
        
    });
    
}
-(void)refresh{
    
    NSLog(@"开始执行刷新数据了");
    [self downLoadData];
}


-(void)downLoadData{
    
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        
        [self.tableView headerEndRefreshing];
        [self.dataSource addObject:@"test name"];
        [self.tableView reloadData];
        
    });
    
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:LeeRectFlatMake(0, 64, self.view.bounds.size.width , self.view.bounds.size.height - 64) style:UITableViewStyleGrouped];
        
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        _tableView.backgroundColor = LeeColorWhite;
        
    }
    
    return _tableView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellid = @"cellid";
    
    UITableViewCell * cell   = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}




@end
