public with sharing class WeatherIntegrationControllerExtension {
    
    public Account accountRecord {get; set;}
    public Wrapperclass wrapper {get; set;}
    public string urlIcon {get; set;}
    
    private static final string API_KEY = '592da47fbc6e826131d7ecec2eb3df49';
    private static final string URL_ENDPOINT = 'https://api.openweathermap.org/data/2.5/weather?q=';
    private static final string URL_ICON = 'https://openweathermap.org/img/wn/';
    
    public WeatherIntegrationControllerExtension(ApexPages.standardController sdtController){
     	   this.accountRecord = (Account) sdtController.getRecord();
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
            System.debug(wrapper);
            //getIcon(wrapper.weather[0].icon);
            urlIcon = URL_ICON + wrapper.weather[0].icon + '.png';
        }
	}
}