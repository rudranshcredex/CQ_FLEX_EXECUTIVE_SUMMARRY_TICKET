public class Flex_Agile_Generate_AccessToken Implements Queueable,Database.AllowsCallouts {
    public void execute(QueueableContext context){
        try{
            Agile_Integration__mdt mdt = Agile_Integration__mdt.getInstance('AgileIntegrationData');
            HttpRequest request = new HttpRequest();
            HttpResponse response = new HttpResponse();
            request.setMethod('POST');
            request.setBody('grant_type=client_credentials&scope=mule-apis');
            request.setHeader('Authorization', 'Basic '+EncodingUtil.base64Encode(Blob.valueOf(mdt.Client_Id__c+':'+mdt.Client_Secret__c)));
            request.setHeader('Content-Type', 'client_credentials');
            request.setEndpoint(mdt.Token_URL__c);
            Http http = new Http();
            response = http.send(request);
            readResponse(response);
        } catch(Exception e){
            System.debug('Exception - Agile - refreshAccessToken: '+e.getMessage());
        }
    }
    
    public static void readResponse(HttpResponse response){
        if(response.getStatusCode() == 200){
        	System.debug('#LOG => Access token generated 200 OK');
            Map<String,object> responseMap =(Map<String,Object>)JSON.deserializeUntyped(response.getbody());
            String token = String.valueOf(responseMap.get('access_token'));
            List<Flex_MuleAccessToken__c> multToken = [SELECT token__c FROM Flex_MuleAccessToken__c WHERE Application__c = 'AgileToken' ORDER BY CreatedDate DESC LIMIT 1];
            if(!multToken.isEmpty()){
                for(Flex_MuleAccessToken__c mt: multToken){
                    mt.Token__c = token;
                }
                update multToken;
            } else {
             	Flex_MuleAccessToken__c mtok = new Flex_MuleAccessToken__c();
        		mtok.Token__c = token;
                mtok.Application__c = 'AgileToken';
        		insert mtok;   
            }
       	}
       	else{
        	System.debug('#LOG => Agile refreshaccess token: Status Code: '+response.getStatusCode()+' Body => '+response.getBody());
      	}
    }
}