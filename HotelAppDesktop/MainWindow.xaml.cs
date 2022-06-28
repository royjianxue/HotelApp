﻿using HotelAppLibrary.Data;
using HotelAppLibrary.Models;
using System;
using System.Collections.Generic;
using System.Windows;
using Microsoft.Extensions.DependencyInjection;
using System.Windows.Controls;



namespace HotelAppDesktop
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private readonly IDatabaseData _db;

        public MainWindow(IDatabaseData db)
        {
            InitializeComponent();
            _db = db;
        }

        private void searchForGuest_Click(object sender, RoutedEventArgs e)
        {
            List<BookingFullModel> bookings = _db.SearchBookings(lastNameText.Text);

            resultsList.ItemsSource = bookings; //assign the list to the bindings
            
        }
        private void CheckInButton_Click(object sender, RoutedEventArgs e)
        {
            var checkInForm = App.serviceProvider.GetService<CheckInForm>();
            var model = (BookingFullModel)((Button)e.Source).DataContext;

            checkInForm.PopulateCheckInInfo(model);

            checkInForm.Show();
        }


    }
}
