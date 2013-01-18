﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BaoHien.Services.Base;
using DAL;
using DAL.Helper;
using BaoHien.Model;

namespace BaoHien.Services.ProductLogs
{
    class ProductLogService : BaseService<ProductLog>
    {
        public ProductLog GetProductLog(System.Int32 id)
        {
            ProductLog productLog = OnGetItem<ProductLog>(id.ToString());
            return productLog;
        }

        public List<ProductLog> GetProductLogs()
        {
            List<ProductLog> productLogs = OnGetItems<ProductLog>();
            return productLogs;
        }

        public bool AddProductLog(ProductLog productLog)
        {
            return OnAddItem<ProductLog>(productLog);
        }

        public bool DeleteProductLog(System.Int32 id)
        {
            return OnDeleteItem<ProductLog>(id.ToString());
        }

        public bool UpdateProductLog(ProductLog productLog)
        {
            return OnUpdateItem<ProductLog>(productLog, productLog.Id.ToString());
        }

        public List<MeasurementUnit> GetUnitsOfProductAttribute(int productId, int attrId)
        {
            List<MeasurementUnit> result = new List<MeasurementUnit>();
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                List<ProductLog> logs = context.ProductLogs.Where(p => p.ProductId == productId && p.AttributeId == attrId)
                                 .GroupBy(p => p.UnitId).Select(p => p.First()).ToList();
                foreach (ProductLog log in logs)
                {
                    result.Add(log.MeasurementUnit);
                }
            }
            return result;
        }

        public ProductLog GetNewestProductUnitLog(int productId, int attrId, int unitId)
        {
            ProductLog result = null;
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                result = context.ProductLogs.Where(p => p.ProductId == productId && p.AttributeId == attrId
                    && p.UnitId == unitId).OrderByDescending(c => c.CreatedDate).FirstOrDefault();
            }
            if (result == null)
                result = new ProductLog
                {
                    Id = 0,
                    ProductId = 0,
                    AttributeId = 0,
                    UnitId = 0,
                    AfterNumber = 0,
                    Amount = 0,
                    BeforeNumber = 0
                };
            return result;
        }

        public ProductLog GetNewestProductLog(int productId, int attrId)
        {
            ProductLog result = null;
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                result = context.ProductLogs.Where(p => p.ProductId == productId && p.AttributeId == attrId)
                    .OrderByDescending(c => c.CreatedDate).FirstOrDefault();
            }
            if (result == null)
                result = new ProductLog
                {
                    Id = 0,
                    ProductId = 0,
                    AttributeId = 0,
                    UnitId = 0,
                    AfterNumber = 0,
                    Amount = 0,
                    BeforeNumber = 0
                };
            return result;
        }

        public List<ProductLog> GetLogsOfProductAttributeUnit(int productId, int attrId, int unitId, DateTime from, DateTime to)
        {
            List<ProductLog> result = new List<ProductLog>();
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                result = context.ProductLogs.Where(p => p.ProductId == productId && p.AttributeId == attrId &&
                    p.UnitId == unitId && p.CreatedDate >= from && p.CreatedDate <= to).ToList();
            }
            return result;
        }

        public List<ProductLog> GetLogsOfProductAttribute(int productId, int attrId, DateTime from, DateTime to)
        {
            List<ProductLog> result = new List<ProductLog>();
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                result = context.ProductLogs.Where(p => p.ProductId == productId && p.AttributeId == attrId &&
                    p.CreatedDate >= from && p.CreatedDate <= to)
                    .GroupBy(p => p.UnitId).Select(p => p.First()).ToList();
            }
            return result;
        }

        public List<ProductLog> GetLogsOfProduct(int productId, DateTime from, DateTime to)
        {
            List<ProductLog> result = new List<ProductLog>();
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                result = context.ProductLogs.Where(p => p.ProductId == productId &&
                    p.CreatedDate >= from && p.CreatedDate <= to).OrderByDescending(pl => pl.CreatedDate)
                    .GroupBy(p => new { p.AttributeId, p.UnitId }).Select(p => p.First()).ToList();
            }
            return result;
        }

        public List<ProductLog> GetLogsOfProducts(int productTypeId, DateTime from, DateTime to)
        {
            List<ProductLog> result = new List<ProductLog>();
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                result = context.ProductLogs.Where(p => p.Product.ProductType == productTypeId &&
                    p.CreatedDate >= from && p.CreatedDate <= to)
                    .OrderByDescending(pl => pl.CreatedDate)
                    .GroupBy(p => new { p.ProductId, p.AttributeId, p.UnitId }).Select(p => p.First()).ToList();
            }
            return result;
        }

        public List<ProductLog> GetLogsOfProducts(DateTime from, DateTime to)
        {
            List<ProductLog> result = new List<ProductLog>();
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                result = context.ProductLogs.Where(p => p.CreatedDate >= from && p.CreatedDate <= to)
                    .OrderByDescending(pl => pl.CreatedDate)
                    .GroupBy(p => new { p.ProductId, p.AttributeId, p.UnitId }).Select(p => p.First()).ToList();
            }
            return result;
        }

        public List<ProductReport> GetReportsOfProductAttributeUnit(int productId, int attrId, int unitId, DateTime from, DateTime to)
        {
            List<ProductReport> result = new List<ProductReport>();
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                List<ProductLog> logs = context.ProductLogs.Where(p => p.ProductId == productId && p.AttributeId == attrId &&
                    p.UnitId == unitId && p.CreatedDate >= from && p.CreatedDate <= to).ToList();
                ConvertLogToReportDetail(logs, ref result);
            }
            return result;
        }

        public List<ProductReport> GetReportsOfProductAttribute(int productId, int attrId, DateTime from, DateTime to)
        {
            List<ProductReport> result = new List<ProductReport>();
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                List<ProductLog> logs = context.ProductLogs.Where(p => p.ProductId == productId && p.AttributeId == attrId &&
                    p.CreatedDate >= from && p.CreatedDate <= to)
                    .GroupBy(p => p.UnitId).Select(p => p.First()).ToList();
                ConvertLogToReport(logs, ref result);
            }
            return result;
        }

        public List<ProductReport> GetReportsOfProduct(int productId, DateTime from, DateTime to)
        {
            List<ProductReport> result = new List<ProductReport>();
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                List<ProductLog> logs = context.ProductLogs.Where(p => p.ProductId == productId &&
                    p.CreatedDate >= from && p.CreatedDate <= to).OrderByDescending(pl => pl.CreatedDate)
                    .GroupBy(p => new { p.AttributeId, p.UnitId } ).Select(p => p.First()).ToList();
                ConvertLogToReport(logs, ref result);
            }
            return result;
        }

        public List<ProductReport> GetReportsOfProducts(int productTypeId, DateTime from, DateTime to)
        {
            List<ProductReport> result = new List<ProductReport>();
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                List<ProductLog> logs = context.ProductLogs.Where(p => p.Product.ProductType == productTypeId && 
                    p.CreatedDate >= from && p.CreatedDate <= to)
                    .OrderByDescending(pl => pl.CreatedDate)
                    .GroupBy(p => new { p.ProductId, p.AttributeId, p.UnitId }).Select(p => p.First()).ToList();
                ConvertLogToReport(logs, ref result);
            }
            return result;
        }

        public List<ProductReport> GetReportsOfProducts(DateTime from, DateTime to)
        {
            List<ProductReport> result = new List<ProductReport>();
            using (BaoHienDBDataContext context = new BaoHienDBDataContext(SettingManager.BuildStringConnection()))
            {
                List<ProductLog> logs = context.ProductLogs.Where(p => p.CreatedDate >= from && p.CreatedDate <= to)
                    .OrderByDescending(pl => pl.CreatedDate)
                    .GroupBy(p => new { p.ProductId, p.AttributeId, p.UnitId }).Select(p => p.First()).ToList();
                ConvertLogToReport(logs, ref result);
            }
            return result;
        }

        private void ConvertLogToReport(List<ProductLog> logs, ref List<ProductReport> reports)
        {
            int index = 0;
            foreach (ProductLog log in logs)
            {
                reports.Add(new ProductReport
                {
                    ProductCode = log.Product.ProductCode,
                    ProductName = log.Product.ProductName + " - " + log.BaseAttribute.AttributeName,
                    AttributeName = log.BaseAttribute.AttributeName,
                    UnitName = log.MeasurementUnit.Name,
                    Quantity = log.AfterNumber.ToString(),
                    CreatedDate = log.CreatedDate,
                    Index = ++index
                });
            }
        }

        private void ConvertLogToReportDetail(List<ProductLog> logs, ref List<ProductReport> reports)
        {
            int index = 0;
            foreach (ProductLog log in logs)
            {
                reports.Add(new ProductReport
                {
                    AfterNumber = log.AfterNumber.ToString(),
                    BeforeNumber = log.BeforeNumber.ToString(),
                    Amount = log.Amount.ToString(),
                    RecordCode = log.RecordCode,
                    CreatedDate = log.CreatedDate,
                    Index = ++index
                });
            }
        }
    }
}
