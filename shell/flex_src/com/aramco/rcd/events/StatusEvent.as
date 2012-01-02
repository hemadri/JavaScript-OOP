package com.aramco.rcd.events
{
	import flash.events.Event;
	
	public class StatusEvent extends Event
	{
		public var statusMessage:String;
		
		public static const STATUS_CHANGE:String='StatusChange';
		
		public static const PROCESSING:String = 'Processing';
		
		public static const RETRIEVE_SUCCESS:String = 'Retrieved Successfully';
		public static const RETRIEVE_FAILURE:String = 'Unable to retrieve';
		
		public static const SAVE_SUCCESS:String = 'Saved Successfully';
		public static const SAVE_FAILURE:String = 'Unable to save';
		
		public static const UPDATE_SUCCESS:String = 'Updated Successfully';
		public static const UPDATE_FAILURE:String = 'Unable to update';
		
		public static const PUBLISH_SUCCESS:String = 'Published Successfully';
		public static const PUBLISH_FAILURE:String = 'Unable to publish';
		
		public static const UNLOCK_SUCCESS:String = 'Unlocked Successfully';
		public static const UNLOCK_FAILURE:String = 'Unable to unlock';
		
		public static const LOCK_SUCCESS:String = 'Locked Successfully';
		public static const LOCK_FAILURE:String = 'Unable to Lock';
		
		public static const UPLOADED_SUCCESS:String = 'Uploaded Successfully';
		public static const UPLOADED_FAILURE:String = 'Unable to upload';
		
		public static const DELETED_SUCCESS:String = 'Deleted Successfully';
		public static const DELTETED_FAILURE:String = 'Unable to delete';
		
		public function StatusEvent(type:String, statusMessage:String='Processing')
		{
			super(type, true);
			this.statusMessage = statusMessage;
		}
	}
}