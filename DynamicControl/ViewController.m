//
//  ViewController.m
//  DynamicControl
//
//  Created by Ajay on 13/06/16.
//  Copyright © 2016 Ajay. All rights reserved.
//

#import "ViewController.h"
#import "TextFieldValidator.h"

@interface ViewController ()<NSURLSessionDelegate, UITextFieldDelegate>
{
    NSArray* arrProviderAuthenticator;
    DCTextField *objControlAdded;
    NSArray* arrProviderAuthenticatorControls;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [self.temp addRegx:@"[0-9]{10}" withMsg:@"test"];
    
    NSError *error;
    NSURLSessionConfiguration *configration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configration delegate:self delegateQueue:nil];
    
    NSURL *url = [NSURL URLWithString:@"https://themobilewallet.com/DynamicServicesAPI/api/getAuthenticatorsArray"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:40.0];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    
    [request addValue:@"MIICXAIBAAKBgQC8WLjZuVdtdZK6uduP0WhB76CgPfca" forHTTPHeaderField:@"ApiUserName"];
    [request addValue:@"BNncyBt9OERYjTB5LHP6g0SqCHhx8SDbzwrQgcUycder" forHTTPHeaderField:@"ApiPassword"];
    [request addValue:@"DhtA3g3hwN8VVICPRrwnZ2qEwriOuwe9f8KRJMl90KgnYqwer" forHTTPHeaderField:@"ApiKey"];
    
    
    [request setHTTPMethod:@"POST"];
    
//    NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys: @"TEST IOS", @"name", @"IOS TYPE", @"typemap", nil];
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
//    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
        if ([httpResponse statusCode] == 200) {
            NSDictionary * mydata = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", mydata);
            if(mydata)
            {
                if ([[mydata objectForKey:@"status"] boolValue] == true) {
                    arrProviderAuthenticator = [mydata objectForKey:@"Data"];
                    
                }
              
                
            }
        }
        else
        {
            
        }
        
        
        
    }];
    
    [postDataTask resume];
    
    
    
    
    
    NSString *strJson = @"{\"5\": [ \
                        { \
                        \"ProviderId\": 5, \
                        \"FIELDSET_TYPE\": \"Textbox\", \
                        \"AuthenticatorLabel\": \"Unique Service Number\", \
                        \"AuthenticatorMessage\": \"Please enter valid fixed 9 digit Unique Service Number (eg 996747046)\", \
                        \"FIELDSET_LENGTH\": 9, \
                        \"FIELDSET_MIN_LENGTH\": 9, \
                        \"ISMANDETORY\": true, \
                        \"FIELDSET_DATATYPE\": \"Number\", \
                        \"VALIDATION_NAME\": \"Numeric Only\", \
                        \"RegX\": \"^[0-9]{9}$\", \
                        \"ORDER\": 1 \
                        }, \
                        { \
                        \"ProviderId\": 5, \
                        \"FIELDSET_TYPE\": \"Textbox\", \
                        \"AuthenticatorLabel\": \"Service Number\", \
                        \"AuthenticatorMessage\": \"Please enter a valid Service Number having length minimum 1 and maximum 13 character long(eg Gaurav123)\", \
                        \"FIELDSET_LENGTH\": 13, \
                        \"FIELDSET_MIN_LENGTH\": 1, \
                        \"ISMANDETORY\": true, \
                        \"FIELDSET_DATATYPE\": \"String\", \
                        \"VALIDATION_NAME\": \"Alphanumeric\", \
                        \"RegX\": \"^[A-Za-z0-9\\\\s]{1,13}$\", \
                        \"ORDER\": 2 \
                        }, \
                        { \
                        \"ProviderId\": 5, \
                        \"FIELDSET_TYPE\": \"Textbox\", \
                        \"AuthenticatorLabel\": \"Ero code\", \
                        \"AuthenticatorMessage\": \"Please enter a valid Ero Code having length minimum 1 and maximum 11 character long(eg abcd123)\", \
                        \"FIELDSET_LENGTH\": 11, \
                        \"FIELDSET_MIN_LENGTH\": 1, \
                        \"ISMANDETORY\": true, \
                        \"FIELDSET_DATATYPE\": \"String\", \
                        \"VALIDATION_NAME\": \"Alphanumeric\", \
                        \"RegX\": \"^[A-Za-z0-9]{1,11}$\", \
                        \"ORDER\": 3 \
                        }, \
    { \
        \"ProviderId\": 5, \
        \"FIELDSET_TYPE\": \"Textbox\", \
        \"AuthenticatorLabel\": \"Ero code\", \
        \"AuthenticatorMessage\": \"Please enter a valid Ero Code having length minimum 1 and maximum 11 character long(eg abcd123)\", \
        \"FIELDSET_LENGTH\": 11, \
        \"FIELDSET_MIN_LENGTH\": 1, \
        \"ISMANDETORY\": true, \
        \"FIELDSET_DATATYPE\": \"String\", \
        \"VALIDATION_NAME\": \"Alphanumeric\", \
        \"RegX\": \"^[A-Za-z0-9]{1,11}$\", \
        \"ORDER\": 4 \
        }, \
    { \
    \"ProviderId\": 5, \
    \"FIELDSET_TYPE\": \"Dropdown\", \
    \"AuthenticatorLabel\": \"Billing Unit\", \
    \"AuthenticatorMessage\": \"Please select Billing Unit\", \
    \"FIELDSET_LENGTH\": 4, \
    \"FIELDSET_MIN_LENGTH\": 4, \
    \"ISMANDETORY\": true, \
    \"FIELDSET_DATATYPE\": \"Number\", \
    \"VALIDATION_NAME\": \"Numeric Only\", \
    \"RegX\": \"0019~0027~0035~0043~0233~0235~0240~0251~0306~0311~0329~0337~0345~0353~0354~0356~0357~0358~0359~0360~0361~0363~0364~0365~0366~0383~0384~0385~0386~0388~0389~0390~0391~0392~0418~0426~0434~0442~0451~0467~0469~0477~0485~0493~0515~0523~0531~0540~0546~0558~0560~0561~0562~0565~0566~0574~0580~0582~0590~0591~0602~0612~0621~0639~0647~0655~0663~0671~0680~0698~0744~0787~0795~0817~0833~0841~0850~0868~0876~0884~0892~0914~0922~0931~0949~0957~0965~0973~0974~0981~0990~1121~1139~1147~1155~1163~1171~1180~1198~1228~1236~1244~1252~1261~1279~1287~1295~1325~1333~1341~1350~1368~1376~1384~1392~1406~1511~1520~1538~1546~1554~1562~1627~1635~1643~1651~1660~1678~1686~1694~1708~1716~1724~1732~1741~1759~1767~1813~1830~1848~1856~1864~1881~1911~1929~1937~1945~1953~2020~2119~2127~2160~2178~2186~2224~2232~2241~2267~2275~2313~2321~2330~2348~2356~2364~2372~2381~2399~2411~2429~2437~2445~2453~2461~2470~2488~2496~2518~2526~2534~2542~2551~2569~2577~2585~2593~2615~2623~2631~2640~2655~2658~2666~2674~2712~2721~2739~2747~2755~2763~2801~2810~2828~2836~2844~2852~2861~2879~2887~2895~2917~2925~2933~2941~2984~2992~3000~3041~3077~3085~3093~3107~3115~3123~3131~3140~3158~3166~3174~3191~3204~3222~3311~3312~3399~3554~3556~3557~3651~3652~3653~3654~3656~3657~3808~3905~3956~4016~4017~4018~4019~4021~4065~4066~4067~4068~4069~4073~4086~4087~4088~4089~4127~4129~4130~4131~4132~4133~4134~4135~4136~4137~4138~4139~4140~4141~4142~4143~4144~4145~4146~4147~4148~4151~4158~4159~4160~4161~4162~4163~4164~4165~4166~4167~4168~4169~4170~4171~4172~4173~4174~4175~4176~4177~4178~4179~4180~4181~4182~4183~4184~4185~4186~4187~4188~4189~4190~4191~4192~4193~4200~4204~4236~4237~4250~4251~4252~4253~4261~4265~4275~4295~4296~4297~4310~4316~4327~4328~4329~4330~4331~4332~4334~4335~4336~4337~4338~4339~4340~4341~4342~4343~4344~4345~4346~4359~4367~4371~4372~4373~4375~4377~4379~4380~4383~4391~4394~4395~4396~4405~4445~4448~4456~4464~4532~4540~4541~4542~4551~4570~4572~4577~4578~4579~4591~4592~4593~4594~4595~4596~4597~4598~4599~4600~4601~4602~4603~4604~4605~4606~4607~4608~4609~4610~4611~4612~4613~4614~4615~4635~4636~4637~4640~4641~4642~4643~4645~4646~4652~4655~4668~4669~4670~4671~4672~4673~4674~4675~4676~4677~4678~4679~4680~4681~4682~4683~4684~4685~4686~4687~4688~4689~4690~4691~4692~4696~4697~4698~4699~4700~4701~4702~4703~4704~4705~4706~4707~4708~4709~4710~4711~4713~4714~4715~4716~4717~4718~4719~4720~4721~4722~4723~4724~4726~4727~4728~4729~4730~4731~4732~4733~4734~4738~4739~4740~4741~4742~4743~4744~4745~4746~4747~4748~4749~4750~4751~4752~4753~4754~4755~4756~4757~4758~4759~4760~4761~4762~4763~4764~4765~4766~4767~4768~4769~4770~4783~4788~4789~4790~4791~4792~4793~4794~4795~4796~4797~4798~4799~4800~4801~4802~4803~4804~4805~4806~4807~4808~4809~4810~4811~4812~4813~4814~4815~4816~4817~4818~4819~4820~4821~4822~4823~4824~4825~4826~4827~4828~4829~4830~4831~4832~4833~4834~4835~4836~4837~4838~4839~4840~4841~4842~4843~4844~4845~4846~4847~4848~4849~4850~4851~4852~4853~4854~4855~4856~4857~4858~4859~4860~5118~5126~5134~5142~5151~5169~5177~5185~5193~5258~5266~5274~5282~5291~5401~5410~5428~5436~5444~5452~5461~5479~5487~5495~5517~5525~5533~5541~5550~5568~5576~5584~5606~5614~5622~5631~5649~5657~5665~5681~5690~5711~5720~5738~5746~5754~5762~5771~5789~5797~5801~5819~5827~5835~5843~5851~5860~5878~5886~5894~5916~5924~5932~5941~5959~5967~5975~5983~5991~6131~6149~6157~6165~6173~6181~6190~6211~6220~6238~6246~6254~6262~6271~6289~6319~6327~6335~6343~6351~6360~6416~6424~6441~6459~6718~6726~6734~6742~6912~7111~7129~7137~7145~7153~7218~7226~7234~7242~7323~7412~7421~7439~7943~7951~7960~7978~7986~8125~8133~8141~8150~8168~8176~8184~8192~9121~9148~9517~9525~9533~4861~4862~4863~4864~4865~4866~4869~4868~4867~4870~4871~4872~4873~4874\", \
    \"ORDER\": 5 \
    }, \
    { \
    \"ProviderId\": 5, \
    \"FIELDSET_TYPE\": \"Textbox\", \
    \"AuthenticatorLabel\": \"Ero code\", \
    \"AuthenticatorMessage\": \"Please enter a valid Ero Code having length minimum 1 and maximum 11 character long(eg abcd123)\", \
    \"FIELDSET_LENGTH\": 11, \
    \"FIELDSET_MIN_LENGTH\": 1, \
    \"ISMANDETORY\": true, \
    \"FIELDSET_DATATYPE\": \"String\", \
    \"VALIDATION_NAME\": \"Alphanumeric\", \
    \"RegX\": \"^[A-Za-z0-9]{1,11}$\", \
    \"ORDER\": 6 \
    } \
                        ]}";
    
    
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:[strJson dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"%@", jsonObject);
    objControlAdded = [self controlMakerWithJSON:[jsonObject objectForKey:@"5"] onView:self.view];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self.temp validate];
    
}



-(NSArray*)controlMakerWithJSON:(NSArray *)arrAuthenticator onView:(UIView*)controlView {
    NSMutableArray *arrControls = [[NSMutableArray alloc] init];
    for (int i = 0; i < arrAuthenticator.count; i++) {
        Authenticator *obj = [[Authenticator alloc] init:[arrAuthenticator objectAtIndex:i]];
        DCTextField *objControl = [self controlWithAuthenticator:obj];
        [controlView addSubview:objControl];
        [arrControls addObject:objControl];
    }
    return arrControls;
}

-(DCTextField*)controlWithAuthenticator:(Authenticator *)obj
{
    CGFloat controlHeight = 35.0;
    CGFloat topPosition = 10;
    CGFloat newTopPosition = topPosition;
    int controlOrder = [obj.ORDER intValue];
    if(controlOrder > 1)
    {
        newTopPosition = ((controlOrder - 1) * (topPosition + controlHeight)) + topPosition;
    }
    
    
    DCTextField *dcfield = [[DCTextField alloc] initWithFrame:CGRectMake(16, newTopPosition, 320, controlHeight) forAuthenticator:obj];
    [dcfield setDelegate:self];
//    dcfield.authenticatorObject = obj;
    [dcfield setBorderStyle:UITextBorderStyleRoundedRect];
    [dcfield setPlaceholder:obj.AuthenticatorLabel];
     //dcfield.isMenuAvailable = YES; //set long press menu, by default is disable
    [dcfield setIsMandatory:[obj.ISMANDETORY boolValue]];
    [dcfield setPresentInView:self.view];
    
     
    
    [dcfield addRegx:obj.RegX withMsg:obj.AuthenticatorMessage];
    [dcfield validate];
    return dcfield;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testButton:(id)sender {
    [self.temp validate];
    //[self.temp validate];
    [objControlAdded validate];
}
@end
