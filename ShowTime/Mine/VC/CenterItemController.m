//
//  CenterItemController.m
//  ShowTime
//
//  Created by mac on 2021/8/18.
//

#import "CenterItemController.h"
#import "WaterfallFlowLayout.h"
#import "HomeContenListModel.h"
#import "GirlCardCell.h"

@interface CenterItemController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterfallFlowLayoutDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong)WaterfallFlowLayout *waterfallFlowLayout;

@property (nonatomic, assign) NSInteger pageNum;

@property(nonatomic, strong) NSMutableArray *listDataArr;

@end

@implementation CenterItemController

- (WaterfallFlowLayout *)waterfallFlowLayout{
    if (!_waterfallFlowLayout) {
        _waterfallFlowLayout = [[WaterfallFlowLayout alloc]init];
        _waterfallFlowLayout.delegate = self;
    }
    return _waterfallFlowLayout;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.waterfallFlowLayout];
        _collectionView.backgroundColor = [UIColor colorWithRed:244/255.0 green:245/255.0 blue:246/255.0 alpha:1.0];
        _collectionView.showsVerticalScrollIndicator = NO;   //是否显示滚动条
        _collectionView.scrollEnabled = YES;  //滚动使能
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        //3、添加到控制器的view
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view);
            make.left.mas_equalTo(0*adjustRatio);
            make.right.mas_equalTo(0*adjustRatio);
            make.top.mas_equalTo(0);
        }];
        
//        [_collectionView registerClass:[ProductHorizontalCell class]
//            forCellWithReuseIdentifier:@"ProductHorizontalCell"];
//        [_collectionView registerClass:[MarketingLeftCell class]
//            forCellWithReuseIdentifier:@"MarketingLeftCell"];
//        [_collectionView registerClass:[NormalBlockCell class]
//            forCellWithReuseIdentifier:@"NormalBlockCell"];
//        [_collectionView registerClass:[MiniBlockCell class]
//            forCellWithReuseIdentifier:@"MiniBlockCell"];
//        [_collectionView registerClass:[SmallBlockCell class]
//            forCellWithReuseIdentifier:@"SmallBlockCell"];
        
        [_collectionView registerClass:[GirlCardCell class] forCellWithReuseIdentifier:@"GirlCardCell"];
        
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1.0];
    
    self.listDataArr = [NSMutableArray new];
    
//    __weak typeof(self)weakSelf = self;
    [self fetchData:true];
//
//    weakSelf.collectionView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
//        [weakSelf fetchData:false];
//    }];
    
}

- (void)fetchData:(BOOL)isRefresh{
    if (isRefresh) {
        self.pageNum = 1;
        [self.listDataArr removeAllObjects];
        [self.collectionView reloadData];
    }else {
        self.pageNum += 1;
    }
    NSString *url = [NSString stringWithFormat:@"%@/getGoodsList",BaseUrl];
    
    __weak typeof(self) weakSelf =  self;
    [[AFHTTPSessionManager manager]GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.collectionView.mj_header endRefreshing];
        HomeContenListModel *listModel = [HomeContenListModel mj_objectWithKeyValues:responseObject];
        for (GoodsModel *model in listModel.data) {
            if (model.pictures > 0) {
                [self.listDataArr addObjectsFromArray:model.pictures];
            }
        }
        [weakSelf.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.collectionView.mj_header endRefreshing];
        NSLog(@"获取数据失败");
    }];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    GirlCardCell *cell = (GirlCardCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"GirlCardCell" forIndexPath:indexPath];
    cell.layer.shadowColor = [UIColor colorWithHexString:@"C7C6B6"].CGColor;
    cell.layer.shadowOffset = CGSizeMake(-2, -2);
    cell.layer.shadowRadius = 2;
    cell.layer.shadowOpacity = 0.8;
    if (indexPath.row < self.listDataArr.count) {
        PictureModel *model = self.listDataArr[indexPath.row];
        cell.index = indexPath.row;
        cell.model = model;
    }
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.listDataArr.count;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;   //返回section数
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    HomeIndexSingleModel *indexModel = self.listDataArr[indexPath.row];
//    if ([indexModel.type isEqualToString:@"item"]) {
//        ProductModel *model = indexModel.itemModel;
//        NSString *url = [NSString stringWithFormat:@"xinxuan://xincheng/productDetail?productId=%@",model.id];
//        [[Router shared] push:url];
//        [StatisticsManager addClick:self event:@"B210420090" paramters:@{@"xcm":model.xcm,@"positionIndex":STR_NUM(indexPath.row),@"shouyetab":STR_NUM([self.categoryModel.categoryId integerValue])} desc:@"点击首页商品卡片"];
//    }else {
//
//    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
}

#pragma mark -WaterfallFlowLayoutDelegate-
- (CGFloat)waterflowLayout:(WaterfallFlowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{
//    return self.listDataArr.count>0 ?roundf(300*adjustRatio):roundf(272*adjustRatio);
    
    CGFloat h = (Screen.width - 16*adjustRatio - 10*adjustRatio)/2.0*1.75;
    if (index % 2 == 0) {
        return  h;
    }else {
        if (index % 3 == 0) {
            return h + 20;
        }
        return h + 15;
    }
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterfallFlowLayout *)waterflowLayout {
    return UIEdgeInsetsMake(16*adjustRatio, 16*adjustRatio, 16*adjustRatio, 16*adjustRatio);
}

#pragma mark - JXPagingViewListViewDelegate

- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.collectionView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
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
