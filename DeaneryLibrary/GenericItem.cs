using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
    public class GenericItem
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

        public string Name { set; get; }

        public GenericItem(int id, string name)
        {
            this.Id = id;
            this.Name = name;
        }

        public GenericItem()
        {
            this.Name = "";
        }
    }
}
