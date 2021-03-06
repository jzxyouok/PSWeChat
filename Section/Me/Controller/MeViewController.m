//
//  MeViewController.m
//  PSWeChat
//
//  Created by 思 彭 on 2017/4/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableViewCell.h"
#import "PersonModel.h"

@interface MeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *namesArray;
@property (nonatomic, strong) NSArray *imagesArray;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MeViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeData];
    [self setupUI];
}

#pragma mark - initData

- (void)initializeData {
    
    // 构造model
    PersonModel* model = [[PersonModel alloc] init];
    model.avater = @"siegrain_avatar";
    model.name = @"Siegrain";
    model.weChatId = @"euphoria33";
    
    self.namesArray = @[@[model], @[ @"相册", @"收藏", @"钱包", @"卡包" ],
                        @[ @"表情" ],
                        @[ @"设置" ]];
    self.imagesArray = @[
                         @[ @"" ],
                         @[
                             @"ff_IconShowAlbum",
                             @"MoreMyFavorites",
                             @"MoreMyBankCard",
                             @"MyCardPackageIcon"
                             ],
                         @[ @"MoreExpressionShops" ],
                         @[ @"MoreSetting" ]
                         ];
}

#pragma mark - 设置界面

- (void)setupUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // 注册cell
    [self.tableView registerClass:[MeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MeTableViewCell class])];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview: self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.namesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *rowArray = self.namesArray[section];
    return rowArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MeTableViewCell class]) forIndexPath:indexPath];
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        MeTableViewCell *meCell = (MeTableViewCell *)cell;
        meCell.model = self.namesArray[indexPath.section][indexPath.row];
    } else {
        cell.imageView.image = [UIImage imageNamed:self.imagesArray[indexPath.section][indexPath.row]];
        cell.textLabel.text = self.namesArray[indexPath.section][indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return section == 0 ? 15 : 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return indexPath.section == 0 ? 90 : 44;
}

#pragma mark - Private Method

#pragma mark - 懒加载

@end
