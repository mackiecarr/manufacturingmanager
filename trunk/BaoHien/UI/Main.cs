﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using DAL;
using BaoHien.Common;
using BaoHien.Services.SystemUsers;

namespace BaoHien.UI
{
    public partial class Main : Form
    {
        
        public Main()
        {
            InitializeComponent();
        }

        #region Menu Navigation

        private void menuProductType_Click(object sender, EventArgs e)
        {
            ucProductType productType = new ucProductType();
            pnlMain.Controls.Clear();
            pnlMain.Controls.Add(productType);
        }

        private void menuExit_Click(object sender, EventArgs e)
        {
            Application.Exit();
        }

        private void menuLogout_Click(object sender, EventArgs e)
        {
            this.Hide();
            Form main = new Login();
            main.ShowDialog();
            this.Close();
        }

        private void menuProduct_Click(object sender, EventArgs e)
        {
            ProductList productList = new ProductList();
            pnlMain.Controls.Clear();
            pnlMain.Controls.Add(productList);
        }


        private void menuMeasurementUnit_Click(object sender, EventArgs e)
        {
            BaseUnitList ucBaseUnitList = new BaseUnitList();
            pnlMain.Controls.Clear();
            pnlMain.Controls.Add(ucBaseUnitList);
        }

        private void menuAttribute_Click(object sender, EventArgs e)
        {
            ProductAttributeList ucAttributeList = new ProductAttributeList();
            pnlMain.Controls.Clear();
            pnlMain.Controls.Add(ucAttributeList);
        }

        private void menuCustomer_Click(object sender, EventArgs e)
        {
            CustomerList ucCustomerlist = new CustomerList();
            pnlMain.Controls.Clear();
            pnlMain.Controls.Add(ucCustomerlist);
        }

        private void menuSystemUser_Click(object sender, EventArgs e)
        {
            SystemUserList ucSystemUser = new SystemUserList();
            pnlMain.Controls.Clear();
            pnlMain.Controls.Add(ucSystemUser);
        }

        private void menuChangePass_Click(object sender, EventArgs e)
        {
            ChangePassword frmChangePass = new ChangePassword();
            frmChangePass.ShowDialog();

        }

        private void menuEmployee_Click(object sender, EventArgs e)
        {
            EmployeeList ucEmLst = new EmployeeList();
            pnlMain.Controls.Clear();
            pnlMain.Controls.Add(ucEmLst);
        }

        private void menuOrder_Click(object sender, EventArgs e)
        {
            OrderList ucOrderList = new OrderList();
            pnlMain.Controls.Clear();
            pnlMain.Controls.Add(ucOrderList);
        }
        #endregion 

#region toolbar action
        private void tsbAddProduct_Click(object sender, EventArgs e)
        {
            AddProduct frmAddProduct = new AddProduct();
            frmAddProduct.ShowDialog();

        }

        private void tsbAddCustomer_Click(object sender, EventArgs e)
        {
            AddCustomer frmAddCustomer = new AddCustomer();
            frmAddCustomer.ShowDialog();
        }

        private void tsbAddOrder_Click(object sender, EventArgs e)
        {
            AddOrder frmAddOrder = new AddOrder();
            frmAddOrder.ShowDialog();
        }
#endregion

        private void Main_Load(object sender, EventArgs e)
        {
            if (Global.CurrentUser == null)
            {
                SystemUserService systemUserService = new SystemUserService();
                //SystemUser user = systemUserService.GetSystemUsers().Single(u => (u.username == DUMMY_USERNAME) && (u.password == DUMMY_PASSWORD));
                SystemUser user = systemUserService.GetSystemUser(1);
                Global.CurrentUser = user;
            }
        }

        

        

        

        

        

        

        

        

        

        

       

    }
}
