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
    /// Логика взаимодействия для GroupEditWindow.xaml
    /// </summary>
    public partial class GroupEditWindow : Window
    {
        public DeaneryLibrary.GroupItem Group { set; get; }
        public SpecialityItem SelectedSpeciality { set; get; }
        public List<SpecialityItem> Specialites { set; get; }

        private GroupRepository _repo = new GroupRepository();

        public GroupEditWindow(DeaneryLibrary.GroupItem item)
        {
            InitializeComponent();
            Group = item;
            Specialites = new SpecialityRepository().GetAll();
            SelectedSpeciality = Specialites[0];
            //SelectedSpeciality = new SpecialityItem(item.SpecialityId, item.SpecialityName);
            DataContext = this;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            Group.SpecialityId = SelectedSpeciality.Id;
            Group.SpecialityName = SelectedSpeciality.Name;
            _repo.Update(Group);
            this.Close();
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
    }
}
