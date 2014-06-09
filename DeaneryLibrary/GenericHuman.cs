using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
    public class GenericHuman
    {
        private int _id;
        public int Id
        {
            set {
                if (value > 0) { _id = value; }
                else { throw new ArgumentNullException(); }
            }
            get { return _id; }
        }
        public string FirstName { set; get; }
        public string MiddleName { set; get; }
        public string LastName { set; get; }

        public GenericHuman(string first_name, string middle_name, string last_name)
        {
            this.FirstName = first_name;
            this.MiddleName = middle_name;
            this.LastName = last_name;
        }

        public GenericHuman(string first_name, string middle_name, string last_name, int id)
        {
            this.FirstName = first_name;
            this.MiddleName = middle_name;
            this.LastName = last_name;
            this.Id = id;
        }

        public GenericHuman()
        {
            this.FirstName = this.MiddleName = this.LastName = "";
        }

        public string GetFullNameWithInitials 
        {
            get { return FirstName[0] + ". " + MiddleName[0] + ". " + LastName; }
        }
    }
}
