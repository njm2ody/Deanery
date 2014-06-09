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
    /// Логика взаимодействия для SheetGradeWindow.xaml
    /// </summary>
    public partial class SheetGradeWindow : Window
    {
        public SheetItem Sheet { private set;  get; }
        public List<GradeItem> Grades { private set; get; }

        private GradeRepository _repo = new GradeRepository();

        public SheetGradeWindow(SheetItem sheet)
        {
            InitializeComponent();
            Sheet = sheet;
            Grades = _repo.GetGradeBySheetId(sheet.Id);
            DataContext = this;
            
        }

        private void ShowGradeEditWindow(object sender, RoutedEventArgs e)
        {
            var w = new GradeEditWindow();
            DataContext = w;
            w.Show();
        }

        private void ShowGradeInsertWindow(object sender, RoutedEventArgs e)
        {

        }

        private void DeleteGrade(object sender, RoutedEventArgs e)
        {

        }
    }
}
