using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
    public class StudentItem : GenericHuman
    {
        public int GroupId { set; get; }
        public string GroupName { set; get; }

        public StudentItem(int id, string first_name, string middle_name, string last_name, int group_id, string group_name = "")
            :base(first_name, middle_name, last_name, id)
        {
            this.GroupId = group_id;
            this.GroupName = group_name;
        }

        public StudentItem()
        {

        }
    }
}
