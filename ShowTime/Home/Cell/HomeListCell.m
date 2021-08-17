//
//  HomeListCell.m
//  ShowTime
//
//  Created by mac on 2021/8/16.
//

#import "HomeListCell.h"
#import "GirlCardCell.h"

@interface HomeListCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView *mainCollection;

@end

@implementation HomeListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.mainCollection.hidden = NO;
        
    }
    return self;
}

- (void)setItemModel:(GoodsModel *)itemModel {
    
    _itemModel = itemModel;
    
    [self.mainCollection reloadData];
       
}

- (UICollectionView *)mainCollection {
    if (!_mainCollection) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing = 10*adjustRatio;  //行间距
//        flowLayout.minimumInteritemSpacing = 10*adjustRatio; //列间距
        flowLayout.itemSize = CGSizeMake(90*adjustRatio, 90*1.75*adjustRatio); //固定的itemsize
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _mainCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Screen.width, 90*adjustRatio) collectionViewLayout:flowLayout];
        [_mainCollection registerClass:[GirlCardCell class] forCellWithReuseIdentifier:@"GirlCardCell"];
        _mainCollection.delegate = self;
        _mainCollection.dataSource = self;
        _mainCollection.backgroundColor = [UIColor clearColor];
        _mainCollection.showsHorizontalScrollIndicator = NO;
        _mainCollection.contentInset = UIEdgeInsetsMake(0, 16*adjustRatio, 0, 16*adjustRatio);
        [self.contentView addSubview:_mainCollection];
        [_mainCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
            make.height.mas_equalTo(90*1.75*adjustRatio).priorityHigh();
        }];
    }
    return _mainCollection;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    GirlCardCell *cell = (GirlCardCell *)[self.mainCollection dequeueReusableCellWithReuseIdentifier:@"GirlCardCell" forIndexPath:indexPath];
    if (indexPath.row < self.itemModel.pictures.count) {
        PictureModel *model = self.itemModel.pictures[indexPath.row];
        cell.index = indexPath.row;
        cell.model = model;
    }
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemModel.pictures.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
