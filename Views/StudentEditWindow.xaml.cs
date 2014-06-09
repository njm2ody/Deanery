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
    /// Логика взаимодействия для StudentEditWindow.xaml
    /// </summary>
    public partial class StudentEditWindow : Window
    {
        public StudentItem Student { set; get; }

        public DeaneryLibrary.GroupItem  SelectedGroup { set; get; }
        public List<DeaneryLibrary.GroupItem> Groups { set; get; }

        private StudentRepository _repo = new StudentRepository();

        public StudentEditWindow(StudentItem item)
        {
            InitializeComponent();
            Student = item;
            Groups = new GroupRepository().GetAll();
            SelectedGroup = Groups[0];
            //SelectedGroup = new DeaneryLibrary.GroupItem();
            //SelectedGroup.Id = item.GroupId; SelectedGroup.Name = item.GroupName;
            DataContext = this;
        }

        private void ClickOK(object sender, RoutedEventArgs e)
        {
            if (SelectedGroup != null)
            {
                Student.GroupId = SelectedGroup.Id;
                Student.GroupName = SelectedGroup.Name;
                _repo.Update(Student);
                this.Close();
            }
            else {
                MessageBoxResult res = MessageBox.Show("Выберите группу", "Внимание", MessageBoxButton.OK);
                DataContext = this;
            }
        }

        private void ClickCancel(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
