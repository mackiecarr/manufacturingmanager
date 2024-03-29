﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Windows.Forms;
using BaoHien.UI.Base;
using DAL;
using BaoHien.Services.Orders;
using BaoHien.Services.Customers;
using BaoHien.Common;
using BaoHien.Services.Products;
using DAL.Helper;
using BaoHien.Services.OrderDetails;
using BaoHien.Services.ProductAttributes;
using BaoHien.Model;
using System.Drawing.Printing;
using System.IO;
using PDF = iTextSharp.text;
using iTextSharp.text.pdf;
using Microsoft.Win32;
using System.Diagnostics;
using BaoHien.Services.Employees;
using BaoHien.Services.MeasurementUnits;
using BaoHien.UI.PrintPreviewCustom;
using BaoHien.Services.Seeds;
using iTextSharp.text;
using BaoHien.Services.ProductLogs;

namespace BaoHien.UI
{
    public partial class AddOrder : BaseForm
    {
        bool isUpdating = false;
        Order order, old_order;
        ProductLogService productLogService;
        MeasurementUnitService unitService;
        BindingList<MeasurementUnit> units;
        BindingList<Customer> customers;
        BindingList<OrderDetail> orderDetails;
        List<OrderDetail> old_orderDetails;
        BindingList<ProductAttributeModel> productAttrs;
        double totalWithTax = 0.0, totalCommission = 0.0;

        int XKNumber = 0, BHNumber = 0;

        // Cell position
        const int ProductAttrCell = 0, NumberUnitCell = 1, UnitCell = 2, PriceCell = 3, CommissionCell = 4, TotalCell = 5, NoteCell = 6;

        public AddOrder()
        {
            InitializeComponent();
            DAL.Helper.BaoHienRepository.ResetDBDataContext();
        }

        private bool saveData()
        {
            calculateTotal();
            if (validator1.Validate() && ValidateData())
            {
                if (cbxCustomer.SelectedValue == null || cbxCustomer.SelectedIndex <= 0)
                {
                    MessageBox.Show("Bạn cần có một khách hàng cho phiếu này!");
                    return false;
                }
                DialogResult dialogResult = Preview();
                if (dialogResult == DialogResult.OK)
                {
                    XKNumber = PrintPreview.XKNumber;
                    BHNumber = PrintPreview.BHNumber;
                    double discount = 0;
                    Double.TryParse(txtDiscount.WorkingText, out discount);
                    DateTime createdDate = BaoHienRepository.GetBaoHienDBDataContext().GetSystemDate();

                    double vat = 0;
                    Double.TryParse(txtVAT.WorkingText, out vat);
                    int userId = 0;
                    if (Global.CurrentUser != null)
                    {
                        userId = Global.CurrentUser.Id;
                    }
                    else
                    {
                        MessageBox.Show("Hiện tại hệ thống đang có lỗi. Vui lòng thử lại sau!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        return false;
                    }
                    if (order != null)//update
                    {
                        #region Update

                        order.CustId = (int)cbxCustomer.SelectedValue;
                        order.Discount = discount;
                        order.Note = txtNote.Text;
                        order.VAT = vat;
                        order.OrderCode = txtOrderCode.Text;
                        order.Reason = txtReason.Text;
                        order.WareHouse = txtWare.Text;
                        order.Total = totalWithTax;
                        order.UpdatedDate = createdDate;

                        #region Update Order Detail

                        string msg = "";
                        int error = 0, amount_change = 0;
                        ProductLog pl, newpl;
                        OrderDetail prd;

                        // Check old data

                        OrderDetailService orderDetailService = new OrderDetailService();
                        List<OrderDetail> deleted_details = old_orderDetails.Where(x => !orderDetails.Select(y => y.ProductId.ToString() + '_' +
                            y.AttributeId.ToString() + '_' + y.UnitId.ToString()).Contains(x.ProductId.ToString() + '_' +
                            x.AttributeId.ToString() + '_' + x.UnitId.ToString())).ToList();
                        List<OrderDetail> updated_details = old_orderDetails.Where(x => orderDetails.Select(y => y.ProductId.ToString() + '_' +
                            y.AttributeId.ToString() + '_' + y.UnitId.ToString()).Contains(x.ProductId.ToString() + '_' +
                            x.AttributeId.ToString() + '_' + x.UnitId.ToString())).ToList();
                        List<OrderDetail> new_details = orderDetails.Where(x => !old_orderDetails.Select(y => y.ProductId.ToString() + '_' +
                            y.AttributeId.ToString() + '_' + y.UnitId.ToString()).Contains(x.ProductId.ToString() + '_' +
                            x.AttributeId.ToString() + '_' + x.UnitId.ToString())).ToList();
                        foreach (OrderDetail item in updated_details)
                        {
                            pl = productLogService.GetProductLog(item.ProductId, item.AttributeId, item.UnitId);
                            prd = orderDetails.Where(x => x.ProductId == item.ProductId && x.AttributeId == item.AttributeId &&
                                x.UnitId == item.UnitId).FirstOrDefault();
                            amount_change = Convert.ToInt32(prd.NumberUnit - item.NumberUnit);
                            if (amount_change > 0 && pl.AfterNumber - amount_change < 0) // Tang nguyen lieu
                            {
                                if (error == 0)
                                {
                                    msg += "Những sản phẩm sau đã bị SỬA nhưng không đảm bảo dữ liệu trong kho:\n";
                                    error = 1;
                                }
                                msg += "- " + productLogService.GetNameOfProductLog(pl) + " : " + amount_change.ToString() + "\n";
                            }
                        }
                        foreach (OrderDetail item in new_details)
                        {
                            pl = productLogService.GetProductLog(item.ProductId, item.AttributeId, item.UnitId);
                            if (pl.AfterNumber - item.NumberUnit < 0)
                            {
                                if (error < 2)
                                {
                                    msg += "Những sản phẩm sau không đủ số lượng để tạo phiếu bán hàng:\n";
                                    error = 2;
                                }
                                msg += "- " + productLogService.GetNameOfProductLog(pl) + " còn : " + pl.AfterNumber + "\n";
                            }
                        }

                        if (error > 0)
                        {
                            MessageBox.Show(msg, "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            return false;
                        }

                        foreach (OrderDetail item in deleted_details)
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
                                Status = BHConstant.ACTIVE_STATUS,
                                Direction = BHConstant.DIRECTION_IN,
                                UpdatedDate = createdDate
                            };
                            productLogService.AddProductLog(newpl);
                        }
                        foreach (OrderDetail od in orderDetails)
                        {
                            od.OrderId = order.Id;
                            if (od.ProductId > 0 && od.AttributeId > 0 && od.UnitId > 0)
                            {
                                totalCommission += od.Commission;
                                OrderDetail tmp_ode = old_orderDetails.Where(x => x.ProductId == od.ProductId &&
                                    x.AttributeId == od.AttributeId && x.UnitId == od.UnitId && x.OrderId == order.Id).FirstOrDefault();
                                if (tmp_ode != null)
                                {
                                    double amount = tmp_ode.NumberUnit - od.NumberUnit;
                                    bool ret = orderDetailService.UpdateOrderDetail(od);
                                    //Save in Production Log
                                    if (amount != 0)
                                    {
                                        pl = productLogService.GetProductLog(od.ProductId, od.AttributeId, od.UnitId);
                                        newpl = new ProductLog()
                                        {
                                            ProductId = od.ProductId,
                                            AttributeId = od.AttributeId,
                                            UnitId = od.UnitId,
                                            BeforeNumber = pl.AfterNumber,
                                            Amount = Math.Abs(amount),
                                            AfterNumber = pl.AfterNumber + amount,
                                            RecordCode = order.OrderCode,
                                            Status = BHConstant.ACTIVE_STATUS,
                                            Direction = amount > 0 ? BHConstant.DIRECTION_IN : BHConstant.DIRECTION_OUT,
                                            UpdatedDate = createdDate
                                        };
                                        productLogService.AddProductLog(newpl);
                                    }
                                }
                                else
                                {
                                    bool ret = (od.Id != null && od.Id > 0) ? orderDetailService.UpdateOrderDetail(od) 
                                        : orderDetailService.AddOrderDetail(od);
                                    //Save in Production Log
                                    pl = productLogService.GetProductLog(od.ProductId, od.AttributeId, od.UnitId);
                                    newpl = new ProductLog()
                                    {
                                        ProductId = od.ProductId,
                                        AttributeId = od.AttributeId,
                                        UnitId = od.UnitId,
                                        BeforeNumber = pl.AfterNumber,
                                        Amount = od.NumberUnit,
                                        AfterNumber = pl.AfterNumber - od.NumberUnit,
                                        RecordCode = order.OrderCode,
                                        Status = BHConstant.ACTIVE_STATUS,
                                        Direction = BHConstant.DIRECTION_OUT,
                                        UpdatedDate = createdDate
                                    };
                                    productLogService.AddProductLog(newpl);
                                }
                            }
                        }

                        OrderService orderService = new OrderService();
                        bool result = orderService.UpdateOrder(order);

                        #endregion

                        #region KH & NV

                        CustomerLogService cls = new CustomerLogService();
                        CustomerLog newest = cls.GetCustomerLog(order.OrderCode);
                        if (newest != null)
                        {
                            newest.Amount = totalWithTax;
                            cls.UpdateCustomerLog(newest);
                        }

                        int salerId = (int)order.Customer.SalerId;
                        if (salerId > 0)
                        {
                            EmployeeLogService els = new EmployeeLogService();
                            EmployeeLog order_el = els.SelectEmployeeLogByWhere(x => x.RecordCode == order.OrderCode).FirstOrDefault();
                            if (order_el != null)
                            {
                                order_el.Amount = totalCommission;
                                els.UpdateEmployeeLog(order_el);
                            }
                        }

                        #endregion

                        if (result)
                        {
                            MessageBox.Show("Phiếu bán hàng đã được cập nhật thành công");
                            this.Close();
                            return true;
                        }
                        else
                        {
                            MessageBox.Show("Hiện tại hệ thống đang có lỗi. Vui lòng thử lại sau!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            return false;
                        }

                        #endregion
                    }
                    else//add new
                    {
                        #region Create New

                        ProductLog pl, newpl;
                        string msg = "";
                        int error = 0;
                        foreach (OrderDetail item in orderDetails)
                        {
                            pl = productLogService.GetProductLog(item.ProductId, item.AttributeId, item.UnitId);
                            if (pl.AfterNumber - item.NumberUnit < 0)
                            {
                                if (error == 0)
                                {
                                    msg += "Những sản phẩm sau không đủ số lượng để tạo phiếu bán hàng:\n";
                                    error = 1;
                                }
                                msg += "- " + productLogService.GetNameOfProductLog(pl) + " còn : " + pl.AfterNumber + "\n";
                            }
                        }

                        if (error > 0)
                        {
                            MessageBox.Show(msg, "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            return false;
                        }

                        SeedService ss = new SeedService();
                        order = new Order
                        {
                            CustId = cbxCustomer.SelectedValue != null ? (int)cbxCustomer.SelectedValue : 0,
                            Discount = discount,
                            Note = txtNote.Text,
                            VAT = vat,
                            OrderCode = ss.AddSeedID(BHConstant.PREFIX_FOR_ORDER),
                            CreatedDate = createdDate,
                            UserId = userId,
                            Reason = txtReason.Text,
                            WareHouse = txtWare.Text,
                            Total = totalWithTax
                        };
                        OrderService orderService = new OrderService();
                        bool result = orderService.AddOrder(order);
                        long newOrderId = -1;
                        try
                        {
                            newOrderId = order.Id;// BaoHienRepository.GetMaxId<Order>();
                        }
                        catch
                        {
                            MessageBox.Show("Hiện tại hệ thống đang có lỗi. Vui lòng thử lại sau!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            return false;
                        }

                        #region New Order Detail

                        OrderDetailService orderDetailService = new OrderDetailService();
                        foreach (OrderDetail od in orderDetails)
                        {
                            if (od.ProductId > 0 && od.AttributeId > 0 && od.UnitId > 0)
                            {
                                od.OrderId = (int)newOrderId;
                                bool ret = orderDetailService.AddOrderDetail(od);
                                totalCommission += od.Commission;

                                //Save in Production Log
                                pl = productLogService.GetProductLog(od.ProductId, od.AttributeId, od.UnitId);
                                newpl = new ProductLog()
                                {
                                    ProductId = od.ProductId,
                                    AttributeId = od.AttributeId,
                                    UnitId = od.UnitId,
                                    BeforeNumber = pl.AfterNumber,
                                    Amount = od.NumberUnit,
                                    AfterNumber = pl.AfterNumber - od.NumberUnit,
                                    RecordCode = order.OrderCode,
                                    Status = BHConstant.ACTIVE_STATUS,
                                    Direction = BHConstant.DIRECTION_OUT,
                                    UpdatedDate = createdDate
                                };
                                productLogService.AddProductLog(newpl);
                            }
                        }

                        #endregion

                        #region KH & NV

                        CustomerLogService cls = new CustomerLogService();
                        CustomerLog cl = new CustomerLog
                        {
                            CustomerId = order.CustId,
                            RecordCode = order.OrderCode,
                            Amount = totalWithTax,
                            Direction = BHConstant.DIRECTION_OUT,
                            CreatedDate = createdDate
                        };
                        result = cls.AddCustomerLog(cl);

                        int salerId = (int)order.Customer.SalerId;
                        if (salerId > 0)
                        {
                            EmployeeLogService els = new EmployeeLogService();
                            EmployeeLog newel = new EmployeeLog
                            {
                                EmployeeId = salerId,
                                RecordCode = order.OrderCode,
                                Amount = totalCommission,
                                CreatedDate = createdDate
                            };
                            result = els.AddEmployeeLog(newel);
                        }

                        #endregion

                        if (result)
                        {
                            MessageBox.Show("Phiếu bán hàng đã được tạo thành công");
                            this.Close();
                            return true;
                        }
                        else
                        {
                            MessageBox.Show("Hiện tại hệ thống đang có lỗi. Vui lòng thử lại sau!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                            return false;
                        }
                        #endregion
                    }
                }
                return false;
            }
            else
            {
                MessageBox.Show("Vui lòng kiểm tra các thông tin cần thiết!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return false;
            }
        }

        private void loadSomeData()
        {
            if(customers == null)
            {
                CustomerService customerService = new CustomerService();
                customers = new BindingList<Customer>(customerService.GetCustomers().OrderBy(x => x.CustCode).ToList());
                customers.Insert(0, new Customer() { Id = 0, CustCode = "", CustomerName = ""});
            }
            if (customers != null)
            {
                cbxCustomer.AutoCompleteMode = AutoCompleteMode.SuggestAppend;
                cbxCustomer.AutoCompleteSource = AutoCompleteSource.ListItems;

                cbxCustomer.DataSource = customers;
                cbxCustomer.DisplayMember = "CustCode";
                cbxCustomer.ValueMember = "Id";
            }
            ProductAttributeService productAttrService = new ProductAttributeService();
            productAttrs = new BindingList<ProductAttributeModel>(productAttrService.GetProductAndAttribute());
            units = new BindingList<MeasurementUnit>(unitService.GetMeasurementUnits());
            if (order != null)
            {
                if (customers != null)
                {
                    cbxCustomer.SelectedIndex = customers.ToList().FindIndex(cus => cus.Id == order.CustId);
                }
                txtDiscount.WorkingText = order.Discount.HasValue ? order.Discount.Value.ToString() : "";
                txtNote.Text = order.Note;
                txtVAT.WorkingText = order.VAT.HasValue ? order.VAT.Value.ToString() : "";
                txtOrderCode.Text = order.OrderCode;
                txtCreatedDate.Text = order.CreatedDate.ToString(BHConstant.DATE_FORMAT);

                txtVAT.Text = Global.formatVNDCurrencyText(txtVAT.WorkingText);
                txtDiscount.Text = Global.formatVNDCurrencyText(txtDiscount.WorkingText);
                txtWare.Text = order.WareHouse;
                txtReason.Text = order.Reason;
            }
            else
            {
                txtCreatedDate.Text = BaoHienRepository.GetBaoHienDBDataContext().GetSystemDate().ToString(BHConstant.DATE_FORMAT);
                txtOrderCode.Text = Global.GetTempSeedID(BHConstant.PREFIX_FOR_ORDER);
            }
        }

        public void updateProductionRequestDetailCells()
        {
            if (isUpdating && order != null && orderDetails.Count < dgwOrderDetails.RowCount)
            {
                ProductAttributeService productAttrService = new ProductAttributeService();
                for (int i = 0; i < orderDetails.Count; i++)
                {
                    if (dgwOrderDetails.Rows[i].Cells[ProductAttrCell] is DataGridViewComboBoxCell)
                    {
                        DataGridViewComboBoxCell pkgBoxCell = (DataGridViewComboBoxCell)dgwOrderDetails.Rows[i].Cells[ProductAttrCell];
                        try
                        {
                            pkgBoxCell.Value = productAttrService.GetProductAttribute(orderDetails[i].ProductId, orderDetails[i].AttributeId).Id;
                        }
                        catch { }
                    }
                    // Unit
                    if (dgwOrderDetails.Rows[i].Cells[UnitCell] is DataGridViewComboBoxCell)
                    {
                        DataGridViewComboBoxCell pkgBoxCell = (DataGridViewComboBoxCell)dgwOrderDetails.Rows[i].Cells[UnitCell];
                        try
                        {
                            pkgBoxCell.Value = orderDetails[i].UnitId;
                        }
                        catch { }
                    }
                }
            }            
        }

        public void loadDataForEditOrder(int orderId)
        {
            if (!Global.isAdmin())
            {
                disableForm();
            }
            cbxCustomer.Enabled = false; // Don't allow change Customer
            isUpdating = true;
            OrderService orderService = new OrderService();
            order = orderService.GetOrder(orderId);
            old_order = order;
            if (order != null)
            {
                if (orderDetails == null)
                {
                    OrderDetailService orderDetailService = new OrderDetailService();
                    orderDetails = new BindingList<OrderDetail>(orderDetailService.SelectOrderDetailByWhere(o => o.OrderId == order.Id));
                    old_orderDetails = new List<OrderDetail>();
                    foreach (OrderDetail od in orderDetails)
                    {
                        old_orderDetails.Add(new OrderDetail
                            {
                                AttributeId = od.AttributeId,
                                ProductId = od.ProductId,
                                UnitId = od.UnitId,
                                OrderId = od.OrderId,
                                NumberUnit = od.NumberUnit
                            });
                    }
                }
            }            
        }

        private void AddOrder_Load(object sender, EventArgs e)
        {
            unitService = new MeasurementUnitService();
            productLogService = new ProductLogService();
            loadSomeData();
            SetupColumns();
            updateProductionRequestDetailCells();
            calculateTotal();
            loadOther();
        }

        private void loadOther()
        {
            if (isUpdating)
            {
                if (Global.isAdmin())
                {
                    this.Text = "Chỉnh sửa phiếu bán hàng";
                }
                else
                {
                    this.Text = "Xem thông tin phiếu bán hàng";
                    btnPrintS.Enabled = false;
                }
            }
            else
            {
                this.Text = "Tạo phiếu bán hàng";
            }
        }

        private void SetupColumns()
        {
            dgwOrderDetails.AutoGenerateColumns = false;
            if (orderDetails == null)
            {
                orderDetails = new BindingList<OrderDetail>();
            }
            dgwOrderDetails.DataSource = orderDetails;
            dgwOrderDetails.ReadOnly = false;
            if (isUpdating && !Global.isAdmin())
                dgwOrderDetails.ReadOnly = true;

            DataGridViewComboBoxColumn productColumn = new DataGridViewComboBoxColumn();
            productColumn.Width = 200;
            productColumn.AutoComplete = false;
            productColumn.HeaderText = "Sản phẩm";
            productColumn.DataSource = productAttrs;
            productColumn.DisplayMember = "ProductAttribute";
            productColumn.ValueMember = "Id";
            dgwOrderDetails.Columns.Add(productColumn);
            
            DataGridViewTextBoxColumn numberUnitColumn = new DataGridViewTextBoxColumn();
            numberUnitColumn.Width = 100;
            numberUnitColumn.DataPropertyName = "NumberUnit";
            numberUnitColumn.HeaderText = "Số lượng";
            dgwOrderDetails.Columns.Add(numberUnitColumn);

            DataGridViewComboBoxColumn unitColumn = new DataGridViewComboBoxColumn();
            unitColumn.Width = 140;
            productColumn.AutoComplete = false;
            unitColumn.HeaderText = "Đơn vị tính";
            unitColumn.DataSource = units;
            unitColumn.DisplayMember = "Name";
            unitColumn.ValueMember = "Id";
            dgwOrderDetails.Columns.Add(unitColumn);

            DataGridViewTextBoxColumn priceColumn = new DataGridViewTextBoxColumn();
            priceColumn.Width = 100;
            priceColumn.DataPropertyName = "Price";
            priceColumn.HeaderText = "Giá";
            dgwOrderDetails.Columns.Add(priceColumn);

            DataGridViewTextBoxColumn commissionColumn = new DataGridViewTextBoxColumn();
            commissionColumn.Width = 100;
            commissionColumn.DataPropertyName = "Commission";
            commissionColumn.HeaderText = "Hoa hồng";
            dgwOrderDetails.Columns.Add(commissionColumn);

            DataGridViewTextBoxColumn totalColumn = new DataGridViewTextBoxColumn();
            totalColumn.Width = 100;
            totalColumn.DataPropertyName = "Total";
            totalColumn.HeaderText = "Tổng";
            totalColumn.ReadOnly = true;
            dgwOrderDetails.Columns.Add(totalColumn);

            DataGridViewTextBoxColumn noteColumn = new DataGridViewTextBoxColumn();
            noteColumn.DataPropertyName = "Note";
            noteColumn.Width = 150;
            noteColumn.HeaderText = "Ghi chú";
            dgwOrderDetails.Columns.Add(noteColumn);
        }
        
        private void dgwOrderDetails_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            DataGridView dgv = (DataGridView)sender;
            if (orderDetails == null)
            {
                orderDetails = new BindingList<OrderDetail>();
            }
            if (orderDetails.Count < dgwOrderDetails.RowCount - 1)
            {
                OrderDetail orderDetail = new OrderDetail();
                orderDetails.Add(orderDetail);
            }
            if (dgv.CurrentCell.Value != null)
            {
                switch (e.ColumnIndex)
                {
                    case ProductAttrCell:
                        {
                            ProductAttributeService productAttrService = new ProductAttributeService();
                            ProductAttribute pa = productAttrService.GetProductAttribute((int)dgv.CurrentCell.Value);
                            if (pa != null)
                            {
                                orderDetails[e.RowIndex].ProductId = pa.ProductId;
                                orderDetails[e.RowIndex].AttributeId = pa.AttributeId;
                            }
                        } break;
                    case PriceCell:
                        {
                            double price = 0;
                            try
                            {
                                price = (double)dgv.CurrentCell.Value;
                                if (price < 0)
                                    price = 0;
                            }
                            catch { price = 0; }
                            orderDetails[e.RowIndex].Price = price;
                            dgv.CurrentCell.ToolTipText = Global.formatVNDCurrencyText(price.ToString());
                        } break;
                    case CommissionCell:
                        {
                            double commission = 0;
                            try
                            {
                                commission = (double)dgv.CurrentCell.Value;
                                if (commission < 0)
                                    commission = 0;
                            }
                            catch { commission = 0; }
                            orderDetails[e.RowIndex].Commission = commission;
                            dgv.CurrentCell.ToolTipText = Global.formatVNDCurrencyText(commission.ToString());
                        } break;
                    case TotalCell:
                        {
                            dgv.CurrentCell.ToolTipText = Global.formatVNDCurrencyText(orderDetails[e.RowIndex].Cost.ToString());
                        } break;
                    case NoteCell:
                        {
                            orderDetails[e.RowIndex].Note = (string)dgv.CurrentCell.Value;
                        } break;
                    default:
                        break;
                }
            }
            calculateNumberUnit(dgv, e.RowIndex, e.ColumnIndex);
            calculateTotal();
            orderDetails[e.RowIndex].Cost = (int)dgwOrderDetails.Rows[e.RowIndex].Cells[NumberUnitCell].Value
                * (double)dgwOrderDetails.Rows[e.RowIndex].Cells[PriceCell].Value;
            dgwOrderDetails.Rows[e.RowIndex].Cells[TotalCell].ToolTipText = Global.formatVNDCurrencyText(orderDetails[e.RowIndex].Cost.ToString());
        }

        private void calculateNumberUnit(DataGridView dgv, int rowIndex, int colIndex)
        {
            if (dgv.Rows[rowIndex].Cells[UnitCell].Value != null &&
                dgv.Rows[rowIndex].Cells[NumberUnitCell].Value != null &&
                (colIndex == UnitCell || colIndex == NumberUnitCell || colIndex == ProductAttrCell))
            {
                int unitId = (int)dgv.Rows[rowIndex].Cells[UnitCell].Value;
                int numberUnit = (int)dgv.Rows[rowIndex].Cells[NumberUnitCell].Value;
                if (numberUnit < 0)
                    numberUnit = 0;
                ProductLog pl = productLogService.GetProductLog(orderDetails[rowIndex].ProductId, 
                    orderDetails[rowIndex].AttributeId, unitId);
                double current_number = pl.AfterNumber;
                if (isUpdating)
                {
                    OrderDetail ode = old_orderDetails.Where(x => x.ProductId == orderDetails[rowIndex].ProductId &&
                                x.AttributeId == orderDetails[rowIndex].AttributeId && x.UnitId == unitId && x.OrderId == order.Id).FirstOrDefault();
                    if (ode != null)
                        current_number += ode.NumberUnit;
                }
                if (current_number <= 0)
                {
                    MessageBox.Show("Số lượng sản phẩm trong kho đã hết.");
                    dgv.Rows[rowIndex].Cells[NumberUnitCell].Value = 0;

                    orderDetails[rowIndex].UnitId = unitId;
                    orderDetails[rowIndex].NumberUnit = 0;
                }
                else if (current_number < numberUnit)
                {
                    MessageBox.Show("Số lượng sản phẩm trong kho còn lại là : " + current_number);
                    dgv.Rows[rowIndex].Cells[NumberUnitCell].Value = current_number;

                    orderDetails[rowIndex].UnitId = unitId;
                    orderDetails[rowIndex].NumberUnit = (int)current_number;
                }
                else
                {
                    orderDetails[rowIndex].UnitId = unitId;
                    orderDetails[rowIndex].NumberUnit = numberUnit;
                }
            }
        }

        private void calculateTotal()
        {
            double totalNoTax = 0.0;
            totalWithTax = 0.0;
            bool hasValue = false;

            for (int i = 0; i < orderDetails.Count; i++)
            {
                if (orderDetails[i].ProductId != 0 && orderDetails[i].AttributeId != 0 && orderDetails[i].UnitId != 0)
                {
                    // Calculate total at Column 1 w 3 = 5
                    dgwOrderDetails.Rows[i].Cells[TotalCell].Value = (int)dgwOrderDetails.Rows[i].Cells[NumberUnitCell].Value
                        * (double)dgwOrderDetails.Rows[i].Cells[PriceCell].Value;
                    hasValue = true;
                    totalNoTax += (double)dgwOrderDetails.Rows[i].Cells[TotalCell].Value;
                }
            }
            if (hasValue)
            {
                double vat = 0.0;
                double discount = 0.0;
                string tVAT = (order != null && order.VAT != null) ? order.VAT.ToString() : 
                    string.IsNullOrEmpty(txtVAT.WorkingText) ? txtVAT.Text : txtVAT.WorkingText;
                string tDiscount = (order != null && order.Discount != null) ? order.Discount.ToString() : 
                    string.IsNullOrEmpty(txtDiscount.WorkingText) ? txtDiscount.Text : txtDiscount.WorkingText;
                double.TryParse(tVAT, out vat);
                double.TryParse(tDiscount, out discount);
                totalWithTax = totalNoTax + vat - discount;
                lblSubTotal.Text = Global.formatVNDCurrencyText(totalNoTax.ToString());
                lblGrantTotal.Text = Global.formatVNDCurrencyText(totalWithTax.ToString());
            }
        }
        
        private void dgwOrderDetails_EditingControlShowing(object sender, DataGridViewEditingControlShowingEventArgs e)
        {
            switch (dgwOrderDetails.CurrentCell.ColumnIndex)
            {
                case ProductAttrCell:
                    {
                        var source = new AutoCompleteStringCollection();
                        String[] stringArray = Array.ConvertAll<ProductAttributeModel, String>(productAttrs.ToArray(), delegate(ProductAttributeModel row) { return (String)row.ProductAttribute; });
                        source.AddRange(stringArray);

                        ComboBox prodCode = e.Control as ComboBox;
                        if (prodCode != null)
                        {
                            prodCode.DropDownStyle = ComboBoxStyle.DropDown;
                            prodCode.AutoCompleteMode = AutoCompleteMode.SuggestAppend;
                            prodCode.AutoCompleteCustomSource = source;
                            prodCode.AutoCompleteSource = AutoCompleteSource.CustomSource;
                            prodCode.MaxDropDownItems = 5;
                            prodCode.KeyDown += DisableDropperDown;
                        }
                    } break;
                case NumberUnitCell:
                    {
                        TextBox numberOfUnit = e.Control as TextBox;
                        this.validator1.SetRegularExpression(numberOfUnit, BHConstant.REGULAR_EXPRESSION_FOR_NUMBER);
                        this.validator1.SetType(numberOfUnit, Itboy.Components.ValidationType.RegularExpression);
                    } break;
                case UnitCell:
                    {
                        var source = new AutoCompleteStringCollection();
                        String[] stringArray = Array.ConvertAll<MeasurementUnit, String>(units.ToArray(), delegate(MeasurementUnit row) { return (String)row.Name; });
                        source.AddRange(stringArray);

                        ComboBox prodCode = e.Control as ComboBox;
                        if (prodCode != null)
                        {
                            prodCode.DropDownStyle = ComboBoxStyle.DropDown;
                            prodCode.AutoCompleteMode = AutoCompleteMode.SuggestAppend;
                            prodCode.AutoCompleteCustomSource = source;
                            prodCode.AutoCompleteSource = AutoCompleteSource.CustomSource;
                            prodCode.MaxDropDownItems = 5;
                            prodCode.KeyDown += DisableDropperDown;
                        }
                    } break;
                case PriceCell:
                    {
                        TextBox price = e.Control as TextBox;
                        this.validator1.SetRegularExpression(price, BHConstant.REGULAR_EXPRESSION_FOR_CURRENCY);
                        this.validator1.SetType(price, Itboy.Components.ValidationType.RegularExpression);
                    } break;
                case CommissionCell:
                    {
                        TextBox commision = e.Control as TextBox;
                        this.validator1.SetRegularExpression(commision, BHConstant.REGULAR_EXPRESSION_FOR_CURRENCY);
                        this.validator1.SetType(commision, Itboy.Components.ValidationType.RegularExpression);
                    } break;
                case TotalCell:
                    {
                        TextBox total = e.Control as TextBox;
                        this.validator1.SetRegularExpression(total, BHConstant.REGULAR_EXPRESSION_FOR_CURRENCY);
                        this.validator1.SetType(total, Itboy.Components.ValidationType.RegularExpression);
                    } break;
                case NoteCell:
                    {
                        if (e.Control is TextBox)
                        {
                            TextBox other = e.Control as TextBox;
                            this.validator1.SetType(other, Itboy.Components.ValidationType.None);
                        }
                    } break;
            }
        }

        void DisableDropperDown(object sender, KeyEventArgs e)
        {
            Global.DisableDropDownWhenSuggesting((ComboBox)sender);
        }

        private void btnPrintS_Click(object sender, EventArgs e)
        {
            if (saveData())
            {
                PrintDialog pd = new PrintDialog();
                pd.PrinterSettings = new PrinterSettings();
                if (DialogResult.OK == pd.ShowDialog(this))
                {
                    this.Cursor = Cursors.AppStarting;
                    Print(pd.PrinterSettings.PrinterName);
                }
            }
        }
        
        private void printXK()
        {
            Global.checkDirSaveFile();
            var doc = new PDF.Document();
            PdfWriter docWriter = PdfWriter.GetInstance(doc, new FileStream(BHConstant.SAVE_IN_DIRECTORY + @"\XKho.pdf", FileMode.Create));
            PdfWriterEvents writerEvent;

            Image watermarkImage = Image.GetInstance(AppDomain.CurrentDomain.BaseDirectory + @"logo.png");
            watermarkImage.SetAbsolutePosition(doc.PageSize.Width / 2 - 120, 495);
            writerEvent = new PdfWriterEvents(watermarkImage);
            docWriter.PageEvent = writerEvent;

            doc.Open();

            doc.Add(FormatConfig.ParaRightBeforeHeader("Mã số phiếu : " + getOrderCode()));
            doc.Add(FormatConfig.ParaHeader("PHIẾU XUẤT KHO"));

            doc.Add(FormatConfig.ParaCommonInfo("Tên khách hàng : ", getCustomerName()));
            doc.Add(FormatConfig.ParaCommonInfo("Địa chỉ : ", getCustomerAddress()));
            doc.Add(FormatConfig.ParaCommonInfo("Lý do xuất kho : ", txtReason.Text));
            doc.Add(FormatConfig.ParaCommonInfo("Xuất tại kho : ", txtWare.Text));

            PDF.pdf.PdfPTable table = FormatConfig.Table(6, new float[] { 0.5f, 4.5f, 1.6f, 0.7f, 0.7f, 2f });
            table.AddCell(FormatConfig.TableCellHeader("STT"));
            table.AddCell(FormatConfig.TableCellHeader("Tên sản phẩm"));
            table.AddCell(FormatConfig.TableCellHeader("Mã SP"));
            table.AddCell(FormatConfig.TableCellHeader("ĐVT"));
            table.AddCell(FormatConfig.TableCellHeader("Số lượng"));
            table.AddCell(FormatConfig.TableCellHeader("Ghi chú"));

            for (int i = 0; i < orderDetails.Count; i++)
            {
                if (orderDetails[i].ProductId != 0 && orderDetails[i].AttributeId != 0 && orderDetails[i].UnitId != 0)
                {
                    table.AddCell(FormatConfig.TableCellBody((i + 1).ToString(), PdfPCell.ALIGN_CENTER));
                    table.AddCell(FormatConfig.TableCellBody(
                                        getProductName(orderDetails[i].ProductId, orderDetails[i].AttributeId),
                                        PdfPCell.ALIGN_LEFT));
                    table.AddCell(FormatConfig.TableCellBody(
                                        getProductCode(orderDetails[i].ProductId),
                                        PdfPCell.ALIGN_CENTER));
                    table.AddCell(FormatConfig.TableCellBody(
                                        getUnitName(orderDetails[i].UnitId),
                                        PdfPCell.ALIGN_CENTER));
                    table.AddCell(FormatConfig.TableCellBody(
                                        orderDetails[i].NumberUnit.ToString(),
                                        PdfPCell.ALIGN_CENTER));
                    table.AddCell(FormatConfig.TableCellBody(
                                        string.IsNullOrEmpty(orderDetails[i].Note) ? "" : orderDetails[i].Note.ToString(),
                                        PdfPCell.ALIGN_LEFT));
                }
            }

            doc.Add(table);

            doc.Add(FormatConfig.ParaCommonInfo("Ghi chú : ", string.IsNullOrEmpty(txtNote.Text) ?
                String.Concat(Enumerable.Repeat("...", 96)) :  txtNote.Text));

            DateTime date = BaoHienRepository.GetBaoHienDBDataContext().GetSystemDate();
            doc.Add(FormatConfig.ParaRightBeforeHeader(string.Format("Xuất ngày {0} tháng {1} năm {2}", date.Day, date.Month, date.Year)));
            PDF.pdf.PdfPTable table2 = FormatConfig.Table(4, new float[] { 2.5f, 2f, 2f, 3.5f });
            table2.AddCell(FormatConfig.TableCellHeaderCommon("NGƯỜI LẬP PHIẾU", PdfPCell.NO_BORDER));
            table2.AddCell(FormatConfig.TableCellHeaderCommon("NGƯỜI NHẬN", PdfPCell.NO_BORDER));
            table2.AddCell(FormatConfig.TableCellHeaderCommon("NGƯỜI GIAO", PdfPCell.NO_BORDER));
            table2.AddCell(FormatConfig.TableCellHeaderCommon("THỦ TRƯỞNG ĐƠN VỊ", PdfPCell.NO_BORDER));
            table2.AddCell(FormatConfig.TableCellBodyCustom("(Ký, họ tên)", PdfPCell.ALIGN_CENTER, FontConfig.SmallItalicFont));
            table2.AddCell(FormatConfig.TableCellBodyCustom("(Ký, họ tên)", PdfPCell.ALIGN_CENTER, FontConfig.SmallItalicFont));
            table2.AddCell(FormatConfig.TableCellBodyCustom("(Ký, họ tên)", PdfPCell.ALIGN_CENTER, FontConfig.SmallItalicFont));
            table2.AddCell(FormatConfig.TableCellBodyCustom("(Ký, họ tên, đóng dấu)", PdfPCell.ALIGN_CENTER, FontConfig.ItalicFont));
            doc.Add(table2);

            doc.Close();
        }

        private void printBH(bool preview)
        {
            Global.checkDirSaveFile();
            var doc = new PDF.Document();
            PdfWriter docWriter = PdfWriter.GetInstance(doc, new FileStream(BHConstant.SAVE_IN_DIRECTORY + @"\BHang" + preview.ToString() + ".pdf", FileMode.Create));
            PdfWriterEvents writerEvent;
            if (preview)
            {
                writerEvent = new PdfWriterEvents("Preview");
                docWriter.PageEvent = writerEvent;
            }

            Image watermarkImage = Image.GetInstance(AppDomain.CurrentDomain.BaseDirectory + @"logo.png");
            watermarkImage.SetAbsolutePosition(doc.PageSize.Width / 2 - 120, 476);
            writerEvent = new PdfWriterEvents(watermarkImage);
            docWriter.PageEvent = writerEvent;

            doc.Open();

            doc.Add(FormatConfig.ParaRightBeforeHeader("Mã số phiếu : " + getOrderCode()));
            doc.Add(FormatConfig.ParaHeader("PHIẾU BÁN HÀNG"));
            doc.Add(FormatConfig.ParaRightBelowHeader("(SẼ BỔ SUNG HÓA ĐƠN TÀI CHÍNH VÀ THU THÊM THUẾ GTGT 10% SAU)"));

            doc.Add(FormatConfig.ParaCommonInfoAllBold("Tên khách hàng : ", getCustomerName()));
            doc.Add(FormatConfig.ParaCommonInfo("Địa chỉ : ", getCustomerAddress()));
            doc.Add(FormatConfig.ParaCommonInfo("Lý do xuất kho : ", txtReason.Text));
            doc.Add(FormatConfig.ParaCommonInfo("Xuất tại kho : ", txtWare.Text));

            PDF.pdf.PdfPTable table = FormatConfig.Table(7, new float[] { 0.5f, 3.5f, 1.6f, 0.7f, 0.7f, 1.3f, 1.7f });
            table.AddCell(FormatConfig.TableCellHeader("STT"));
            table.AddCell(FormatConfig.TableCellHeader("Tên sản phẩm"));
            table.AddCell(FormatConfig.TableCellHeader("Mã SP"));
            table.AddCell(FormatConfig.TableCellHeader("ĐVT"));
            table.AddCell(FormatConfig.TableCellHeader("Số lượng"));
            table.AddCell(FormatConfig.TableCellHeader("Giá (VND)"));
            table.AddCell(FormatConfig.TableCellHeader("Thành tiền (VND)"));

            for (int i = 0; i < orderDetails.Count; i++)
            {
                if (orderDetails[i].ProductId != 0 && orderDetails[i].AttributeId != 0 && orderDetails[i].UnitId != 0)
                {
                    table.AddCell(FormatConfig.TableCellBody((i + 1).ToString(), PdfPCell.ALIGN_CENTER));
                    table.AddCell(FormatConfig.TableCellBody(
                                        getProductName(orderDetails[i].ProductId, orderDetails[i].AttributeId),
                                        PdfPCell.ALIGN_LEFT));
                    table.AddCell(FormatConfig.TableCellBody(
                                        getProductCode(orderDetails[i].ProductId),
                                        PdfPCell.ALIGN_CENTER));
                    table.AddCell(FormatConfig.TableCellBody(
                                        getUnitName(orderDetails[i].UnitId),
                                        PdfPCell.ALIGN_CENTER));
                    table.AddCell(FormatConfig.TableCellBody(
                                        orderDetails[i].NumberUnit.ToString(),
                                        PdfPCell.ALIGN_CENTER));
                    table.AddCell(FormatConfig.TableCellBody(
                                        Global.convertToCurrency(orderDetails[i].Price.ToString()),
                                        PdfPCell.ALIGN_RIGHT));
                    table.AddCell(FormatConfig.TableCellBoldBody(
                                        Global.convertToCurrency(orderDetails[i].Cost.ToString()),
                                        PdfPCell.ALIGN_RIGHT, 1));
                }
            }

            table.AddCell(FormatConfig.TableCellBoldBody("VAT", PdfPCell.ALIGN_RIGHT, 6));
            table.AddCell(FormatConfig.TableCellBoldBody(
                Global.convertToCurrency(txtVAT.WorkingText),
                PdfPCell.ALIGN_RIGHT, 6));

            table.AddCell(FormatConfig.TableCellBoldBody("Khấu chi", PdfPCell.ALIGN_RIGHT, 6));
            table.AddCell(FormatConfig.TableCellBoldBody(
                Global.convertToCurrency(txtDiscount.WorkingText),
                PdfPCell.ALIGN_RIGHT, 1));

            table.AddCell(FormatConfig.TableCellBoldBody("Tổng", PdfPCell.ALIGN_RIGHT, 6));
            table.AddCell(FormatConfig.TableCellBoldBody(
                Global.convertToCurrency(totalWithTax.ToString()),
                PdfPCell.ALIGN_RIGHT, 1));

            doc.Add(table);

            doc.Add(FormatConfig.ParaCommonInfoWithItalicContent("Cộng thành tiền (viết bằng chữ) : ", Global.convertCurrencyToText(totalWithTax.ToString())));

            doc.Add(FormatConfig.ParaCommonInfo("Ghi chú : ", string.IsNullOrEmpty(txtNote.Text) ?
                String.Concat(Enumerable.Repeat("...", 48)) : txtNote.Text));

            DateTime date = BaoHienRepository.GetBaoHienDBDataContext().GetSystemDate();
            doc.Add(FormatConfig.ParaRightBeforeHeader(string.Format("Xuất ngày {0} tháng {1} năm {2}", date.Day, date.Month, date.Year)));
            PDF.pdf.PdfPTable table2 = FormatConfig.Table(4, new float[] { 2.5f, 2f, 2f, 3.5f });
            table2.AddCell(FormatConfig.TableCellHeaderCommon("NGƯỜI LẬP PHIẾU", PdfPCell.NO_BORDER));
            table2.AddCell(FormatConfig.TableCellHeaderCommon("NGƯỜI NHẬN", PdfPCell.NO_BORDER));
            table2.AddCell(FormatConfig.TableCellHeaderCommon("NGƯỜI GIAO", PdfPCell.NO_BORDER));
            table2.AddCell(FormatConfig.TableCellHeaderCommon("THỦ TRƯỞNG ĐƠN VỊ", PdfPCell.NO_BORDER));
            table2.AddCell(FormatConfig.TableCellBodyCustom("(Ký, họ tên)", PdfPCell.ALIGN_CENTER, FontConfig.SmallItalicFont));
            table2.AddCell(FormatConfig.TableCellBodyCustom("(Ký, họ tên)", PdfPCell.ALIGN_CENTER, FontConfig.SmallItalicFont));
            table2.AddCell(FormatConfig.TableCellBodyCustom("(Ký, họ tên)", PdfPCell.ALIGN_CENTER, FontConfig.SmallItalicFont));
            table2.AddCell(FormatConfig.TableCellBodyCustom("(Ký, họ tên, đóng dấu)", PdfPCell.ALIGN_CENTER, FontConfig.ItalicFont));
            doc.Add(table2);

            doc.Close();
        }
        
        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }
        
        private void disableForm()
        {
            txtCreatedDate.Enabled = false;
            txtDiscount.Enabled = false;
            txtNote.Enabled = false;
            txtOrderCode.Enabled = false;
            txtVAT.Enabled = false;
            cbxCustomer.Enabled = false;
            txtWare.Enabled = false;
            txtReason.Enabled = false;
        }
        
        private void txtDiscount_Leave(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtDiscount.Text))
            {
                calculateTotal();
            }
        }

        private string getOrderCode()
        {
            if (order != null && !string.IsNullOrEmpty(order.OrderCode))
                return order.OrderCode;
            else
                return txtOrderCode.Text;
        }

        private string getCustomerName()
        {
            string result = string.Empty;
            if (cbxCustomer.SelectedValue != null)
                result = customers.Where(cus => cus.Id == (int)cbxCustomer.SelectedValue).FirstOrDefault().CustomerName;
            return result;
        }

        private string getCustomerAddress()
        {
            string result = string.Empty;
            if (cbxCustomer.SelectedValue != null)
                result = customers.Where(cus => cus.Id == (int)cbxCustomer.SelectedValue).FirstOrDefault().Address;
            return result;
        }

        private string getCustomerPhone()
        {
            string result = string.Empty;
            if (cbxCustomer.SelectedValue != null)
                result = customers.Where(cus => cus.Id == (int)cbxCustomer.SelectedValue).FirstOrDefault().Phone;
            return result;
        }

        private string getProductName(int productID, int attrID)
        { 
            string result = string.Empty;
            ProductAttributeModel pad = productAttrs.Where(p => p.ProductId == productID && p.AttributeId == attrID).FirstOrDefault();
            if (pad != null)
                result = pad.ProductAttribute;
            return result;
        }

        private string getProductCode(int productID)
        {
            string result = string.Empty;
            ProductService productService = new ProductService();
            Product p = productService.GetProduct(productID);
            if (p != null)
                result = p.ProductCode;
            return result;
        }

        private string getUnitName(int unitID)
        {
            string result = string.Empty;
            MeasurementUnit u = units.Where(un => un.Id == unitID).FirstOrDefault();
            if (u != null)
                result = u.Name;
            return result;
        }

        private void txtVAT_Leave(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtVAT.Text))
            {
                calculateTotal();
            }
        }

        private void Print(string printerName)
        {
            if(BHNumber > 0)
                printBH(false);
            if(XKNumber > 0)
                printXK();
            // Print the file to the printer.
            try
            {
                string foxit = Registry.LocalMachine.OpenSubKey("Software").OpenSubKey("Foxit Software").OpenSubKey("Foxit Reader")
                    .GetValue("InnoSetupUpdatePath").ToString().Replace("unins000", "Foxit Reader");
                string file1 = BHConstant.SAVE_IN_DIRECTORY + @"\BHang" + false.ToString() + ".pdf";
                string file2 = BHConstant.SAVE_IN_DIRECTORY + @"\XKho.pdf";

                for(int i = 0; i < BHNumber; i++)
                {
                    Process pdf_print1 = new Process();
                    pdf_print1.StartInfo.FileName = foxit;
                    pdf_print1.StartInfo.Arguments = string.Format(@"-t ""{0}"" ""{1}""", file1, printerName);
                    pdf_print1.StartInfo.CreateNoWindow = true;
                    pdf_print1.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
                    pdf_print1.Start();
                    pdf_print1.WaitForExit(20000);
                    if (!pdf_print1.HasExited)
                    {
                        pdf_print1.Kill();
                        pdf_print1.Dispose();
                        MessageBox.Show("Không thể in phiếu bán hàng!");
                    }
                }

                for (int i = 0; i < XKNumber; i++)
                {
                    Process pdf_print2 = new Process();
                    pdf_print2.StartInfo.FileName = foxit;
                    pdf_print2.StartInfo.Arguments = string.Format(@"-t ""{0}"" ""{1}""", file2, printerName);
                    pdf_print2.StartInfo.CreateNoWindow = true;
                    pdf_print2.StartInfo.WindowStyle = ProcessWindowStyle.Hidden;
                    pdf_print2.Start();
                    pdf_print2.WaitForExit(20000);
                    if (!pdf_print2.HasExited)
                    {
                        pdf_print2.Kill();
                        pdf_print2.Dispose();
                        MessageBox.Show("Không thể in phiếu xuất kho!");
                    }
                }
            }
            catch
            {
                MessageBox.Show("Không thể kết nối máy in!");
            }
            this.Cursor = Cursors.Default;
        }

        private DialogResult Preview()
        {
            printBH(true);
            PrintPreview printPreview = new PrintPreview(BHConstant.SAVE_IN_DIRECTORY + @"\BHang" + true.ToString() + ".pdf");
            DialogResult r = printPreview.ShowDialog(this);
            return r;
        }

        private bool ValidateData()
        {
            bool result = true;
            string message = "";
            List<string> errors = new List<string>();
            if (orderDetails.Count <= 0)
            {
                result = false;
                message = "- Không có dữ liệu sản phẩm";
            }
            for (int i = 0; i < orderDetails.Count; i++)
            {
                if ((orderDetails[i].ProductId != 0 && orderDetails[i].AttributeId != 0 &&
                    orderDetails[i].UnitId != 0 && orderDetails[i].NumberUnit > 0) ||
                    (orderDetails[i].ProductId == 0 && orderDetails[i].AttributeId == 0 &&
                    orderDetails[i].UnitId == 0))
                    continue;
                result = false;
                message += "- Dòng " + (i + 1) + " thiếu :";
                if (orderDetails[i].ProductId == 0)
                    errors.Add(" Sản phẩm");
                if (orderDetails[i].NumberUnit <= 0)
                    errors.Add(" Số lượng");
                if (orderDetails[i].UnitId == 0)
                    errors.Add(" Đơn vị tính");
                message += string.Join(",", errors);
                errors.Clear();
                message += "\n";
            }
            if (!result)
                MessageBox.Show(message, "Lỗi hóa đơn", MessageBoxButtons.OK, MessageBoxIcon.Error);
            return result;
        }

        private void btnCreateNK_Click(object sender, EventArgs e)
        {
            AddEntranceStock frm = new AddEntranceStock();
            frm.ShowDialog();
            ProductAttributeService productAttrService = new ProductAttributeService();
            productAttrs = new BindingList<ProductAttributeModel>(productAttrService.GetProductAndAttribute());
            ((DataGridViewComboBoxColumn)dgwOrderDetails.Columns[0]).DataSource = productAttrs;
        }

        private void btnCreateSX_Click(object sender, EventArgs e)
        {
            AddProductionRequest frmRequest = new AddProductionRequest();
            frmRequest.ShowDialog();
            ProductAttributeService productAttrService = new ProductAttributeService();
            productAttrs = new BindingList<ProductAttributeModel>(productAttrService.GetProductAndAttribute());
            ((DataGridViewComboBoxColumn)dgwOrderDetails.Columns[0]).DataSource = productAttrs;
        }

        private void btnCreateKH_Click(object sender, EventArgs e)
        {
            AddCustomer frmAddCustomer = new AddCustomer();
            if(frmAddCustomer.ShowDialog() == System.Windows.Forms.DialogResult.OK)
            {
                CustomerService customerService = new CustomerService();
                customers = new BindingList<Customer>(customerService.GetCustomers());
                if (customers != null)
                {
                    cbxCustomer.DataSource = customers;
                    cbxCustomer.DisplayMember = "CustomerName";
                    cbxCustomer.ValueMember = "Id";
                    cbxCustomer.SelectedIndex = customers.Count - 1;
                }
            }
        }

        private void dgwOrderDetails_DataError(object sender, DataGridViewDataErrorEventArgs e)
        {

        }

        private void btnPrint_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("In phiếu bán hàng mà không có bất kì sự thay đổi nào hết ?", "Xác nhận", MessageBoxButtons.OKCancel, MessageBoxIcon.Exclamation) == System.Windows.Forms.DialogResult.OK)
            {
                order = old_order;
                //orderDetails = new BindingList<OrderDetail>(old_orderDetails);
                PrintDialog pd = new PrintDialog();
                pd.PrinterSettings = new PrinterSettings();
                if (DialogResult.OK == pd.ShowDialog(this))
                {
                    this.Cursor = Cursors.AppStarting;
                    Print(pd.PrinterSettings.PrinterName);
                }
            }
        }
        
        private void cbxCustomer_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cbxCustomer.SelectedValue != null)
            {
                Customer cm = null;
                if (cbxCustomer.SelectedValue is Customer)
                    cm = (Customer)cbxCustomer.SelectedValue;
                else
                    cm = customers.Where(x => x.Id == (int)cbxCustomer.SelectedValue).FirstOrDefault();
                if (cm != null)
                {
                    lbCustomerName.Text = cm.CustomerName;
                }
            }
        }
                
        private void cbxCustomer_KeyDown(object sender, KeyEventArgs e)
        {
            Global.DisableDropDownWhenSuggesting(cbxCustomer);
        }
    }
}
