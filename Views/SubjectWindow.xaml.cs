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
    /// Логика взаимодействия для SubjectWindow.xaml
    /// </summary>
    public partial class SubjectWindow : Window
    {

        public List<SubjectItem> Subjects { set; get; }
        public SubjectItem SelectedSubject { set; get; }

        private int _group_id;

        public SubjectWindow(DeaneryLibrary.GroupItem group)
        {
            InitializeComponent();
            Subjects = new SubjectRepository().GetSubjectsByGroupId(group.Id);
            _group_id = group.Id;
            DataContext = this;
        }

       
        private void ShowSheetWindow(object sender, MouseButtonEventArgs e)
        {
            SheetWindow w = new SheetWindow(_group_id, SelectedSubject.Id);
            DataContext = w;
            w.Show();
            DataContext = this;
        }
    }
}
