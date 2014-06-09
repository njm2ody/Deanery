using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
    public class GradeItem : GenericItem
    {
        public int Value { set; get; }

        public StudentItem Student { set; get; }

        public GradeItem(int id, string type, int value, StudentItem student)
            :base(id, type)
        {
            this.Value = value;
            this.Student = student;
        }

        public GradeItem()
        {

        }
    }
}
