//
//  MasterViewController.m
//  Hacker News
//
//  Copyright (c) 2013 Programming Thomas. All rights reserved.
//

#import "MasterViewController.h"

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.backgroundOperationQueue = [NSOperationQueue new];
    self.backgroundOperationQueue.maxConcurrentOperationCount = 1;
    
    [self refresh:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Article * article = self.articles[indexPath.row];
    cell.textLabel.text = article.title;
    cell.detailTextLabel.text = article.points;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Article * article = self.articles[indexPath.row];
        DetailViewController * dvc = segue.destinationViewController;
        dvc.detailTitle = article.title;
        dvc.detailUrl = article.url;
    }
}

- (IBAction)refresh:(id)sender {
    [self.backgroundOperationQueue addOperationWithBlock:^{
        NSURL * url = [NSURL URLWithString:@"http://news.ycombinator.com"];
        OGElement * contents = (OGElement*)[ObjectiveGumbo parseNodeWithUrl:url];
        
        
        NSMutableArray * articles = [NSMutableArray new];
        
        NSArray * tableRowsOnMainPage = [contents elementsWithClass:@"title"];
        
        for (OGElement * tableDataCell in tableRowsOnMainPage)
        {
            if (tableDataCell.children.count > 1)
            {
                OGElement * linkElement = [tableDataCell elementsWithTag:GUMBO_TAG_A][0];
                Article * article = [Article new];
                article.title = linkElement.text;
                article.url = linkElement.attributes[@"href"];
                
                //Get the row below this row
                NSArray * siblingRows = [(OGElement*)tableDataCell.parent.parent children];
                
                OGElement * element = [siblingRows objectAtIndex:[siblingRows indexOfObject:tableDataCell.parent] + 1];
                OGElement * subtext = [element elementsWithClass:@"subtext"][0];
                article.points = [(OGElement*)subtext.children[0] text];
                
                [articles addObject:article];
            }
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.articles = articles;
            [self.tableView reloadData];
        }];
    }];
}
@end
