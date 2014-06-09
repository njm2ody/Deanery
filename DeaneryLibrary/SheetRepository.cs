using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DeaneryLibrary
{
    public class SheetRepository : GenericRepository<SheetItem>
    {
        private SheetItem _ParseSQL(SqlDataReader dr)
        {
                 TeacherItem t = new TeacherItem(
                                        (int)dr["TeacherId"],
                                            dr["TeacherFirstName"].ToString(),
                                            dr["TeacherMiddleName"].ToString(),
                                            dr["TeacherLastName"].ToString(),
                                       (int)dr["ChairId"],
                                            dr["ChairName"].ToString()
                                            );

                    SubjectItem sub =  new SubjectItem(
                                        (int)dr["SubjectInCurriculumId"], dr["SubjectName"].ToString(),
                                        (int)dr["CountOfHours"], (int)dr["Course"], (int)dr["Semester"],
                                         new FormOfControlItem((int)dr["FormOfControlId"], dr["FormOfControlName"].ToString()));


                  SheetItem s = new SheetItem( (int)dr["SheetId"],
                                                          sub,
                                                            t,

                                                 (DateTime)dr["DateSet"],
                                                 (DateTime)dr["DateGet"],
                                                new FormOfControlItem((int)dr["FormOfControlId"],
                                                dr["FormOfControlName"].ToString())

                                                );
                  return s;
        }


        public List<SheetItem> GetSheetsByGroupAndSubject(int g_id, int s_id)
        {
            List<SheetItem> result = new List<SheetItem>();
            try
            {
                SqlCommand com = base._cnn.CreateCommand();
                com.CommandType = CommandType.Text;
                com.CommandText = "select top 1000 * from get_sheet_by_group_and_subject_id(" + g_id + ", " + s_id + ")";

                GroupRepository _repo = new GroupRepository();
                GroupItem g = _repo.GetOneById(g_id);
                SqlDataReader dr = com.ExecuteReader();
               
                while ( dr.Read())
                {

                    /*
                     *   s.SheetId,
                         s.SheetDateSet as DateSet,
                         s.SheetDateGet as DateGet, 
                         f.FormOfControlId, f.FormOfControlName,
                         t.TeacherId, t.TeacherFirstName, t.TeacherMiddleName, t.TeacherLastName, t.FK_TeacherChair, chairName
                         sc.SubjectInCurriculumId,
                         sc.SubjectInCurriculumCourse as Course, 
                         sc.SubjectInCurriculumSemester as Semester,
                         sc.SubjectInCurriculumCountOfHours as CountOfHours,
                         sub.SubjectId, sub.SubjectName*/


                    //int id, SubjectItem subject, TeacherItem teacher, DateTime date_set, DateTime date_get, FormOfControlItem control

                    SheetItem s = _ParseSQL(dr);
                    s.GroupName = g.Name;
                    s.GroupId = g.Id;
                    result.Add(s);

                   // result.Add(_ParseSQL(dr));

                }
            }
            catch (Exception e) { throw e; }

            return result;
        }

        public List<SheetItem> GetSheetByGroup(int g_id)
        {
            List<SheetItem> result = new List<SheetItem>();
            try
            {
                SqlCommand com = base._cnn.CreateCommand();
                com.CommandType = CommandType.Text;
                com.CommandText = "select top 1000 * from get_sheet_by_group_id(" + g_id + ")";

                SqlDataReader dr = com.ExecuteReader();

                while (dr.Read())
                {
                   // result.Add(_ParseSQL(dr));

                    result.Add(_ParseSQL(dr));



                }
            }
            catch (Exception e) { throw e; }

            return result;
        }


    }
}
