//
//  MineViewController.m
//  Show
//
//  Created by chengfeng on 2019/5/27.
//  Copyright © 2019 Podinn. All rights reserved.
//

#import "MineViewController.h"
#import "PictureCell.h"

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *mainTableView;

@property(nonatomic,strong)NSArray *heightArr;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navTitle = @"我的";
    self.navBar.backBtn.hidden = YES;
    
    self.heightArr = [self getHeightForContentList];
    [self.mainTableView reloadData];
}

- (NSArray *)getHeightForContentList {
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0; i < 11; i++) {
        NSString *imageName = [NSString stringWithFormat:@"IMG_MIMI_%d.jpg",i+1];
        UIImage *image = [UIImage imageNamed:imageName];
        CGFloat height = (Screen.width - 40)*(image.size.height/image.size.width);
        [tempArr addObject:@(height)];
    }
    return tempArr;
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
            make.edges.mas_equalTo(0);
        }];
    }
    return _mainTableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.heightArr[indexPath.row] floatValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"PictureCell";
    PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[PictureCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *imageName = [NSString stringWithFormat:@"IMG_MIMI_%ld.jpg",indexPath.row+1];
    cell.imgName = imageName;
    return cell;
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
