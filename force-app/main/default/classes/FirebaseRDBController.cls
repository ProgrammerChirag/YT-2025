/**
 * @description       :
 * @author            : CODEBASE
 * @group             :
 * @last modified on  : 04-13-2025
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public without sharing class FirebaseRDBController {
	private static final String FIREBASE_SERVER_ENDPOINT {
		get {
			return Label.FIREBASE_RDB_ACCESS_URL;
		}
	}
	private static final String FIREBASE_SERVER_AUTH {
		get {
			return Label.FIREBASE_RDB_AUTH_TOKEN;
		}
	}
	private static final String CALLOUT_EXCEPTION = 'failed to send request to firebase server, please verify auth or provided path is correct or not.';

	public static String fetchFirebaseServerData(String firebaseServerPath) {
		HTTPResponse response = new HTTPResponse();
		if(String.isNotBlank(FIREBASE_SERVER_ENDPOINT) && String.isNotBlank(FIREBASE_SERVER_AUTH) && !firebaseServerPath.startsWith('/')) {
			String endPointURL = FIREBASE_SERVER_ENDPOINT + firebaseServerPath + '/.json?auth=' + FIREBASE_SERVER_AUTH;
			System.debug('endPointURL' + endPointURL);
			HTTPRequest serverRequest = new HTTPRequest();
			serverRequest.setEndPoint(endPointURL);
			serverRequest.setMethod('GET');
			response = invokeAPICall(serverRequest);
			if(response.getStatusCode() == 200) {
				return response.getBody().toString();
			} else {
				throw new CalloutException(CALLOUT_EXCEPTION);
			}
		}
		return response.getBody().toString();
	}

	public static HTTPResponse invokeAPICall(HTTPRequest serverRequest) {
		HTTPResponse serverResponse = new HTTPResponse();
		if(String.isNotBlank(serverRequest.getEndpoint())) {
			HTTP http = new HTTP();
			serverResponse = http.send(serverRequest);
			return serverResponse;
		}
		return serverResponse;
	}

	private Class CalloutException extends Exception {}
}