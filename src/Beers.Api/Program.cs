using Beers.Api;
using Beers.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

if (args.Any() && args[0] == "/seed")
{
    Console.WriteLine("Seeding");
    await SeedDb(builder);
    return;
}

// Add services to the container.
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddDbContext<BeersContext>(options =>
{
    options.UseNpgsql(builder.Configuration.GetConnectionString("beers"), pgOptions => pgOptions.MigrationsAssembly(typeof(Marker).Assembly.GetName().Name));
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.MapGet("/beers/{id}", async (BeersContext db, int id) => await db.Beers.FindAsync(id));
app.MapGet("/beers", async (BeersContext db) => await db.Beers.ToListAsync());


app.Run();


async Task SeedDb(WebApplicationBuilder builder)
{
    var constr = builder.Configuration.GetConnectionString("beers");
    var optBuilder = new DbContextOptionsBuilder<BeersContext>().UseNpgsql(builder.Configuration.GetConnectionString("beers"), pgOptions => pgOptions.MigrationsAssembly(typeof(Marker).Assembly.GetName().Name));
    var ctx = new BeersContext(optBuilder.Options);
    if (await ctx.Beers.AnyAsync())
    {
        Console.WriteLine("Already data. Exiting");
        return;
    }

    var beers = new[]  {
        new Beer(1, "Estrella Damm", "Lager", 4.7, 0.59m),
        new Beer(2, "Voll Damm", "Bock", 7.4, 0.7m),
        new Beer(3, "IPA Aniversari", "IPA", 6.0, 2.0m),
        new Beer(4, "Impaled", "IPA", 8.5,3.0m),
        new Beer(5, "Ibuprofano", "DIPA", 9, 3.0m),
        new Beer(6, "Apokalyptica", "Imperial Stout", 12, 3.5m) };

    await ctx.Beers.AddRangeAsync(beers);
    await ctx.SaveChangesAsync();
    Console.WriteLine("Seed done");
}

