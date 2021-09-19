# ConvertStringDateToDateTime

ConvertStringDateToDateTime is a SQL Func for Convert Text Date to Date
این فانکشن تاریخ هایی که به صورت رشته ای در دیتابیس ذخیره شده باشد رو دریافت می کند و به صورت تاریخ معمولی خروجی می دهد.

## Installation

Use your Database and Exec Func in SQL management studio query window


## Usage

```SQL
--Arabic Text Date
Select dbo.ConvertStringDateToDateTime('2020 اُكتبر 7 ,چهارشنبه')

--Gregorian Text Date
select dbo.ConvertStringDateToDateTime('Thursday, September 17, 2020')
```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.
