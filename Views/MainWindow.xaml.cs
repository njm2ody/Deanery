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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Views
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void ShowGroupWindow(object sender, RoutedEventArgs e)
        {
            GroupWindow gw = new GroupWindow();
            DataContext = gw;

            gw.Show();

            DataContext = this;
        }

        private void ShowStudentWindow(object sender, RoutedEventArgs e)
        {
            StudentWindow w = new StudentWindow();
            DataContext = w;
            w.Show(); w.Activate();
            DataContext = this;
        }

        private void ShowTeacherWindow(object sender, RoutedEventArgs e)
        {
            TeacherWindow w = new TeacherWindow();
            DataContext = w;

            w.Show();

            DataContext = this;
        }
    }
}
