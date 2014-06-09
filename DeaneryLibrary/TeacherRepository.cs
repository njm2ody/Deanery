using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
    public class TeacherRepository: GenericRepository<TeacherItem>
    {
        public override List<TeacherItem> GetAll()
        {
            List<TeacherItem> result = new List<TeacherItem>();
            try
            {
                SqlCommand com = base._cnn.CreateCommand();
                com.CommandType = CommandType.Text;
                com.CommandText = "select top 1000 * from get_all_teachers_with_chair_name ()";

                SqlDataReader dr = com.ExecuteReader();
                GroupRepository g = new GroupRepository();

                while (dr.Read())
                {
                    TeacherItem s = new TeacherItem(
                            (int)dr["TeacherId"],
                            dr["TeacherFirstName"].ToString(),
                            dr["TeacherMiddleName"].ToString(),
                            dr["TeacherLastName"].ToString(),
                            (int)dr["ChairId"],
                            dr["ChairName"].ToString()
                            );

                    result.Add(s);

                }
            }
            catch (Exception e) { throw e; }

            return result;
        }

        public List<TeacherItem> GetTeachersByChairId(int id) 
        {
            List<TeacherItem> result = new List<TeacherItem>();
            try
            {
                SqlCommand com = base._cnn.CreateCommand();
                com.CommandType = CommandType.Text;
                com.CommandText = "select top 1000 * from get_teacher_by_chair_id ("+ id +")";

                SqlDataReader dr = com.ExecuteReader();
                GroupRepository g = new GroupRepository();

                while (dr.Read())
                {
                    TeacherItem s = new TeacherItem(
                            (int)dr["TeacherId"],
                            dr["TeacherFirstName"].ToString(),
                            dr["TeacherMiddleName"].ToString(),
                            dr["TeacherLastName"].ToString(),
                            (int)dr["ChairId"],
                            dr["ChairName"].ToString()
                            );

                    result.Add(s);

                }
            }
            catch (Exception e) { throw e; }

            return result;
        }
    }
}
