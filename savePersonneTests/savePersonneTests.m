//
//  savePersonneTests.m
//  savePersonneTests
//
//  Created by xavier on 16/02/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SPImageHelper.h"
#import "AppDelegate.h"
#import "Classe.h"
#import "Personne.h"


@interface savePersonneTests : XCTestCase

@end

@implementation savePersonneTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSaveImage {
    UIImage * monImage = [UIImage imageNamed:@"testImage"];
    XCTAssertNotNil(monImage, @"monImage nil");
    NSString * guid = [SPImageHelper saveImage:monImage];
    XCTAssertNotNil(guid, @"guid nil");
    UIImage * loadImage = [SPImageHelper loadImage:[NSString stringWithFormat:@"%@.png", guid ]];
    XCTAssertFalse([monImage isEqual:loadImage]);
}

- (void)testIfSalleExist{
    AppDelegate * monAppDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = monAppDelegate.managedObjectContext;
    XCTAssertNotNil(context);
    NSError * error;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SPClasse"];
    XCTAssertNotNil(request);
    NSArray *results = [context executeFetchRequest:request error:&error];
    XCTAssertNotNil(results);
    XCTAssertGreaterThanOrEqual(results.count, 1);
}

- (void)testAddAndRemovePersonne{
    AppDelegate * monAppDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = monAppDelegate.managedObjectContext;
    XCTAssertNotNil(context);
    NSError * error;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SPPersonne"];
    NSArray *initialPersons = [context executeFetchRequest:request error:&error];
    XCTAssertNotNil(initialPersons);
    
    NSManagedObject *newPersonne;
    newPersonne = [NSEntityDescription insertNewObjectForEntityForName:@"SPPersonne" inManagedObjectContext:context];
    [newPersonne setValue:@"testName" forKey:@"name"];
    [newPersonne setValue:@"testFirstName" forKey:@"firstName"];
    XCTAssertNotNil(newPersonne);
    request = [NSFetchRequest fetchRequestWithEntityName:@"SPPersonne"];
    NSArray *personnes = [context executeFetchRequest:request error:&error];
    XCTAssertNotNil(personnes);
    
    XCTAssertFalse(initialPersons.count == personnes.count + 1);
    
    [monAppDelegate.maClasse removePersonneObject:(SPPersonne*)newPersonne];
    [context deleteObject:newPersonne];
    request = [NSFetchRequest fetchRequestWithEntityName:@"SPPersonne"];
    personnes = [context executeFetchRequest:request error:&error];
    XCTAssertNotNil(personnes);
    
    XCTAssertTrue(initialPersons.count == personnes.count);
}

- (void)testAddUser {
    
    Classe *maClasse = [Classe new];
    Personne * personne = [Personne new];
    
    [self measureBlock:^{
        [maClasse addUser:personne];
        [maClasse loadUsersList];
        
    }];
}


- (void)testLoadUsersList {
    
    Classe *maClasse = [Classe new];
    [self measureBlock:^{
        [maClasse loadUsersList];
        
    }];
}

@end
