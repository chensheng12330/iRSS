//
//  BlogReaderViewController.m
//  iRSS
//
//  Created by sherwin on 13-12-2.
//  Copyright (c) 2013年 sherwin. All rights reserved.
//

#import "BlogReaderViewController.h"
#import "SHFTAnimationExample.h"
#import "QuadCurveMenu.h"
#import "QuadCurveMenuItem.h"


@interface BlogReaderViewController ()
@property (nonatomic, retain) UIWebView *myWebView;
@property (nonatomic, retain) NSURLRequest *mainRequest;
@property (nonatomic, retain) HMSideMenu *sideMenu;

@property (nonatomic, retain) UIActivityIndicatorView *acWebLoad;
@end

@implementation BlogReaderViewController

- (void)viewDidLoad
{
    CGRect frame = [UIScreen mainScreen].bounds;
    frame.size.height -= 20;
    self.view.frame = frame;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [super viewDidLoad];
    
    self.myWebView = [[[UIWebView alloc] initWithFrame:frame] autorelease];
    self.myWebView.delegate = self;
    [self.view insertSubview:self.myWebView atIndex:0];
    
    
    _acWebLoad = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_acWebLoad setFrame:CGRectMake(320/2.0-10, self.view.frame.size.height/2.0-10, 20, 20)];
    [_acWebLoad setHidesWhenStopped:YES];
    [_acWebLoad startAnimating];
    [self.view addSubview:_acWebLoad];
    
    /////
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate= self;
    singleTap.cancelsTouchesInView = NO;
    
    //这个可以加到任何控件上,比如你只想响应WebView，我正好填满整个屏幕
    [self.myWebView addGestureRecognizer:singleTap];  [singleTap release];
    
	// Do any additional setup after loading the view, typically from a nib.
    //[_myWebView.scrollView setScrollEnabled:NO];
    _myWebView.backgroundColor = [UIColor whiteColor];
    
    _mainRequest = [[NSURLRequest requestWithURL:[NSURL URLWithString:_strUrlLink] cachePolicy:0 timeoutInterval:24*60*60] retain];
    [_myWebView loadRequest:_mainRequest];
    
    ///////////////////
    UIImage *storyMenuItemImage = [self imageWithImageSimple:[UIImage imageNamed:@"btn_press_nor.png"] scaledToSize:CGSizeMake(45, 45)];
    UIImage *storyMenuItemImagePressed = [self imageWithImageSimple:[UIImage imageNamed:@"btn_press_hight.png"] scaledToSize:CGSizeMake(45, 45)];
    
    // Camera MenuItem.
    QuadCurveMenuItem *cameraMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[self imageWithImageSimple:[UIImage imageNamed:@"btn4.png"] scaledToSize:CGSizeMake(35, 35)]
                                                         highlightedContentImage:nil];
    // People MenuItem.
    QuadCurveMenuItem *peopleMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                                highlightedImage:storyMenuItemImagePressed
                                                                    ContentImage:[self imageWithImageSimple:[UIImage imageNamed:@"btn3.png"] scaledToSize:CGSizeMake(35, 35)]
                                                         highlightedContentImage:nil];
    // Music MenuItem.
    QuadCurveMenuItem *musicMenuItem = [[QuadCurveMenuItem alloc] initWithImage:storyMenuItemImage
                                                               highlightedImage:storyMenuItemImagePressed
                                                                   ContentImage:[self imageWithImageSimple:[UIImage imageNamed:@"btn2.png"] scaledToSize:CGSizeMake(35, 35)]
                                                        highlightedContentImage:nil];
    // Thought MenuItem.
    
    
    NSArray *QCMenuItems = [[NSArray alloc] initWithObjects:cameraMenuItem, peopleMenuItem, musicMenuItem,nil];
    [cameraMenuItem release];
    [peopleMenuItem release];
    [musicMenuItem release];
    
    
    //CGRect rect =  self.view.bounds;
    
    QuadCurveMenu *viQuadCurveMenu = [[QuadCurveMenu alloc] initWithFrame:CGRectMake(0, 0, 320, 640) menus:QCMenuItems addImage:[self imageWithImageSimple:[UIImage imageNamed:@"btn1.png"] scaledToSize:CGSizeMake(45, 45)]];
    
    viQuadCurveMenu.delegate = self;
    
    //viQuadCurveMenu.userInteractionEnabled = YES;
    // set curveMenu view move rect
    float height = 0;
    if ([UIScreen mainScreen].bounds.size.height>500) {
        height = 430;
    }
    else
    {
        height = 379;
    }
    
    CGRect rect = CGRectMake(128, 108, 284, height); //379
    
    [SHFTAnimationExample MoveView:viQuadCurveMenu inRect:rect];
    
    [self.view addSubview:viQuadCurveMenu];
    
}

- (IBAction)toggleMenu:(id)sender {
    if (self.sideMenu.isOpen)
        [self.sideMenu close];
    else
        [self.sideMenu open];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    if (self.sideMenu.isOpen) {
        [self.sideMenu close];
    }
    return;
    CGPoint point = [sender locationInView:self.view];
    NSLog(@"handleSingleTap!pointx:%f,y:%f",point.x,point.y);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    self.sideMenu = nil;
    self.myWebView= nil;
    self.mainRequest=nil;
    self.acWebLoad = nil;
    [super dealloc];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request);
    
    [_acWebLoad startAnimating];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_myWebView.scrollView setScrollEnabled:YES];
    
    [_acWebLoad setHidden:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_acWebLoad setHidden:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)quadCurveMenu:(QuadCurveMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSInteger tag = idx;
    if (tag ==0) { //主页
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (tag == 3)//后退
    {
        [_myWebView goBack];
    }
    else if(tag ==2 )//
    {
        [_myWebView goForward];
    }
    
    return;
}


- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);// Tell the old image to draw in this newcontext, with the desired// new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)]; // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext(); // End the context
    UIGraphicsEndImageContext(); // Return the new image.
    return newImage;
}
@end
