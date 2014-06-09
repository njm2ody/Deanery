using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
   public  class GradeRepository : GenericRepository<GradeItem>
    {
       public List<GradeItem> GetGradeBySheetId(int id)
       {
           List<GradeItem> result = new List<GradeItem>();
           try
           {
               StudentRepository _repo = new StudentRepository();

               SqlCommand com = base._cnn.CreateCommand();
               com.CommandType = CommandType.Text;
               com.CommandText = "select top 1000 * from get_grade_by_sheet_id(" + id + ")";

               SqlDataReader dr = com.ExecuteReader();
               /*
                g.GradeId, t.TypeOfGradeName as [Type],
                g.GradeValue, 
                s.StudentId, s.StudentFirstName, s.StudentMiddleName, s.StudentLastName
                * int id, string type, int value, StudentItem student
                */
               while (dr.Read())
               {
                   StudentItem s =  _repo.GetOneById(  (int)dr["StudentId"]  );

                  result.Add( 
                       new GradeItem(

                           (int)dr["GradeId"],
                           dr["Type"].ToString(),
                           (int)dr["GradeValue"],
                            s       
                                )
                                  );

               }
           }
           catch (Exception e) { throw e; }
           return result;
       }

       public override void Insert(GradeItem entity)
       {
          
       }
    }
}
