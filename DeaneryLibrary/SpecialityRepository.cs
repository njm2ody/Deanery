using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
   public class SpecialityRepository : GenericRepository<SpecialityItem>
    {
        public override List<SpecialityItem> GetAll()
        {
            List<SpecialityItem> result = new List<SpecialityItem>();

            SqlCommand com = base._cnn.CreateCommand();
            com.CommandType = CommandType.Text;
            com.CommandText = "select top 1000 * from Speciality";

            SqlDataReader dr = com.ExecuteReader();
            /*
              s.SubjectId, s.SubjectName, 
			  sc.SubjectInCurriculumId,
			  sc.SubjectInCurriculumCourse as Course,
			  sc.SubjectInCurriculumSemester as Semester, 
			  sc.SubjectInCurriculumCountOfHours as CountOfHours, 
			  f.FormOfControlId, f.FormOfControlName
             */
            while (dr.Read())
            {
                result.Add(
                    new SpecialityItem(
                        (int)dr["SpecialityId"],
                        dr["SpecialityName"].ToString()
                                )
                          );
            }

            return result;
        }

        public override void Insert(SpecialityItem entity)
        {
            try
            {
                SqlCommand com = base._cnn.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "insert_speciality";
                com.Parameters.AddWithValue("@name", entity.Name);
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
                com.CommandText = "delete_speciality";
                com.Parameters.AddWithValue("@id", id);

                com.ExecuteNonQuery();
            }
            catch (Exception e) { throw e; }
        }

        public override void Update(SpecialityItem entity)
        {
            try
            {
                SqlCommand com = base._cnn.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "update_speciality";
                //@id int, @name varchar(50),@year_in date,  @year_out date, @speciality_id  int
                com.Parameters.AddWithValue("@id", entity.Id);
                com.Parameters.AddWithValue("@name", entity.Name);
                com.ExecuteNonQuery();
            }
            catch (Exception e) { throw e; }
        }

        public override SpecialityItem GetOneById(int id)
        {
            try
            {
                SqlCommand com = base._cnn.CreateCommand();
                com.CommandType = CommandType.Text;
                //select g.SpecialityName, g.SpecialityIn, g.SpecialityOut, s.SpecialityName, s.SpecialityId
                com.CommandText = "select top 1 * from get_Speciality_by_id " + id;
                var dr = com.ExecuteReader();
                return new SpecialityItem(
                        id,
                        dr["SpecialityName"].ToString()
                                );
            }
            catch (Exception e) { throw e; }

        }
    }
}
