using DeaneryLibrary;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
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
    /// Логика взаимодействия для GroupWindow.xaml
    /// </summary>
    public partial class GroupWindow : Window
    {
        public static List<DeaneryLibrary.GroupItem> Groups { set; get; }
        public DeaneryLibrary.GroupItem SelectedGroup { set; get; }
        private GroupRepository _repo = new GroupRepository();


        public GroupWindow()
        {
            InitializeComponent();
            Groups = _repo.GetAll();
            DataContext = this;

        }

        private void ShowGroupEditWindow(object sender, RoutedEventArgs e)
        {
            GroupEditWindow gw = new GroupEditWindow(SelectedGroup);
            DataContext = gw;
            gw.Show();
            DataContext = this;
        }

        private void MenuItem_Click_Delete(object sender, RoutedEventArgs e)
        {
            MessageBoxResult res =  MessageBox.Show("Действительно удалить?", "Внимание", MessageBoxButton.OKCancel);

            if (res == MessageBoxResult.OK) 
            {
                _repo.Delete(SelectedGroup.Id);
                DataContext = this;
            }

        }

        private void ShowGroupInsertWindow(object sender, RoutedEventArgs e)
        {
            GroupInsertWindow gw = new GroupInsertWindow();
            DataContext = gw;
            gw.Show();
            DataContext = this;
        }

        private void ShowStudentWindow(object sender, RoutedEventArgs e)
        {
            StudentByGroupWindow gw = new StudentByGroupWindow(SelectedGroup);
            DataContext = gw;
            gw.Show();
            DataContext = this;
        }

        private void ShowSubjectWindow(object sender, RoutedEventArgs e)
        {
            SubjectWindow w = new SubjectWindow(SelectedGroup);
            DataContext = w;
            w.Show();
            DataContext = this;
        }

        private void ShowSubjectWindow(object sender, MouseButtonEventArgs e)
        {
            SubjectWindow w = new SubjectWindow(SelectedGroup);
            DataContext = w;
            w.Show();
            DataContext = this;
        }
    }
}
