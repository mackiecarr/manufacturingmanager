﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using DAL;
using BaoHien.Services.SystemUsers;
using BaoHien.Services;
using DAL.Helper;
using BaoHien.Model;
using BaoHien.Services.ProductLogs;
using BaoHien.Common;
using BaoHien.Services.ProductInStocks;

namespace BaoHien.UI
{
    public partial class StockEntranceList : UserControl
    {
        List<EntranceStock> entranceStocks;
        List<SystemUser> systemUsers;

        public StockEntranceList()
        {
            InitializeComponent();
        }

        private void loadSomeData()
        {
            SystemUserService systemUserService = new SystemUserService();
            systemUsers = systemUserService.GetSystemUsers();
            systemUsers.Add(new SystemUser() { Id = 0, FullName = "Tất cả" });
            systemUsers = systemUsers.OrderBy(x => x.Id).ToList();

            cbmUsers.DataSource = systemUsers;
            cbmUsers.DisplayMember = "FullName";
            cbmUsers.ValueMember = "Id";
        }

        private void setUpDataGrid(List<EntranceStock> entranceStocks)
        {
            dgwStockEntranceList.AutoGenerateColumns = false;
            if (entranceStocks != null)
            {
                var query = from entranceStock in entranceStocks
                            select new
                            {
                                Id = entranceStock.Id,
                                Note = entranceStock.Note,
                                EntranceCode = entranceStock.EntranceCode,
                                CreatedDate = entranceStock.CreatedDate.ToString(BHConstant.DATE_FORMAT),
                                UserId = entranceStock.SystemUser.FullName
                            };
                dgwStockEntranceList.DataSource = query.ToList();
                productionRequestInTotal.Text = query.Count().ToString();
            }
        }

        private void SetupColumns()
        {
            dgwStockEntranceList.AutoGenerateColumns = false;

            dgwStockEntranceList.Columns.Add(Global.CreateCell("CreatedDate", "Ngày tạo", 100));
            dgwStockEntranceList.Columns.Add(Global.CreateCell("EntranceCode", "Mã nhập kho", 150));
            dgwStockEntranceList.Columns.Add(Global.CreateCell("UserId", "Người tạo", 200));
            dgwStockEntranceList.Columns.Add(Global.CreateCell("Note", "Ghi chú", 300));
            dgwStockEntranceList.Columns.Add(Global.CreateCellDeleteAction());
        }

        public void loadEntranceStockList()
        {
            loadSomeData();
            EntranceStockService entranceStockService = new EntranceStockService();
            List<EntranceStock> entranceStocks = entranceStockService.GetEntranceStocks();
            setUpDataGrid(entranceStocks);
        }

        private void StockEntranceList_Load(object sender, EventArgs e)
        {
            dtpFrom.Value = DateTime.Today.AddDays(-DateTime.Now.Day + 1);
            dtpFrom.CustomFormat = BHConstant.DATE_FORMAT;
            dtpTo.CustomFormat = BHConstant.DATE_FORMAT;
            loadEntranceStockList();
            SetupColumns();
        }

        private void dgwStockEntranceList_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (sender is DataGridView)
            {
                DataGridViewCell cell = ((DataGridView)sender).CurrentCell;
                if (cell.ColumnIndex == ((DataGridView)sender).ColumnCount - 1)
                {
                    DialogResult result = MessageBox.Show("Bạn có muốn xóa phiếu nhập kho này?",
                    "Xoá phiếu nhập kho",
                     MessageBoxButtons.YesNo,
                    MessageBoxIcon.Question);
                    if (result == DialogResult.Yes)
                    {
                        DateTime systime = BaoHienRepository.GetBaoHienDBDataContext().GetSystemDate();
                        DataGridViewRow currentRow = dgwStockEntranceList.Rows[e.RowIndex];

                        EntranceStockService entranceStockService = new EntranceStockService();
                        int id = ObjectHelper.GetValueFromAnonymousType<int>(currentRow.DataBoundItem, "Id");
                        EntranceStock es = entranceStockService.GetEntranceStock(id);

                        ProductLogService productLogService = new ProductLogService();
                        EntranceStockDetailService entranceStockDetailService = new EntranceStockDetailService();
                        List<EntranceStockDetail> details = entranceStockDetailService.SelectEntranceStockDetailByWhere(x => x.EntranceStockId == es.Id).ToList();
                        foreach (EntranceStockDetail esd in details)
                        {
                            ProductLog pl = productLogService.GetProductLog(esd.ProductId, esd.AttributeId, esd.UnitId);
                            if (pl != null)
                            {
                                pl.UpdatedDate = systime;
                                pl.Amount -= esd.NumberUnit;
                                if (pl.Amount < 0)
                                    pl.Amount = 0;
                                productLogService.UpdateProductLog(pl);
                            }
                            entranceStockDetailService.DeleteEntranceStockDetail(esd.Id);
                        }
                        if (!entranceStockService.DeleteEntranceStock(id))
                        {
                            MessageBox.Show("Hiện tại hệ thống đang có lỗi. Vui lòng thử lại sau!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }
                        loadEntranceStockList();
                    }

                }

            }
        }

        private void dgwStockEntranceList_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            AddEntranceStock frmAddEntranceStock = new AddEntranceStock();
            DataGridViewRow currentRow = dgwStockEntranceList.Rows[e.RowIndex];

            int id = ObjectHelper.GetValueFromAnonymousType<int>(currentRow.DataBoundItem, "Id");
            frmAddEntranceStock.loadDataForEditEntranceStock(id);

            frmAddEntranceStock.CallFromUserControll = this;
            frmAddEntranceStock.ShowDialog();
        }

        private void btnSearch_Click(object sender, EventArgs e)
        {
            EntranceStockSearchCriteria entranceStockSearchCriteria = new EntranceStockSearchCriteria
            {
                Code = txtCode.Text != null ? txtCode.Text.ToLower() : "",
                CreatedBy = (cbmUsers.SelectedValue != null && cbmUsers.SelectedIndex != 0) ? (int?)cbmUsers.SelectedValue : (int?)null,
                From = dtpFrom.Value != null ? dtpFrom.Value : (DateTime?)null,
                To = dtpTo.Value != null ? dtpTo.Value.AddDays(1).Date : (DateTime?)null,
            };
            EntranceStockService entranceStockService = new EntranceStockService();
            List<EntranceStock> entranceStocks = entranceStockService.SearchingEntranceStock(entranceStockSearchCriteria);
            if (entranceStocks == null)
            {
                entranceStocks = new List<EntranceStock>();
            }
            setUpDataGrid(entranceStocks);
        }

        private void dgwStockEntranceList_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
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
    }
}
