//
//  CBFirstViewController.m
//  CodeBook
//
//  Created by Podinn on 2019/5/27.
//  Copyright © 2019 Podinn. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeListCell.h"
#import "HomeSectionHeadView.h"
#import "HomeContenListModel.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView *mainTableView;

@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navTitle = @"推荐";
    self.navBar.backBtn.hidden = YES;
    self.dataArray = [NSMutableArray new];
    
    MJWeakSelf
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArray removeAllObjects];
        [weakSelf networkForGetMainContent];
    }];
    
    [self.mainTableView.mj_header beginRefreshing];
    
}

#pragma mark -------- lazy load ---------
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;
        _mainTableView.tableFooterView = UIView.new;
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.estimatedRowHeight = 122*adjustRatio;
        [self.view addSubview:_mainTableView];
        [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navBar.mas_bottom);
            make.left.right.equalTo(self.view);
            make.bottom.mas_equalTo(0);
        }];
        
        _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//
    }
    return _mainTableView;
}

#pragma mark - UICollectionViewDataSource and Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataArray[section] pictures].count > 0) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 64*adjustRatio;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen.width, CGFLOAT_MIN)];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    GoodsModel *model = self.dataArray[section];
    
    if (model.item_name.length > 0) {
        HomeSectionHeadView *sectionView = [[HomeSectionHeadView alloc]initWithFrame:CGRectMake(0, 0, Screen.width, 64*adjustRatio)];
        sectionView.titleLabel.text = model.item_name;

        return sectionView;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
            
    static NSString *cellId = @"HomeListCell";
    HomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[HomeListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (indexPath.section < self.dataArray.count) {
        GoodsModel *model = self.dataArray[indexPath.section];
        cell.itemModel = model;
    }
    return cell;
    
}

#pragma mark - Request -
#pragma mark - 获取首页数据 -
- (void)networkForGetMainContent {
    NSString *url = [NSString stringWithFormat:@"%@/getGoodsList",BaseUrl];
    
    __weak typeof(self) weakSelf =  self;
    [[AFHTTPSessionManager manager]GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.mainTableView.mj_header endRefreshing];
        HomeContenListModel *model = [HomeContenListModel mj_objectWithKeyValues:responseObject];
        [self.dataArray addObjectsFromArray:model.data];
        [weakSelf.mainTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.mainTableView.mj_header endRefreshing];
        NSLog(@"获取数据失败");
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
