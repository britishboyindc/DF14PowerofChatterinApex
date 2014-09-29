trigger ManageProjectMembers on Project_Member__c (after insert) {
	ConnectAPIBatchHandler.UpdateProjectMembersWithHelper (trigger.new);
}