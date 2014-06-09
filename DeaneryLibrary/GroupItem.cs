using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
    public class GroupItem : GenericItem
    {   
        public DateTime DateIn  { set; get; }
        public DateTime DateOut { set; get; }
        public int SpecialityId { set; get; }
        public string SpecialityName { set; get; }


        public GroupItem(int id, string name, DateTime date_in, DateTime date_out, int speciality_id, string speciality_name = "")
            : base(id, name)
        {
            this.DateIn = date_in;
            this.DateOut = date_out;
            this.SpecialityId = speciality_id;
            this.SpecialityName = speciality_name;
        }

        public GroupItem()
        {
            this.DateIn = DateTime.Now;
            this.DateOut = DateTime.Now.AddYears(4);

        }


    }
}
