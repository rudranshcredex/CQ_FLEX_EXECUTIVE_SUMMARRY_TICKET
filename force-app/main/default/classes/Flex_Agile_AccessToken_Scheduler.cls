public class Flex_Agile_AccessToken_Scheduler implements schedulable {
	public void execute(SchedulableContext SC){
        ID jobID = System.enqueueJob(new Flex_Agile_Generate_AccessToken());
        System.debug('Agile AccessToken => '+jobID);
 	}
}