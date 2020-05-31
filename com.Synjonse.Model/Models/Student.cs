using System;
using System.Collections.Generic;

namespace com.Synjonse.Model.Models
{
    public partial class Student
    {
        public string Sno { get; set; }
        public string Sname { get; set; }
        public string Ssex { get; set; }
        public DateTime? Sbirthday { get; set; }
        public string Class { get; set; }
    }
}
