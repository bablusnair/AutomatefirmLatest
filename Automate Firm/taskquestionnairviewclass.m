//
//  taskquestionnairviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 18/03/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "taskquestionnairviewclass.h"
#import "questincontinercell.h"

@implementation taskquestionnairviewclass

- (void)drawRect:(CGRect)rect {
    
   self.frame=CGRectMake(14, 66, self.frame.size.width, self.frame.size.height);
    
}
-(void)awakeFromNib
{
    self.imageViewForImage=[[UIImageView alloc]init];
    
    
    self.myarray = @[ @{
                         @"office": @"Category 1",
                        },
                      @{
                         @"office": @"Category 2",
                        },
                      @{
                         @"office": @"Category 3",
            
                       },
                      @{
                         @"office": @"Category 4",
                         
                       },
                      @{
                          @"office": @"Category 5",
                          
                          },
                      @{
                          @"office": @"Category 6",
                          
                          },
                      @{
                          @"office": @"Category 7",
                          
                          },
                      @{
                          @"office": @"Category 8",
                          
                          }
                      
                      ];
    //  self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 150, 0);
    
    [self.tableView registerClass:[questincontinercell class] forCellReuseIdentifier:@"ContainerTableCell"];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.myarray count]; // Total number of rows in the sample data.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;  // Only one "row" per section - with the NSArray of article titles
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"ContainerTableCell";
    
    questincontinercell *cell = (questincontinercell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"quesiontablecell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    questincontinercell *cell= (questincontinercell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView = v;
}

/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 NSDictionary *sectionData = [self.myarray objectAtIndex:section];
 NSString *header = [sectionData objectForKey:@"description"];
 return header;
 }*/

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,40)];
    imageview.image=[UIImage imageNamed:@"department blank.png"];
    [self.tableView.tableHeaderView addSubview:imageview];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 2,250,30)];
    headerLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:15];
    NSDictionary *sectionData = [self.myarray objectAtIndex:section];
    NSString *header = [sectionData objectForKey:@"office"];
    headerLabel.text = header;
    headerLabel.backgroundColor = [UIColor clearColor];
    [imageview addSubview:headerLabel];
    return imageview;
    
    
}

-(IBAction)addnewplusbuttonaction:(id)sender
{
    NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"addnewquestioncreateview" owner:self options:Nil];
    [self addSubview:[myviewarray objectAtIndex:0]];
    
}

@end
