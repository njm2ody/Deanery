using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
    public class GroupRepository : GenericRepository<GroupItem>
    {
        public override List<GroupItem> GetAll()
        {
            List<GroupItem> result = new List<GroupItem>();

            SqlCommand com = base._cnn.CreateCommand();
            com.CommandType = CommandType.StoredProcedure;
            com.CommandText = "get_group_with_speciality";

            SqlDataReader dr = com.ExecuteReader();

            while (dr.Read())
            {
                result.Add(
                    new GroupItem(
                        (int)dr["GroupId"],
                        dr["GroupName"].ToString(),
                        (DateTime) dr["GroupIn"], 
                        (DateTime) dr["GroupOut"],
                        (int)dr["SpecialityId"],
                        dr["SpecialityName"].ToString()
                                )
                          );
            }

            return result;
        }

        public override void Insert(GroupItem entity)
        {
            try
            {
                SqlCommand com = base._cnn.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "insert_group";
                com.Parameters.AddWithValue("@name", entity.Name);
                com.Parameters.AddWithValue("@speciality_id", entity.SpecialityId);
                com.Parameters.AddWithValue("@year_in", entity.DateIn);
                com.Parameters.AddWithValue("@year_out", entity.DateOut);

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
                com.CommandText = "delete_group";
                com.Parameters.AddWithValue("@id", id);

                com.ExecuteNonQuery();
            }
            catch (Exception e) { throw e; }
        }

        public override void Update(GroupItem entity)
        {
            try 
            {
                SqlCommand com = base._cnn.CreateCommand();
                com.CommandType = CommandType.StoredProcedure;
                com.CommandText = "update_group";
                //@id int, @name varchar(50),@year_in date,  @year_out date, @speciality_id  int
                com.Parameters.AddWithValue("@id", entity.Id);
                com.Parameters.AddWithValue("@name", entity.Name);
                com.Parameters.AddWithValue("@year_in", entity.DateIn);
                com.Parameters.AddWithValue("@year_out", entity.DateOut);
                com.Parameters.AddWithValue("@speciality_id", entity.SpecialityId);

                com.ExecuteNonQuery();
            }
            catch (Exception e) { throw e; }
        }

        public override GroupItem GetOneById(int id)
        {
            try
            {
                SqlCommand com = base._cnn.CreateCommand();
                com.CommandType = CommandType.Text;
                //select g.GroupName, g.GroupIn, g.GroupOut, s.SpecialityName, s.SpecialityId
                com.CommandText = "select top 1 * from get_group_by_id (" + id + ")";
                var dr = com.ExecuteReader();
                if (dr.Read())
                {
                    return new GroupItem(
                            id,
                            dr["GroupName"].ToString(),
                            (DateTime)dr["GroupIn"],
                            (DateTime)dr["GroupOut"],
                            (int)dr["SpecialityId"]
                                    );
                }
                else return new GroupItem();
            }catch(Exception e) {throw e;}
            
        }
    }
}
