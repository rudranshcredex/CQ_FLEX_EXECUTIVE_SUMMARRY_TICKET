@isTest
public class Flex_AgileDocumentDownloadCtrl_Test {
    @testSetup static void setup() {
        Flex_MuleAccessToken__c mtok = new Flex_MuleAccessToken__c();
       	mtok.Token__c = 'testclass';
       	mtok.Application__c = 'AgileToken';
       	insert mtok;   
    }
    public static testMethod void method1(){
        Test.startTest();
        Flex_AgileDocumentDownloadCtrl.getVisibility('');
        Flex_AgileDocumentDownloadCtrl.downloadData('');
        Test.stopTest();
    }
    public static testMethod void method2(){
        HttpResponse res = new HttpResponse();
        res.setBody('{"example":"test"}');
        res.setStatusCode(200);
        
        HttpResponse res2 = new HttpResponse();
        res2.setBody('{"example":"test"}');
        res2.setStatusCode(401);
        
        HttpResponse res3 = new HttpResponse();
        res3.setBody('{"example":"test"}');
        res3.setStatusCode(404);
        
        HttpResponse res4 = new HttpResponse();
        res4.setBody('{"example":"test"}');
        res4.setStatusCode(500);
        
        Test.startTest();
        Flex_AgileDocumentDownloadCtrl.readDocResponse(res);
        Flex_AgileDocumentDownloadCtrl.readDocResponse(res2);
        Flex_AgileDocumentDownloadCtrl.readDocResponse(res3);
        Flex_AgileDocumentDownloadCtrl.readDocResponse(res4);
        Test.stopTest();
    }
    
    public static testmethod void method3(){
        HttpResponse res = new HttpResponse();
        res.setBody('{"access_token":"test"}');
        res.setStatusCode(200);
        
        Test.startTest();
        Flex_Agile_Generate_AccessToken.readResponse(res);
        Test.stopTest();
    }
    
    public static testmethod void method4(){
        Test.startTest();
        Flex_Agile_AccessToken_Scheduler sc = new Flex_Agile_AccessToken_Scheduler();
		string cronExp = '0 0 * * * ? *';
		system.schedule('AgileToken - TestClass', cronExp, sc);
        Test.stopTest();
    }
}