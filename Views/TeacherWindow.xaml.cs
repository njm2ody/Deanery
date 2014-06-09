using DeaneryLibrary;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace Views
{
    /// <summary>
    /// Логика взаимодействия для TeacherWindow.xaml
    /// </summary>
    public partial class TeacherWindow : Window
    {
        public static List<TeacherItem> Teachers { set; get; }
        public DeaneryLibrary.TeacherItem SelectedTeacher { set; get; }
        private TeacherRepository _repo = new TeacherRepository();


        public TeacherWindow()
        {
            InitializeComponent();
            Teachers = _repo.GetAll();
            DataContext = this;

        }
    }
}
