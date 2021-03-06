﻿using DeaneryLibrary;
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
    /// Логика взаимодействия для StudentByGroupWindow.xaml
    /// </summary>
    public partial class StudentByGroupWindow : Window
    {
        public static List<StudentItem> Students { set; get; }
        public StudentItem SelectedStudent { set; get; }
        private StudentRepository _repo = new StudentRepository();

        public DeaneryLibrary.GenericItem Group { set; get; }

        public StudentByGroupWindow(DeaneryLibrary.GenericItem group)
        {
            InitializeComponent();
            Students = _repo.GetStudentByGroupId(group.Id);
            DataContext = this;
            Group = group;

        }

        private void ShowStudentEditWindow(object sender, RoutedEventArgs e)
        {
            StudentEditWindow gw = new StudentEditWindow(SelectedStudent);
            DataContext = gw;
            gw.Show();
            DataContext = this;
        }

        private void MenuItem_Click_Delete(object sender, RoutedEventArgs e)
        {
            MessageBoxResult res =  MessageBox.Show("Действительно удалить?", "Внимание", MessageBoxButton.OKCancel);

            if (res == MessageBoxResult.OK) 
            {
                _repo.Delete(SelectedStudent.Id);
                DataContext = this;
            }

        }

        private void ShowStudentInsertWindow(object sender, RoutedEventArgs e)
        {
            StudentInsertWindow gw = new StudentInsertWindow();
            DataContext = gw;
            gw.Show();
            DataContext = this;
        }
    }
}
