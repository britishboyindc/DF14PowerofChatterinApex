public with sharing class ConnectAPIBatchHandler {


public static Integer CreateNoiseWithHelper (Id ProjectId) {
List<ConnectApi.BatchInput> binput = new List<ConnectApi.BatchInput>();

for (Integer i=0; i <50; i++) {

    String sText = 'Automatic Notification:' + '\n';
    sText += '\n' + 'Batch Entry:' + string.valueof(i) + '\n';
    
    ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
    messageInput.messageSegments = ConnectApiHelper.getMessageSegmentInputs(sText);
     
        ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
        input.feedElementType =  ConnectApi.FeedElementType.FeedItem;
        input.SubjectId = ProjectId;
        input.visibility = ConnectAPI.FeedItemVisibilityType.InternalUsers;
        input.body = messageInput;
        binput.add(new ConnectApi.BatchInput(input));
}
//system.debug(binput);
ConnectAPI.ChatterFeeds.postFeedElementBatch(NULL, binput);
return Limits.getDMLStatements();
}

public static void UpdateProjectMembers (List<Project_Member__c> NewMembers) {
List<ConnectApi.BatchInput> binput = new List<ConnectApi.BatchInput>();

for (Project_Member__c pm: NewMembers) {

    ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
    messageInput.messageSegments = new List<ConnectApi.MessageSegmentInput>();
     
    ConnectApi.TextSegmentInput textSegment = new ConnectApi.TextSegmentInput();
    textSegment.text = 'Automatic Notification:' + '\n';
    messageInput.messageSegments.add(textSegment);
     
    ConnectApi.MentionSegmentInput mSegment = new ConnectApi.MentionSegmentInput();
    mSegment.Id = pm.Member__c;
    messageInput.messageSegments.add(mSegment);

    textSegment = new ConnectApi.TextSegmentInput();
    textSegment.text = '\n' + 'Please add your resume here:' + '\n';
    messageInput.messageSegments.add(textSegment);

    ConnectApi.LinkSegmentInput lSegment = new ConnectApi.LinkSegmentInput();
    lSegment.URL = 'https://gs0.salesforce.com/'+ pm.Id;
    messageInput.messageSegments.add(lSegment);

        ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
        input.feedElementType =  ConnectApi.FeedElementType.FeedItem;
        input.SubjectId = pm.Project__c;
        input.visibility = ConnectAPI.FeedItemVisibilityType.InternalUsers;
        input.body = messageInput;
        binput.add(new ConnectApi.BatchInput(input));
}
//system.debug(binput);
ConnectAPI.ChatterFeeds.postFeedElementBatch(NULL, binput);

}

public static void UpdateProjectMembersWithHelper (List<Project_Member__c> NewMembers) {
List<ConnectApi.BatchInput> binput = new List<ConnectApi.BatchInput>();

for (Project_Member__c pm: NewMembers) {

    String sText = 'Automatic Notification:' + '\n';
    sText += '{' + pm.Member__c + '}';
    sText += '\n' + 'Please add your resume here:' + '\n';
    sText += 'https://gs0.salesforce.com/apex/ResumeUpload?Id=' + pm.Id;
        
    
    ConnectApi.MessageBodyInput messageInput = new ConnectApi.MessageBodyInput();
    messageInput.messageSegments = ConnectApiHelper.getMessageSegmentInputs(sText);
     
        ConnectApi.FeedItemInput input = new ConnectApi.FeedItemInput();
        input.feedElementType =  ConnectApi.FeedElementType.FeedItem;
        input.SubjectId = pm.Project__c;
        input.visibility = ConnectAPI.FeedItemVisibilityType.InternalUsers;
        input.body = messageInput;
        binput.add(new ConnectApi.BatchInput(input));
}
//system.debug(binput);
ConnectAPI.ChatterFeeds.postFeedElementBatch(NULL, binput);

}



}