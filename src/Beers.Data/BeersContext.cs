using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Beers.Data;

public class BeersContext : DbContext
{
    public DbSet<Beer> Beers { get; set; }


    public BeersContext(DbContextOptions<BeersContext> options) : base(options)
    {
    }
}
