using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
    public class StudentRepository : GenericRepository<StudentItem>
    {
        public override List<StudentItem> GetAll()
        {
            List<StudentItem> result = new List<StudentItem>();
            try
            {
                SqlCommand com = base._cnn.CreateCommand();
                com.CommandType = CommandType.Text;
                com.CommandText = "select top 1000 * from get_all_student_with_group_name ()";

                SqlDataReader dr = com.ExecuteReader();

                while (dr.Read())
                {
                    StudentItem s = new StudentItem(
                            (int)dr["StudentId"],
                            dr["StudentFirstName"].ToString(),
                            dr["StudentMiddleName"].ToString(),
                            dr["StudentLastName"].ToString(),
                            (int)dr["GroupId"],
                            dr["GroupName"].ToString()
                            );

                    result.Add(s);
                    
                }
            }
            catch (Exception e) { throw e; }

            return result;
        }

        public override void Insert(StudentItem entity)
        {
            //@first_name     varchar(50) @middle_name    varchar(50),  @last_name		varchar(50), @group_id		int
            try 
            {
                SqlCommand com = base._cnn.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "insert_student";

                com.Parameters.AddWithValue("@first_name", entity.FirstName);
                com.Parameters.AddWithValue("@middle_name", entity.MiddleName);
                com.Parameters.AddWithValue("@last_name", entity.LastName);
                com.Parameters.AddWithValue("@group_id", entity.GroupId);

                com.ExecuteNonQuery();
            }
            catch (Exception e) { throw e; }
        }

        public override void Update(StudentItem entity)
        {
            try
            {
                SqlCommand com = base._cnn.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "update_student";
                //@id int, @first_name varchar(50), @middle_name varchar(50), @last_name varchar(50), @chair_id int
                com.Parameters.AddWithValue("@id", entity.Id);
                com.Parameters.AddWithValue("@first_name", entity.FirstName);
                com.Parameters.AddWithValue("@middle_name", entity.MiddleName);
                com.Parameters.AddWithValue("@last_name", entity.LastName);
                com.Parameters.AddWithValue("@group_id", entity.GroupId);
                
                com.ExecuteNonQuery();
            }
            catch (Exception e) { throw e; }
        }

        public override void Delete(int id)
        {
            try
            {
                SqlCommand com = base._cnn.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "delete_student";
                com.Parameters.AddWithValue("@id", id);
                com.ExecuteNonQuery();
            }
            catch (Exception e) { throw e; }
        }

        public List<StudentItem> GetStudentByGroupId(int group_id) 
        {
            List<StudentItem> result = new List<StudentItem>();
            try
            {
                SqlCommand com = base._cnn.CreateCommand();
                com.CommandType = CommandType.Text;
                com.CommandText = "select * from get_student_by_group_id (" + group_id + ")";

                SqlDataReader dr = com.ExecuteReader();

                while (dr.Read())
                {
                    result.Add(
                        new StudentItem(
                            (int)dr["StudentId"],
                            dr["StudentFirstName"].ToString(),
                            dr["StudentMiddleName"].ToString(),
                            dr["StudentLastName"].ToString(),
                            group_id,
                            dr["GroupName"].ToString()
                            )
                         );
                }
            }
            catch (Exception e) { throw e; }

            return result;
        }

        public override StudentItem GetOneById(int id)
        {
           try
           {
               SqlCommand com = base._cnn.CreateCommand();
               com.CommandType = CommandType.Text;
               com.CommandText = "select top 1 * from get_student_by_id (" + id + ")";

               SqlDataReader dr = com.ExecuteReader();
               if (dr.Read())
               {
                   StudentItem s = new StudentItem(
                      id,
                      dr["StudentFirstName"].ToString(),
                      dr["StudentMiddleName"].ToString(),
                      dr["StudentLastName"].ToString(),
                      (int)dr["GroupId"],
                      dr["GroupName"].ToString()
                      );
                   dr.Close();
                   return s;
               }
               else { return new StudentItem(); }
           }
           catch (Exception e) { throw e; }
        }
    }
}
