using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace UIR.Properties
{
    public class A : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
