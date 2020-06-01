using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using com.Synjonse.Model.Models;
using Microsoft.AspNetCore.Mvc;

namespace UIR.Properties
{
    public class HomeController : Controller
    {
        protected readonly HkTempContext db;
        public HomeController(HkTempContext a) {
            db = a;
        }

        public IActionResult Index()
        {

            return View(db.Student.ToList());
        }

        public IActionResult AA()
        {

            return View(db.Student.ToList());
        }
    }
}
