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
    /// Логика взаимодействия для SheetWindow.xaml
    /// </summary>
    public partial class SheetWindow : Window
    {
        public static List<SheetItem> Sheets { set; get; }
        public SheetItem SelectedSheet { set; get; }

        public SheetWindow(int g_id, int s_id)
        {
            InitializeComponent();
            Sheets = new SheetRepository().GetSheetsByGroupAndSubject(g_id, s_id);
            DataContext = this;
        }

        private void ShowSheetListWindow(object sender, MouseButtonEventArgs e)
        {
            SheetGradeWindow w = new SheetGradeWindow(SelectedSheet);
            DataContext = w;
            w.Show();
            DataContext = this;

        }
    }
}
