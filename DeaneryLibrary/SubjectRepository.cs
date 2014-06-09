using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
   public  class SubjectRepository : GenericRepository<SubjectItem>
    {

       public List<SubjectItem> GetSubjectsByGroupId(int id)
       {
           List<SubjectItem> result = new List<SubjectItem>();


           SqlCommand com = base._cnn.CreateCommand();
           com.CommandType = CommandType.Text;
           com.CommandText = "select top 1000 * from get_subject_by_group_id ( " + id +" )";
           /*   
            * s.SubjectId, s.SubjectName, 
			  sc.SubjectInCurriculumId,
			  sc.SubjectInCurriculumCourse as Course,
			  sc.SubjectInCurriculumSemester as Semester, 
			  sc.SubjectInCurriculumCountOfHours as CountOfHours, 
			  f.FormOfControlId, f.FormOfControlName
            */
           // SubjectItem(int id, string name, int hours, int course, int semester, FormOfControlItem form_control)
           SqlDataReader dr = com.ExecuteReader();

           while (dr.Read())
           {
               result.Add(
                  new SubjectItem(
                      (int) dr["SubjectInCurriculumId"],
                        dr["SubjectName"].ToString(),
                        (int)dr["CountOfHours"],
                        (int)dr["Course"],
                        (int)dr["Semester"],
                        new FormOfControlItem((int)dr["FormOfControlId"], dr["FormOfControlName"].ToString())
                       
                       )
                    
                   );
                  
           }


           return result;
       }
    }
}
