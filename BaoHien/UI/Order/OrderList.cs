﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using DAL;
using BaoHien.Services.Orders;
using BaoHien.Services.Customers;
using DAL.Helper;
using BaoHien.Services.SystemUsers;
using BaoHien.Model;
using BaoHien.Common;
using BaoHien.Services.Employees;
using BaoHien.Services.OrderDetails;
using BaoHien.Services.ProductLogs;

namespace BaoHien.UI
{
    public partial class OrderList : UserControl
    {
        List<Customer> customers;
        List<SystemUser> systemUsers;

        public OrderList()
        {
            InitializeComponent();
        }

        private void OrderList_Load(object sender, EventArgs e)
        {
            dtpFrom.Value = DateTime.Today.AddDays(-DateTime.Now.Day + 1);
            dtpFrom.CustomFormat = BHConstant.DATE_FORMAT;
            dtpTo.CustomFormat = BHConstant.DATE_FORMAT;
            loadOrderList();
            SetupColumns();
        }

        public void loadOrderList()
        {
            loadSomeData();
            OrderService orderService = new OrderService();
            List<Order> orders = orderService.GetOrders();
            setUpDataGrid(orders);            
        }

        private void loadSomeData()
        {
            CustomerService customerService = new CustomerService();
            customers = customerService.GetCustomers().OrderBy(x => x.CustCode).ToList();
            customers.Insert(0, new Customer() { Id = 0, CustomerName = "Tất cả", CustCode = "Tất cả" });

            cbmCustomers.AutoCompleteMode = AutoCompleteMode.SuggestAppend;
            cbmCustomers.AutoCompleteSource = AutoCompleteSource.ListItems;
            cbmCustomers.DataSource = customers;
            cbmCustomers.DisplayMember = "CustCode";
            cbmCustomers.ValueMember = "Id";

            SystemUserService systemUserService = new SystemUserService();
            systemUsers = systemUserService.GetSystemUsers();
            systemUsers.Add(new SystemUser() { Id = 0, FullName = "Tất cả" });
            systemUsers = systemUsers.OrderBy(x => x.Id).ToList();

            cbmUsers.DataSource = systemUsers;
            cbmUsers.DisplayMember = "FullName";
            cbmUsers.ValueMember = "Id";
        }

        private void setUpDataGrid(List<Order> orders)
        {
            dgwOrderList.AutoGenerateColumns = false;
            if (orders != null)
            {
                var query = from order in orders
                            select new
                            {
                                Id = order.Id,
                                OrderCode = order.OrderCode,
                                Note = order.Note,
                                Total = Global.formatCurrencyTextWithoutMask(order.Total.ToString()),
                                TotalInCurrency = order.Total,
                                VAT = Global.formatCurrencyTextWithoutMask(order.VAT.ToString()),
                                CustomerName = order.Customer != null ? order.Customer.CustomerName : "",
                                CustomerCode = order.Customer != null ? order.Customer.CustCode : "",
                                Discount = Global.formatCurrencyTextWithoutMask(order.Discount.ToString()),
                                CreatedDate = order.CreatedDate.ToString(BHConstant.DATE_FORMAT),
                                UserId = order.SystemUser.FullName
                            };
                dgwOrderList.DataSource = query.ToList();
                lblTotalResult.Text = orders.Count.ToString();
                lbTotal.Text = Global.formatVNDCurrencyText(query.Select(x => x.TotalInCurrency).Sum().ToString());
            }
        }

        private void SetupColumns()
        {
            dgwOrderList.AutoGenerateColumns = false;

            dgwOrderList.Columns.Add(Global.CreateCell("CreatedDate", "Ngày", 100));
            dgwOrderList.Columns.Add(Global.CreateCell("OrderCode", "Mã đặt hàng", 100));
            dgwOrderList.Columns.Add(Global.CreateCell("CustomerName", "Khách hàng", 200));
            dgwOrderList.Columns.Add(Global.CreateCell("CustomerCode", "Mã khách hàng", 150));
            dgwOrderList.Columns.Add(Global.CreateCell("Note", "Ghi chú", 200));
            dgwOrderList.Columns.Add(Global.CreateCellWithAlignment("VAT", "VAT", 100, DataGridViewContentAlignment.MiddleRight));
            dgwOrderList.Columns.Add(Global.CreateCellWithAlignment("Discount", "Khấu chi", 100, DataGridViewContentAlignment.MiddleRight));
            dgwOrderList.Columns.Add(Global.CreateCellWithAlignment("Total", "Tổng", 100, DataGridViewContentAlignment.MiddleRight));
            dgwOrderList.Columns.Add(Global.CreateCellDeleteAction());
        }

        private void dgwOrderList_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (sender is DataGridView)
            {
                DataGridViewCell cell = ((DataGridView)sender).CurrentCell;
                if (cell.ColumnIndex == ((DataGridView)sender).ColumnCount - 1)
                {
                    if (Global.isAdmin())
                    {
                        DeleteOrder(e);
                    }
                    else
                    {
                        MessageBox.Show("Vui lòng đăng nhập quyền Admin để xóa được phiếu bán hàng!", "Lỗi phân quyền", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    }
                }

            }
        }

        private void dgwOrderList_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            AddOrder frmAddOrder = new AddOrder();
            DataGridViewRow currentRow = dgwOrderList.Rows[e.RowIndex];

            int id = ObjectHelper.GetValueFromAnonymousType<int>(currentRow.DataBoundItem, "Id");
            frmAddOrder.loadDataForEditOrder(id);

            frmAddOrder.CallFromUserControll = this;
            frmAddOrder.ShowDialog();
        }
        
        private void btnSearch_Click(object sender, EventArgs e)
        {
            OrderSearchCriteria search = new OrderSearchCriteria
            {
                Code = string.IsNullOrEmpty(txtCode.Text) ? txtCode.Text.ToLower() : "",
                CreatedBy = (cbmUsers.SelectedValue != null && cbmUsers.SelectedIndex != 0) ? (int?)cbmUsers.SelectedValue : (int?)null,
                Customer = (cbmCustomers.SelectedValue != null && cbmCustomers.SelectedIndex != 0) ? (int?)cbmCustomers.SelectedValue : (int?)null,
                From = dtpFrom.Value != null ? dtpFrom.Value : (DateTime?)null,
                To = dtpTo.Value != null ? dtpTo.Value.AddDays(1).Date : (DateTime?)null,
            };
            OrderService service = new OrderService();
            List<Order> orders = service.SearchingOrder(search);
            setUpDataGrid(orders);
        }

        private void DeleteOrder(DataGridViewCellEventArgs e)
        {
            DialogResult result = MessageBox.Show("Bạn muốn xóa đơn hàng này?", "Xoá đơn hàng", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (result == DialogResult.Yes)
            {
                DataGridViewRow currentRow = dgwOrderList.Rows[e.RowIndex];

                OrderService orderService = new OrderService();
                int id = ObjectHelper.GetValueFromAnonymousType<int>(currentRow.DataBoundItem, "Id");
                Order order = orderService.GetOrder(id);
                DateTime systime = BaoHienRepository.GetBaoHienDBDataContext().GetSystemDate();

                #region CustomerLog

                CustomerLogService cls = new CustomerLogService();
                CustomerLog cl = cls.GetCustomerLog(order.OrderCode);
                bool kq = true;
                if (cl != null)
                    kq = cls.DeleteCustomerLog(cl.Id);

                #endregion

                #region ProductLog

                ProductLogService productLogService = new ProductLogService();
                OrderDetailService orderDetailService = new OrderDetailService();
                List<OrderDetail> details = orderDetailService.SelectOrderDetailByWhere(x => x.OrderId == order.Id).ToList();
                ProductLog pl, newpl;
                foreach (OrderDetail item in details)
                {
                    pl = productLogService.GetProductLog(item.ProductId, item.AttributeId, item.UnitId);
                    newpl = new ProductLog()
                    {
                        ProductId = item.ProductId,
                        AttributeId = item.AttributeId,
                        UnitId = item.UnitId,
                        BeforeNumber = pl.AfterNumber,
                        Amount = item.NumberUnit,
                        AfterNumber = pl.AfterNumber + item.NumberUnit,
                        RecordCode = order.OrderCode,
                        Status = BHConstant.DEACTIVE_STATUS,
                        Direction = BHConstant.DIRECTION_IN,
                        UpdatedDate = systime
                    };
                    productLogService.AddProductLog(newpl);
                }
                productLogService.DeactiveProductLog(order.OrderCode);

                #endregion

                #region EmployeeLog

                int salerId = (int)order.Customer.SalerId;
                if (salerId > 0)
                {
                    EmployeeLogService els = new EmployeeLogService(); 
                    EmployeeLog order_el = els.SelectEmployeeLogByWhere(x => x.RecordCode == order.OrderCode).FirstOrDefault();
                    if(order_el != null)
                        els.DeleteEmployeeLog(order_el.Id);
                }

                #endregion

                if (!orderService.DeleteOrder(id) && kq)
                {
                    MessageBox.Show("Hiện tại hệ thống đang có lỗi. Vui lòng thử lại sau!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                loadOrderList();
            }
        }

        private void cbmCustomers_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbmCustomers.SelectedValue != null)
            {
                Customer cm = null;
                if (cbmCustomers.SelectedValue is Customer)
                    cm = (Customer)cbmCustomers.SelectedValue;
                else
                    cm = customers.Where(x => x.Id == (int)cbmCustomers.SelectedValue).FirstOrDefault();
                if (cm != null)
                {
                    lbCustomerName.Text = cm.CustomerName;
                }
            }
        }

        private void dgwOrderList_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
        {
            DataGridView gridView = sender as DataGridView;
            if (null != gridView)
            {
                gridView.AutoResizeRowHeadersWidth(DataGridViewRowHeadersWidthSizeMode.AutoSizeToDisplayedHeaders);
                foreach (DataGridViewRow r in gridView.Rows)
                {
                    gridView.Rows[r.Index].HeaderCell.Value = (r.Index + 1).ToString();
                }
            }
        }

        private void cbmCustomers_KeyDown(object sender, KeyEventArgs e)
        {
            Global.DisableDropDownWhenSuggesting(cbmCustomers);
        }
    }
}
