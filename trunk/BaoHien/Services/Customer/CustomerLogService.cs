﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using DAL;
using BaoHien.Services.Base;
using DAL.Helper;
using BaoHien.Model;
using BaoHien.Common;

namespace BaoHien.Services.Customers
{
    class CustomerLogService : BaseService<CustomerLog>
    {
        public CustomerLog GetCustomerLog(System.Int32 id)
        {
            CustomerLog customerLog = OnGetItem<CustomerLog>(id.ToString());
            return customerLog;
        }

        public List<CustomerLog> GetCustomerLogs()
        {
            List<CustomerLog> customerLogs = OnGetItems<CustomerLog>();
            return customerLogs;
        }

        public bool AddCustomerLog(CustomerLog customerLog)
        {
            return OnAddItem<CustomerLog>(customerLog);
        }

        public bool DeleteCustomerLog(System.Int32 id)
        {
            return OnDeleteItem<CustomerLog>(id.ToString());
        }

        public bool UpdateCustomerLog(CustomerLog customerLog)
        {
            return OnUpdateItem<CustomerLog>(customerLog, customerLog.Id.ToString());
        }

        public CustomerLog GetNewestCustomerLog(int customerId)
        {
            CustomerLog result = null;
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                result = context.CustomerLogs.Where(c => c.CustomerId == customerId)
                    .OrderByDescending(c => c.CreatedDate).FirstOrDefault();
            }
            return result;
        }

        public List<CustomerLog> GetLogsOfCustomer(int customerId, DateTime from, DateTime to)
        {
            List<CustomerLog> result = new List<CustomerLog>();
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                result = context.CustomerLogs
                    .Where(c => c.CustomerId == customerId && c.CreatedDate >= from && c.CreatedDate <= to)
                    .OrderByDescending(c => c.CreatedDate).ToList();
            }
            return result;
        }

        public List<CustomerLog> GetLogsOfCustomers(DateTime from, DateTime to)
        {
            List<CustomerLog> result = new List<CustomerLog>();
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                result = context.CustomerLogs.Where(c => c.CreatedDate >= from && c.CreatedDate <= to)
                    .OrderByDescending(c => c.CreatedDate)
                    .GroupBy(c => c.CustomerId).Select(c => c.First()).ToList();
            }
            return result;
        }

        public List<CustomerReport> GetReportsOfCustomer(int customerId, DateTime from, DateTime to, ref double total)
        {
            List<CustomerReport> result = new List<CustomerReport>();
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                List<CustomerLog> logs = context.CustomerLogs
                    .Where(c => c.CustomerId == customerId && c.CreatedDate >= from && c.CreatedDate <= to)
                    .OrderByDescending(c => c.CreatedDate).ToList();
                List<Order> orders = context.Orders.Where(x => logs.Select(y => y.RecordCode).Contains(x.OrderCode)).ToList();
                List<OrderDetail> details = context.OrderDetails.Where(x => orders.Select(y => y.Id).Contains(x.OrderId)).ToList();
                int curr_month = from.Month, curr_year = from.Year, month = curr_month, year = curr_year, index = 0;
                result.Add(new CustomerReport
                    {
                        Date = "Tháng " + curr_month.ToString() + "/" + curr_year.ToString()
                    });
                foreach (Order item in orders)
                {
                    month = item.CreatedDate.Month;
                    year = item.CreatedDate.Year;
                    if (month != curr_month || year != curr_year)
                    {
                        curr_month = month;
                        curr_year = year;
                        result.Add(new CustomerReport
                            {
                                Date = "Tháng " + curr_month.ToString() + "/" + curr_year.ToString()
                            });
                    }
                    List<OrderDetail> details_of_order = details.Where(x => x.OrderId == item.Id).ToList();
                    for (int i = 0; i < details_of_order.Count; i++)
                    {
                        result.Add(new CustomerReport
                        {
                            Index = (++index).ToString(),
                            Date = i == 0 ? item.CreatedDate.ToString(BHConstant.DATE_FORMAT) : "",
                            ProductName = details_of_order[i].Product.ProductName,
                            AttrName = details_of_order[i].BaseAttribute.AttributeName,
                            Number = details_of_order[i].NumberUnit.ToString(),
                            Unit = details_of_order[i].MeasurementUnit.Name,
                            Cost = Global.formatCurrencyTextWithoutMask(details_of_order[i].Cost.ToString()),
                            RecordCode = item.OrderCode,
                        });
                        total += (item.OrderCode.Contains(BHConstant.PREFIX_FOR_ORDER) ? 1 : -1) * details_of_order[i].Cost;
                    }
                }
            }
            return result;
        }

        public List<CustomersReport> GetReportsOfCustomers(DateTime from, DateTime to, ref double total)
        {
            List<CustomersReport> result = new List<CustomersReport>();
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                List<CustomerLog> logs = context.CustomerLogs.Where(c => c.CreatedDate >= from && c.CreatedDate <= to)
                    .OrderBy(c => c.CreatedDate).ToList();
                total = logs.Sum(x => x.AfterDebit - x.BeforeDebit);
                ConvertLogToReport(logs, ref result);
            }
            return result;
        }

        private void ConvertLogToReport(List<CustomerLog> logs, ref List<CustomersReport> reports)
        {
            int index = 0;
            foreach (CustomerLog log in logs)
            {
                reports.Add(new CustomersReport
                {
                    CustomerName = log.Customer.CustomerName,
                    CustomerCode = log.Customer.CustCode,
                    Date = log.CreatedDate.ToString(BHConstant.DATE_FORMAT),
                    Amount = Global.formatCurrencyTextWithoutMask(log.Amount.ToString()),
                    RecordCode = log.RecordCode,
                    Index = ++index
                });
            }
        }
    }
}
