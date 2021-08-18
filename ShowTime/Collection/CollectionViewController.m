//
//  CBThirdViewController.m
//  CodeBook
//
//  Created by Podinn on 2019/5/27.
//  Copyright © 2019 Podinn. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionCell.h"
#import "PictureCell.h"
#import "UserListModel.h"
#import "BigPictureViewController.h"

@interface CollectionViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *mainTableView;

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSMutableArray *heightArr;

@property(nonatomic,strong)UserListModel *listModel;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"列表";
    self.navBar.backBtn.hidden = YES;
    
    self.dataArray = [NSMutableArray array];
    self.heightArr = [NSMutableArray array];
            
    MJWeakSelf
    self.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf networkForGetUserList];
        
        [weakSelf getHeightForContentList];
        
    }];
    
    [self.mainTableView.mj_header beginRefreshing];
}

- (void)networkForGetUserList {
    
    NSString *url = [NSString stringWithFormat:@"%@/getUserList",BaseUrl];
    
    __weak typeof(self) weakSelf =  self;
    [[AFHTTPSessionManager manager]GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.mainTableView.mj_header endRefreshing];
        weakSelf.listModel = [UserListModel mj_objectWithKeyValues:responseObject];
        [weakSelf.mainTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.mainTableView.mj_header endRefreshing];
        NSLog(@"获取数据失败");
    }];
}

- (void)getHeightForContentList {
    NSArray *indexs = @[@"1",@"2",@"3",@"8",@"9",@"10",@"11"];
    for (int i = 0; i < indexs.count; i++) {
        NSString *imageName = [NSString stringWithFormat:@"IMG_MIMI_%@.jpg",indexs[i]];
        UIImage *image = [UIImage imageNamed:imageName];
        [self.dataArray addObject:imageName];
        CGFloat height = (Screen.width - 40)*(image.size.height/image.size.width);
        [self.heightArr addObject:@(height)];
    }
    [self.mainTableView reloadData];
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTableView.backgroundColor = UIColor.whiteColor;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_mainTableView];
        [_mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navBar.mas_bottom);
            make.left.right.equalTo(self.view);
            make.bottom.mas_equalTo(0);
        }];
    }
    return _mainTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  section == 0 ? (self.listModel ? self.listModel.data.count : 0) : self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 64*adjustRatio + 2*16*adjustRatio;
    }
    return [self.heightArr[indexPath.row] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellId = @"CollectionCell";
        CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[CollectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.listModel.data.count > indexPath.row) {
            cell.model = self.listModel.data[indexPath.row];
        }
        return cell;
    }else {
        static NSString *cellId = @"PictureCell";
        PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[PictureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (self.dataArray.count > indexPath.row) {
            cell.imgName = self.dataArray[indexPath.row];
        }
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (self.listModel.data.count > indexPath.row) {
//        UserModel *model = self.listModel.data[indexPath.row];
//        BigPictureViewController *bigPicVC = [[BigPictureViewController alloc]init];
//        bigPicVC.imageUrl = model.user_icon;
//        bigPicVC.hidesBottomBarWhenPushed = YES;
//        [[UIViewController topMost] presentViewController:bigPicVC animated:YES completion:nil];
//    }
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
