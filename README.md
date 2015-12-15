# PopView
    //1、实例化popView
    PopView *pop = [[PopView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //2、先设置按钮出现的中心点，即Demo中暗绿色的点的中心位置
    pop.centerPoint = sender.center;//CGPointMake(100, 250);
    
    //3、再设置点击的item的title，此处可以拓展 ，如果按钮上要加图片  items数组可以装字典如items = @[@{@"title":@"打电话",@"image":@""}]
    pop.items = @[@"打电话",@"定位",@"拍照",@"语音"];
    
    //4、设置代理
    pop.delegate = self;
    
    //5、显示PopView
    [pop showInView:self.view];
