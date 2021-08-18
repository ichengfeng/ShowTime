//
//  MineViewController.m
//  Show
//
//  Created by chengfeng on 2019/5/27.
//  Copyright © 2019 Podinn. All rights reserved.
//

#import "CenterViewController.h"
#import "CenterItemController.h"
#import "CategoryListResponse.h"
#import "PagerCategoryView.h"

@interface CenterViewController ()<JXCategoryViewDelegate,JXPagerViewDelegate, JXPagerMainTableViewGestureDelegate>

@property (nonatomic, strong) UIView *headerView;

@property(nonatomic, strong) UIView *searchView;

@property(nonatomic, strong)PagerCategoryView *categoryMangerView;

@property (nonatomic, strong) JXPagerView *pagerView;
@property (nonatomic, strong) NSArray<CenterCategoryModel *> * _Nullable categoryArr;

@property (nonatomic, strong) NSArray <NSString *> *titles;

@property(nonatomic, assign)NSInteger selectIndex;

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectIndex = 0;
    
    self.headerView.hidden = NO;
    
    ///将pagerView的listContainerView和categoryView.listContainer进行关联，这样列表就可以和categoryView联动了。
    self.categoryMangerView.categoryTitleImageView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
    self.categoryMangerView.categoryTitleImageView.delegate = self;
    self.categoryMangerView.categoryOnlyTitleView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
    self.categoryMangerView.categoryOnlyTitleView.delegate = self;
   
    __weak typeof(self)weakSelf = self;
    weakSelf.pagerView.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf networkForGetCategoryList];
    }];
    
    [weakSelf.pagerView.mainTableView.mj_header beginRefreshing];
}

- (void)networkForGetCategoryList {
    
    NSString *url = [NSString stringWithFormat:@"%@/getCategoryList",BaseUrl];
    
    __weak typeof(self) weakSelf =  self;
    [[AFHTTPSessionManager manager]GET:url parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [weakSelf.pagerView.mainTableView.mj_header endRefreshing];
        CategoryListResponse *listModel = [CategoryListResponse mj_objectWithKeyValues:responseObject];
        if (listModel.data.count > 0) {
            
            CenterCategoryModel *firstCat = [[CenterCategoryModel alloc]init];
            firstCat.iconUrl = @"ic_lion";
            firstCat.categoryId = @(-1).stringValue;
            firstCat.categoryName = @"辛选推荐";
            [listModel.data insertObject:firstCat atIndex:0];
        }
        
        weakSelf.categoryArr = listModel.data;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.pagerView.mainTableView.mj_header endRefreshing];
        NSLog(@"获取数据失败");
    }];
}

- (void)setCategoryArr:(NSArray<CenterCategoryModel *> *)categoryArr {
    _categoryArr = categoryArr;

    NSMutableArray *titleArrs = [NSMutableArray new];
    NSMutableArray *imageArrs = [NSMutableArray new];
    [categoryArr enumerateObjectsUsingBlock:^(CenterCategoryModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titleArrs addObject:SafeStr(obj.categoryName)];
        NSURL *url = [NSURL URLWithString:SafeStr(obj.iconUrl)];
        [imageArrs addObject:url];
    }];
    self.titles = titleArrs;
    self.categoryMangerView.titles = self.titles;
    self.categoryMangerView.images = imageArrs;
    self.categoryMangerView.selectImages = imageArrs;
    [self.categoryMangerView reloadData];
    
    [self.pagerView reloadData];
    [self.categoryMangerView.categoryTitleImageView selectItemAtIndex: self.selectIndex];
}

- (UIView *)headerView {
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen.width, 112*adjustRatio + Screen.statusBarHeight)];
    }
    return _headerView;
}

- (UIView *)searchView {
    if (_searchView == nil) {
        _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, -64*adjustRatio, Screen.width, 112*adjustRatio + Screen.statusBarHeight)];
        [self.view addSubview:_searchView];
//        _searchView.topView.hidden = YES;
    }
    return _searchView;
}

- (JXPagerView *)pagerView {
    if (_pagerView == nil) {
        _pagerView = [[JXPagerView alloc] initWithDelegate:self];
        _pagerView.mainTableView.gestureDelegate = self;
        _pagerView.mainTableView.backgroundColor = [UIColor clearColor];
        if (Screen.safeAreaBottom > 0) {
            _pagerView.pinSectionHeaderVerticalOffset = 39*adjustRatio;
        }else {
            _pagerView.pinSectionHeaderVerticalOffset = 15*adjustRatio;
        }
        [self.view addSubview:_pagerView];
        [_pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.top.equalTo(self.view);
        }];
    }
    return _pagerView;
}

- (PagerCategoryView *)categoryMangerView {
    if (!_categoryMangerView) {
        _categoryMangerView = [[PagerCategoryView alloc]initWithFrame:CGRectMake(0, 0, Screen.width, 100*adjustRatio)];
    }
    return _categoryMangerView;
}

#pragma mark - JXPagerViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.headerView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return self.headerView.height;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryMangerView.height;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryMangerView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    //和categoryView的item数量一致
    return self.titles.count;
}


- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat topY = Screen.statusBarHeight+70*adjustRatio;

    CGFloat searchTopY = Screen.statusBarHeight + 20*adjustRatio;

    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < searchTopY) {
        CGFloat valueY = searchTopY - offsetY;
        if (valueY > 0) {
            self.headerView.alpha = valueY/searchTopY;
            self.searchView.hidden = YES;
//            self.headerView.alpha = 1;
            [self.categoryMangerView changeCategory:NO];
        }else {
            [self.categoryMangerView changeCategory:YES];
        }

    }else {
        self.headerView.alpha = 0;
        self.headerView.alpha = 0;
        self.searchView.hidden = NO;

        BOOL isTure = offsetY >= topY;
        [self.categoryMangerView changeCategory:isTure];

    }
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    CenterItemController *list = [[CenterItemController alloc] init];
    list.categoryModel = self.categoryArr[index];
    return list;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    [self.pagerView.listContainerView didClickSelectedItemAtIndex:index];
    self.selectIndex = index;
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
        
    if (categoryView == self.categoryMangerView.categoryTitleImageView) {
        if (self.categoryMangerView.categoryOnlyTitleView.hidden == YES) {
            [self.categoryMangerView.categoryOnlyTitleView selectItemAtIndex:index];
        }
    }
    
    if (categoryView == self.categoryMangerView.categoryOnlyTitleView) {
        if (self.categoryMangerView.categoryTitleImageView.hidden == YES) {
            [self.categoryMangerView.categoryTitleImageView selectItemAtIndex:index];
        }
    }
}

#pragma mark - JXPagerMainTableViewGestureDelegate

- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
    if (otherGestureRecognizer == self.categoryMangerView.categoryTitleImageView.collectionView.panGestureRecognizer) {
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
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
