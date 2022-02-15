

namespace Blazor.Web.Data;

public class BeerService
{
    private readonly IConfiguration _config;
    private readonly HttpClient _httpClient;
    public BeerService(IConfiguration config, IHttpClientFactory httpClientFactory)
    {
        _config = config;
        _httpClient = httpClientFactory.CreateClient();
    }


    public async Task<Beer[]> GetBeers()
    {
        var beers = await _httpClient.GetFromJsonAsync<Beer[]>($"{_config["Api:Url"]}/beers");
        foreach (var beer in beers)
        {
            beer.ImageSrc = $"{_config["Images:Url"]}/{beer.Id}.jpg";
        }
        return beers;
    }
}
