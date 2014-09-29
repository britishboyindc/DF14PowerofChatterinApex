public with sharing class ChatterOutputDemoController {
    
    private final Project__c project;
    public List<FeedItemWrapper> fiw {get;set;}
    public String qSearch {get;set;}
    public ConnectApi.FeedElementPage feedElementPage{get;set;}
    public Integer DMLUsed {get;set;}
    
    public ChatterOutputDemoController (ApexPages.StandardController stdController) {
        this.project = (Project__c)stdController.getRecord();
        DMLUsed = 0;
    }
    
    
    public Object TextSegmentType{get{
            return ConnectApi.MessageSegmentType.Text;
    }}
    
    public Object MentionSegmentType{get{
        return ConnectApi.MessageSegmentType.Mention;
    }}
    
    public pagereference getChatterOutputbySearch() {
    fiw = new List<FeedItemWrapper> ();
    feedElementPage =  ConnectApi.ChatterFeeds.searchFeedElementsInFeed(null, ConnectApi.FeedType.Record, project.Id, qSearch);
        for (ConnectApi.FeedElement fip: feedElementPage.elements) {
                fiw.add(new FeedItemWrapper(fip));
        }
        return null;
    }
    
    
    public class FeedItemWrapper {
    
    public ConnectApi.FeedElement fe {get;set;}
    public ConnectAPI.FeedItem fi {get;set;}
    public ConnectApi.ContentCapability sourceca {get;set;}
    public ConnectApi.CommentPage fecomments {get;set;}
    
    public FeedItemWrapper (ConnectApi.FeedElement fit) {
    fe = fit;
    system.debug(fe);
    
    if (fe.feedElementType == ConnectAPI.FeedElementType.FeedItem) {
        fi = (ConnectAPI.FeedItem)fe;
    }
    
    if (fit.capabilities != NULL) {
        if (fit.capabilities.content != NULL) {
            sourceca = fit.capabilities.content;
        }
        
        if (fit.capabilities.comments != NULL) {
            fecomments = fit.capabilities.comments.page ;
        }
    }        
    
    }
    
    
    
    }

public pagereference CreateSomeNoise() {
    DMLUsed = ConnectAPIBatchHandler.CreateNoiseWithHelper(project.Id);
    return null;
}

}