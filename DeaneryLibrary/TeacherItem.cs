using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
    public class TeacherItem : GenericHuman
    {
        public string ChairName { set; get; }
        public int ChairId { set; get; }

        public TeacherItem(int id, string first_name, string middle_name, string last_name, int chair_id, string chair_name = "")
            :base(first_name, middle_name, last_name, id)
        {
            this.ChairName = chair_name;
            this.ChairId = chair_id;
        }

        public TeacherItem()
        {
            this.ChairName = "";
        }
    }
}
