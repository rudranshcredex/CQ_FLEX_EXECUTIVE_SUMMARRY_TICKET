public without sharing class Flex_AgileDocumentDownloadCtrl {   
    public static Agile_Integration__mdt mdt = Agile_Integration__mdt.getInstance('AgileIntegrationData');
    
    @AuraEnabled
    public static string getUserSite(){
        return [SELECT CQ_FLEX_Sites__c FROM User WHERE Id =: UserInfo.getUserId() ].CQ_FLEX_Sites__c;
    }
    @AuraEnabled
    public static boolean getVisibility(String recSite){
        if (recSite == getUserSite()) {
            return true;
        } else {
            return false;
        }
    }
    @AuraEnabled
    public static string downloadData(String documentURL){
		string data = null;
        try{
            String accessToken = getAccesToken();
            if(accessToken == null){
                data = 'token_expired';
                System.enqueueJob(new Flex_Agile_Generate_AccessToken());
                return data;
            }
            HttpRequest request = new HttpRequest();
            HttpResponse response = new HttpResponse();
            request.setMethod('GET');
            request.setHeader('Authorization', 'Bearer '+accessToken);
            request.setEndpoint(mdt.Service_URL__c+'?fileUrl='+documentURL);
            system.debug('U: '+mdt.Service_URL__c+'?fileUrl='+documentURL);
            Http http = new Http();
            response = http.send(request);
            data = readDocResponse(response);
        } catch(Exception e){
            system.debug(e.getMessage());
            data = 'exception';
        }
        return data;
    }
    
    public static string readDocResponse(HttpResponse response){
        if(response.getStatusCode() == 200){
         	return EncodingUtil.base64Encode(response.getBodyAsBlob());
       	} else if(response.getStatusCode() == 401){
            System.enqueueJob(new Flex_Agile_Generate_AccessToken());
        	return 'token_expired';
       	} else if (response.getStatusCode() == 404){
        	return 'file_not_found';
      	}
        else{
         	return 'failed';
      	}
    }
    
    public static string getAccesToken(){
        String token = null;
        try{
        	List<Flex_MuleAccessToken__c> multToken = [SELECT token__c FROM Flex_MuleAccessToken__c WHERE Application__c = 'AgileToken' ORDER BY CreatedDate DESC LIMIT 1];
            if(!multToken.isEmpty()){
                token = multToken[0].Token__c;
            }
        } catch (Exception e){
            System.debug('Exception - Agile - getAccesToken: '+e.getStackTraceString());
        }
        return token;
    }
    
}