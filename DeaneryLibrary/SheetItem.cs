using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
    public class SheetItem
    {
        private int _id;
        public int Id
        {

            set
            {
                if (value > 0) { _id = value; }
                else { throw new ArgumentNullException(); }
            }
            get
            {
                return _id;
            }
        }

        public SubjectItem Subject { set; get; }
        public TeacherItem Teacher { set; get; }
        public DateTime DateSet { set; get; }
        public DateTime DateGet { set; get; }
        public FormOfControlItem Control { set; get; }
        public string GroupName { set; get; }
        public int GroupId { set; get; }


        //public List<StudentItem> Students { set; get; }

        public SheetItem(int id, SubjectItem subject, TeacherItem teacher, DateTime date_set, DateTime date_get, FormOfControlItem control, int group_id = 0, string group_name = "")
        {
            this.Id = id;
            this.Subject = subject;
            this.Teacher = teacher;
            this.DateSet = date_set;
            this.DateGet = date_get;
            this.Control = control;
            this.GroupId = group_id;
            this.GroupName = group_name;
        }

        public SheetItem()
        {

        }
    }
}
