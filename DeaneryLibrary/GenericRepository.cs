using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
    public class GenericRepository<T> : IERepository<T> where T: class
    {
       protected SqlConnection _cnn;
       private string _connection_string = "Data Source=localhost; Initial Catalog=Deanery; Integrated Security=True";

        private void GetConnection()
        {
            this._cnn = new SqlConnection(this._connection_string);
            try { this._cnn.Open(); }
            catch (Exception e) { throw e; }
        }

        public GenericRepository(SqlConnection cnn)
        {
            this._cnn = cnn;
            try { this._cnn.Open(); }
            catch (Exception e) { throw e; }
        }


        public GenericRepository(string connection_string)
        {
            this._connection_string = connection_string;
            GetConnection();
        }

        /*public GenericRepository(string host, string db_name, string user, string password, string integrated_security = "True")
        {
            this._connection_string = "Data Source="+ host.Trim() + "; Initial Catalog="+db_name.Trim()+"; Integrated Security="+integrated_security.Trim();
        //TODO: create this constructor
            GetConnection();
        }*/

        public GenericRepository()
        {
            GetConnection();
        }

        //public abstract void Insert(T entity);
        //public abstract void Update(T entity);
        //public abstract void Delete(int id);
        //public abstract List<T> GetAll();
        //public abstract T GetOneById(int id);

        public virtual void Insert(T entity) { throw new NotImplementedException(); }
        public virtual void Update(T entity) { throw new NotImplementedException(); }
        public virtual void Delete(int id) { throw new NotImplementedException(); }
        public virtual List<T> GetAll() { throw new NotImplementedException(); }
        public virtual T GetOneById(int id) { throw new NotImplementedException(); }
    }
}
