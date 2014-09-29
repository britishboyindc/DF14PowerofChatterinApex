@isTest
private class ChatterInput_TEST {
    /*Be careful of API versions! */
    
    @IsTest(SeeAllData=true)
    static void test_method_one() {
    
    Project__c testp = new Project__c(Name = 'Test');
    insert testp;

    Project_Member__c testpm = new Project_Member__c (Project__c = testp.Id, Member__c = userinfo.getUserId());
    
    insert testpm;

    String s = 'Test Blob';
    Blob testbinary = blob.valueof(s);

    test.startTest();

    ChatterInputDemoController2 cim = new ChatterInputDemoController2(new ApexPages.StandardController(testpm));
        cim.a.body = testbinary;
        cim.a.name = 'Test File.Doc';
        cim.a.ContentType = 'application/doc';
        
        cim.insertfile();
        test.stopTest();
        
        //Check there are message segments
        system.assertequals(1, cim.fpm.body.messageSegments.size());
        
        //Check Text of message segment
        system.assert(cim.fpm.body.messageSegments[0].text.contains('Resume'));
        
        //Check there is content capability
        system.assertnotequals(NULL, cim.fpm.capabilities.content);
        
        //Check title of Content
        system.assertequals('Resume Upload Peter Churchill', cim.fpm.capabilities.content.title);
}
    
}