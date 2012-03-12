//
//  CUDiscPanelViewController.m
//  CUDiscPanel
//
//  Created by curer on 12-2-23.
//  Copyright 2012 curer. All rights reserved.
//

#import "CUDiscPanelViewController.h"
#import "CUDiscPanel.h"


@implementation CUDiscPanelViewController

- (void)ButtonDidClicked:(UIButton *)sender
{
    NSLog(@"ttt");
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect rc = CGRectMake(0, 0, 300, 300);
    
    CUDiscPanel *panel = [[CUDiscPanel alloc] initWithFrame:rc];
    
    panel.center = self.view.center;
    
    [panel setBackgroundImage:[UIImage imageNamed:@"img.jpg"]];
    
    [self.view addSubview:panel];
    
    [panel release];
    
    for (int i = 0; i < 3; ++i) {
        UIButton *item = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        
        [item addTarget:self 
                 action:@selector(ButtonDidClicked:) 
       forControlEvents:UIControlEventTouchUpInside];
        
        item.titleLabel.text = @"T";
        item.backgroundColor = [UIColor redColor];
        
        [panel addButton:item];
        
        [item release];
    }
    
    [panel setButtonListPosition];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
