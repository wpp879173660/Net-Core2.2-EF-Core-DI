using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using com.Synjonse.Model;
using com.Synjonse.Model.Models2;
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

            //var dbs = (from a in db.Aset
            //          join m in db.Mset on a.Pid equals m.Mid
            //          join u in db.Uset on a.Mid equals u.Aid
            //          join r in db.Rset on u.Aid equals r.Pid
            //          select new
            //          {
            //              m.Mname,
            //              r.Pnanme,
            //              u.Aid
            //          } into dbset
            //          group dbset by new { dbset.Mname, dbset.Pnanme, dbset.Aid }
            //          into set
            //          select new
            //          {
            //              Mname = set.Key.Mname,
            //              Pname = set.Key.Pnanme,
            //              Aid = set.Key.Aid
            //          }).Where(a=>a.Aid == 3);

            //dbs s = db.dbs.Where(a => a.aid == 2).OrderBy(n=>n.aid).Take(1).Single();
            //ViewBag.j = s.pnanme;
            return View(db.dbs.Where(a=>a.aid==2).ToList());
        }

        public IActionResult AA()
        {

            return View(db.Student.ToList());
        }
    }
}
