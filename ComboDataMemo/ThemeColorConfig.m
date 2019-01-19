//
//  ThemeColorConfig.m
//  ComboDataMemo
//
//  Created by sshota0809 on 2014/09/04.
//  Copyright (c) 2014年 sshota0809. All rights reserved.
//

#import "ThemeColorConfig.h"

@implementation ThemeColorConfig

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 背景設定
    UIImage *backImage = [UIImage imageNamed:@"back3.png"];
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:backImage];
    [self.tableView setBackgroundView:backImageView];
    
    
}

// グループにする
- (id)initWithColor:(NSString *)key title:(NSString *)titleName
{
    // 画面のタイトルの設定
    self.title = titleName;
    
    colorKey = key;
    
    // 現在の色を読み込み
    ud = [NSUserDefaults standardUserDefaults];
    rc = [ud doubleForKey:[NSString stringWithFormat:@"%@%@", key, @"r"]];
    gc = [ud doubleForKey:[NSString stringWithFormat:@"%@%@", key, @"g"]];
    bc = [ud doubleForKey:[NSString stringWithFormat:@"%@%@", key, @"b"]];
    
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    self.tableView.allowsSelection = NO;
    
    
    infoTextView *tv = [[infoTextView alloc] initWithFrame:CGRectMake(5, 180, 310, 200)];
    
    tv.text = @"好みの色を設定できます。しかし、背景色と文字色を同じにしてしまうと文字が見えず操作が困難になってしまうので注意してください。また、下部バーの iのアイコンとツイートアイコンの色は白固定となっています";
    // opaque属性にNOを設定する事で、背景透過を許可する。
    // ここの設定を忘れると、背景色をいくら頑張っても透明になりません。
    tv.opaque = NO;
    tv.editable = NO;
    
    // backgroundColorにalpha=0.0fの背景色を設定することで、
    // 背景色が透明になります。
    tv.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
    
    [self.tableView addSubview:tv];
    
    
    return self;
}


// セクション数を指定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1; // セクションは2個とします
}

// セクションのタイトルを指定
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch(section) {
        case 0:
            return @"";
            break;
    }
    return nil; //ビルド警告回避用
}

// それぞれのセルの行数
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) {
        return 3; // 1個目のセクションのセルは4個とします
    }
    return 2; // 2個目のセクションのセルは1個とします
}


/**
 * 指定されたインデックスパスのセルを作成する
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // セルが作成されていないか?
    if (!cell) { // yes
        // セルを作成
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // セルの背景を透明にする
    // [cell setBackgroundColor:[UIColor clearColor]];
    
    // セルにテキストを設定
    if (indexPath.row == 0) {
        // スライダー
        r = [[UISlider alloc] initWithFrame:CGRectMake(30, 10, 240, 20)];
        r.value = rc;
        r.minimumValue = 0.0;
        r.maximumValue = 1.0;
        [r addTarget:self action:@selector(tapR:) forControlEvents:UIControlEventValueChanged];
        // contentViewにaddViewすることで、Cell上に自由にUIViewを配置できます。
        [cell.contentView addSubview:r];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(275, 10, 20, 20)];
        rightLabel.text = @"赤";
        rightLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        rightLabel.textAlignment = NSTextAlignmentCenter;
        rightLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:rightLabel];

    }
    else if (indexPath.row == 1) {
        // スライダー
        g = [[UISlider alloc] initWithFrame:CGRectMake(30, 10, 240, 20)];
        g.value = gc;
        g.minimumValue = 0.0;
        g.maximumValue = 1.0;
        [g addTarget:self action:@selector(tapG:) forControlEvents:UIControlEventValueChanged];
        // contentViewにaddViewすることで、Cell上に自由にUIViewを配置できます。
        [cell.contentView addSubview:g];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(275, 10, 20, 20)];
        rightLabel.text = @"緑";
        rightLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        rightLabel.textAlignment = NSTextAlignmentCenter;
        rightLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:rightLabel];

    }
    else if (indexPath.row == 2) {
        // スライダー
        b = [[UISlider alloc] initWithFrame:CGRectMake(30, 10, 240, 20)];
        b.value = bc;
        b.minimumValue = 0.0;
        b.maximumValue = 1.0;
        [b addTarget:self action:@selector(tapB:) forControlEvents:UIControlEventValueChanged];
        // contentViewにaddViewすることで、Cell上に自由にUIViewを配置できます。
        [cell.contentView addSubview:b];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(275, 10, 20, 20)];
        rightLabel.text = @"青";
        rightLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        rightLabel.textAlignment = NSTextAlignmentCenter;
        rightLabel.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:rightLabel];

    }
    
    return cell;
}

- (void) tapR:(UISlider*)slider
{
    rc = slider.value;
    if ([colorKey isEqualToString:@"bar"]) {
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:0.6];
        UINavigationController *preView = self.presentingViewController;
        preView.navigationBar.barTintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:0.6];
        preView.toolbar.barTintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:0.6];
        
    }
    else {
            self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:1.0];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:rc green:gc blue:bc alpha:1.0]};
                UINavigationController *preView = self.presentingViewController;
        preView.navigationBar.tintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:1.0];
        preView.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:rc green:gc blue:bc alpha:1.0]};
                preView.toolbar.tintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:1.0];
        
    }
    [ud setDouble:rc forKey:[NSString stringWithFormat:@"%@%@", colorKey, @"r"]];
    
}


- (void) tapG:(UISlider*)slider
{

    gc = slider.value;
    
    if ([colorKey isEqualToString:@"bar"]) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:0.6];
        UINavigationController *preView = self.presentingViewController;
        preView.navigationBar.barTintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:0.6];
        preView.toolbar.barTintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:0.6];
        
        
    }
    else {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:1.0];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:rc green:gc blue:bc alpha:1.0]};
        UINavigationController *preView = self.presentingViewController;
        preView.navigationBar.tintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:1.0];
        preView.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:rc green:gc blue:bc alpha:1.0]};
        preView.toolbar.tintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:1.0];
    }
    
    [ud setDouble:gc forKey:[NSString stringWithFormat:@"%@%@", colorKey, @"g"]];
    
}

- (void) tapB:(UISlider*)slider
{
    bc = slider.value;
    
    if ([colorKey isEqualToString:@"bar"]) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:0.6];
        UINavigationController *preView = self.presentingViewController;
        preView.navigationBar.barTintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:0.6];
        preView.toolbar.barTintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:0.6];
        preView.toolbar.tintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:1.0];
        
    }
    else {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:1.0];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:rc green:gc blue:bc alpha:1.0]};
        UINavigationController *preView = self.presentingViewController;
        preView.navigationBar.tintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:1.0];
        preView.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:rc green:gc blue:bc alpha:1.0]};
        preView.toolbar.tintColor = [UIColor colorWithRed:rc green:gc blue:bc alpha:1.0];
    }
    
    [ud setDouble:bc forKey:[NSString stringWithFormat:@"%@%@", colorKey, @"b"]];
}


// セルの高さを指定する
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

/**
 * セルが選択されたとき
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // もし 0 が選択されたなら楽々入力の設定の表示
    // もし 1 が選択されたならアプリの使い方を表示
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
