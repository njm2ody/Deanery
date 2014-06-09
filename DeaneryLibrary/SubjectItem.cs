using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
    public class SubjectItem : GenericItem
    {

        public int CountOfHours { set; get; }
        public int Course { set; get; }
        public int Semester { set; get; }

        public FormOfControlItem FormOfControl { set; get; }

        public SubjectItem(int id, string name, int hours, int course, int semester, FormOfControlItem form_control)
            :base(id, name)
        {
            this.FormOfControl = form_control;
            this.CountOfHours = hours;
            this.Semester = semester;
            this.Course = course;
        }

        public SubjectItem()
        {
            this.FormOfControl = new FormOfControlItem();
        }
    }
}
