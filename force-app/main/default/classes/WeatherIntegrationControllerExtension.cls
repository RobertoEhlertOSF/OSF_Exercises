public with sharing class WeatherIntegrationControllerExtension {    

    public Wrapperclass wrapper {get; set;}
    public String urlIcon {get; set;}

    private Account accountRecord {
        get{
            if(accountRecord == null){
                accountRecord = (Account) sdtController.getRecord();
            }
            return accountRecord;
        }
        set;
    }
    
    private ApexPages.StandardController sdtController;
    private static final String API_KEY = '592da47fbc6e826131d7ecec2eb3df49';
    private static final String URL_ENDPOINT = 'https://api.openweathermap.org/data/2.5/weather?q=';
    private static final String URL_ICON = 'https://openweathermap.org/img/wn/';
    
    public WeatherIntegrationControllerExtension(ApexPages.standardController sdtController){
     	   this.sdtController = sdtController;
    }
    
    public void init(){
        
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint(URL_ENDPOINT + accountRecord.BillingCity +'&appid=' + API_KEY);
		request.setMethod('GET');
		HttpResponse response = http.send(request);
        
		// If the request is successful, parse the JSON response.
		if (response.getStatusCode() == 200) { 
    		wrapper = (Wrapperclass) JSON.deserialize(response.getBody(), Wrapperclass.class);
            urlIcon = URL_ICON + wrapper.weather[0]?.icon + '.png';
        }
	}
}