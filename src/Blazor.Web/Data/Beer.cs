namespace Blazor.Web.Data;


public record Beer(int Id, string Name, string Style, double Abv, decimal Price)
{
    public string ImageSrc { get; set; }
}
