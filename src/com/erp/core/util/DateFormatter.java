package com.erp.core.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.TimeZone;

import org.apache.log4j.Logger;

/**
 * 
 * @version: 2007-5-25<br>
 * @author <a href="mailto:kenny319@gmail.com">Kenny Wang </a>
 */
public class DateFormatter {
	private static Logger log = Logger.getLogger(DateFormatter.class);
	private static SimpleDateFormat formatterOrder = new SimpleDateFormat("yyyyMMddHHmmss");
	private static SimpleDateFormat formatter;
	private static SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	private static SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM");
	private static SimpleDateFormat formatterOften = new SimpleDateFormat("yyyyMMddHHmmss");
	public static TimeZone CUSTOM_TIMEZONE = TimeZone.getTimeZone("Asia/Shanghai"); // 时区
	public static final String yyyyMMddHHmmss = "yyyyMMddHHmmss";
	public static final String yyyyMMdd = "yyyyMMdd";
	public static final String yyyy_MM_dd = "yyyy-MM-dd";
	public static final String yyyy_MM_dd_HHmmss = "yyyy-MM-dd HH:mm:ss";


	static {
		setTimeZone(format);
		setTimeZone(format2);
	}

	public DateFormatter() {
	}

	public static Date localToUTC(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(date.getTime() - CUSTOM_TIMEZONE.getOffset(date.getTime()));

		return c.getTime();
	}

	public static Date utcToLocal(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTimeInMillis(date.getTime() + CUSTOM_TIMEZONE.getOffset(date.getTime()));
		return c.getTime();
	}

	public static void setTimeZone(SimpleDateFormat formatter) {
		if (formatter != null)
			formatter.setTimeZone(CUSTOM_TIMEZONE);
	}

	public static String shortDate(Date aDate) {
		formatter = new SimpleDateFormat("yyyy-MM-dd");
		setTimeZone(formatter);
		return formatter.format(aDate);
	}

	public static String getYYYMMDD() {
		formatter = new SimpleDateFormat("yyyyMMdd");
		setTimeZone(formatter);
		return formatter.format(new Date());
	}

	public static String shortDate() {
		formatter = new SimpleDateFormat("yyyy-MM-dd");
		setTimeZone(formatter);
		return formatter.format(new Date());
	}

	public static String formateShortDate(Date date) {
		formatter = new SimpleDateFormat("yyyy-MM-dd");
		setTimeZone(formatter);
		return formatter.format(date);
	}

	public static String shortMonth(Date aDate) {
		formatter = new SimpleDateFormat("yyyy-MM");
		setTimeZone(formatter);
		return formatter.format(aDate);
	}

	public static String getShortCNMonth() {
		Date aDate = new Date();
		formatter = new SimpleDateFormat("yyyy年MM月");
		setTimeZone(formatter);
		return formatter.format(aDate);
	}

	public static String shortCNMonth(Date aDate) {
		formatter = new SimpleDateFormat("yyyy年MM月");
		setTimeZone(formatter);
		return formatter.format(aDate);
	}

	public static String mailDate(Date aDate) {
		formatter = new SimpleDateFormat("yyyyMMddHHmm");
		formatter.setTimeZone(TimeZone.getTimeZone("Asia/Shanghai"));
		return formatter.format(aDate);
	}

	public static String longDate(Date aDate) {
		formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		setTimeZone(formatter);
		return formatter.format(aDate);
	}

	public static String getCDateStr(int day) {
		SimpleDateFormat sdf = new SimpleDateFormat(yyyyMMdd);
		try {
			Date date = addDay(new Date(), day);
			return sdf.format(date);
		} catch (Exception e) {
			return null;
		}
	}

	public static String longDate() {
		// formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		setTimeZone(formatterOrder);
		return formatterOrder.format(new Date());
	}

	public static String shortDateGB(Date aDate) {
		formatter = new SimpleDateFormat("yyyy'年'MM'月'dd'日'");
		setTimeZone(formatter);
		return formatter.format(aDate);
	}

	public static String longDateGB(Date aDate) {
		formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		setTimeZone(formatter);
		return formatter.format(aDate);
	}

	public static String longDateGB() {
		formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		setTimeZone(formatter);
		return formatter.format(new Date());
	}

	public static String formatDate(Date aDate, String formatStr) {
		formatter = new SimpleDateFormat(formatStr);
		setTimeZone(formatter);
		return formatter.format(aDate);

	}

	public static String LDAPDate(Date aDate) {
		return formatDate(aDate, "yyyyMMddHHmm'Z'");
	}

	public static Date getDate(String yyyymmdd) {
		if ((null == yyyymmdd) || (yyyymmdd.trim().length() == 0))
			return null;
		int year = Integer.parseInt(yyyymmdd.substring(0, yyyymmdd.indexOf("-")));
		int month = Integer.parseInt(yyyymmdd.substring(yyyymmdd.indexOf("-") + 1, yyyymmdd.lastIndexOf("-")));
		int day = Integer.parseInt(yyyymmdd.substring(yyyymmdd.lastIndexOf("-") + 1));
		Calendar cal = Calendar.getInstance();
		cal.set(year, month - 1, day);
		return cal.getTime();

	}

	public static Date getDateFull(String yyyymmdd) {
		if ((null == yyyymmdd) || (yyyymmdd.trim().length() == 0))
			return null;
		int year = Integer.parseInt(yyyymmdd.substring(0, yyyymmdd.indexOf("-")));
		int month = Integer.parseInt(yyyymmdd.substring(yyyymmdd.indexOf("-") + 1, yyyymmdd.lastIndexOf("-")));
		int day = Integer.parseInt(yyyymmdd.substring(yyyymmdd.lastIndexOf("-") + 1));
		Calendar cal = Calendar.getInstance();
		cal.set(year, month - 1, day, 24, 60, 60);
		return cal.getTime();

	}

	public static Date parser(String strDate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			return sdf.parse(strDate);
		} catch (Exception e) {
			return null;
		}
	}

	public static Date parser(String strDate, String formatter) {
		SimpleDateFormat sdf = new SimpleDateFormat(formatter);
		try {
			return sdf.parse(strDate);
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * get Date with only date num. baoxy add
	 * 
	 * @param yyyymmdd
	 * @return
	 */
	public static Date getDateOnly(String yyyymmdd) {
		if ((null == yyyymmdd) || (yyyymmdd.trim().length() == 0))
			return null;
		int year = Integer.parseInt(yyyymmdd.substring(0, yyyymmdd.indexOf("-")));
		int month = Integer.parseInt(yyyymmdd.substring(yyyymmdd.indexOf("-") + 1, yyyymmdd.lastIndexOf("-")));
		int day = Integer.parseInt(yyyymmdd.substring(yyyymmdd.lastIndexOf("-") + 1));
		Calendar cal = Calendar.getInstance();
		cal.set(year, month - 1, day, 0, 0, 0);
		return cal.getTime();
	}

	public static Date addMonth(Date myDate, int amount) {
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(myDate);
		boolean isEndDayOfMonth_old = cal.getActualMaximum(GregorianCalendar.DAY_OF_MONTH) == cal.get(GregorianCalendar.DAY_OF_MONTH);
		cal.add(GregorianCalendar.MONTH, amount);
		boolean isEndDayOfMonth_new = cal.getActualMaximum(GregorianCalendar.DAY_OF_MONTH) == cal.get(GregorianCalendar.DAY_OF_MONTH);
		if (isEndDayOfMonth_old && !isEndDayOfMonth_new) {
			cal.set(GregorianCalendar.DATE, cal.getActualMaximum(GregorianCalendar.DAY_OF_MONTH));
		}
		return cal.getTime();
	}

	public static Date addDay(Date myDate, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(myDate);
		cal.add(Calendar.DAY_OF_MONTH, amount);
		return cal.getTime();
	}

	public static Date addHours(Date myDate, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(myDate);
		cal.add(Calendar.HOUR_OF_DAY, amount);
		return cal.getTime();
	}

	public static Date addMinutes(Date myDate, int amount) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(myDate);
		cal.add(Calendar.MINUTE, amount);
		return cal.getTime();
	}

	public static Date addYear(Date myDate, int amount) {
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(myDate);
		boolean isEndDayOfMonth_old = cal.getActualMaximum(GregorianCalendar.DAY_OF_MONTH) == cal.get(GregorianCalendar.DAY_OF_MONTH);
		cal.add(GregorianCalendar.YEAR, amount);
		boolean isEndDayOfMonth_new = cal.getActualMaximum(GregorianCalendar.DAY_OF_MONTH) == cal.get(GregorianCalendar.DAY_OF_MONTH);
		if (isEndDayOfMonth_old && !isEndDayOfMonth_new) {
			cal.set(GregorianCalendar.DATE, cal.getActualMaximum(GregorianCalendar.DAY_OF_MONTH));
		}
		return cal.getTime();
	}

	public static Date getFirstDay(Date date) {
		Calendar cale = Calendar.getInstance();
		cale.set(Calendar.DAY_OF_MONTH, 1);
		return parser(formatDate(cale.getTime(), "yyyy-MM-dd"), "yyyy-MM-dd");
	}

	/*
	 * the mapping from jdk is : 1-Sun; 2-Mon;3-Tues; 4-Weds; 5-Thur;6-Fri;
	 * 7-Sat;
	 */
	public static int getWeekDay(Date myDate) {
		GregorianCalendar cal = new GregorianCalendar();
		cal.setTime(myDate);
		return cal.get(GregorianCalendar.DAY_OF_WEEK);
	}

	/*
	 * the mapping from vas2005 is : 1-Mon;2-Tues; 3-Weds; 4-Thur;5-Fri;
	 * 6-Sat;7-Sun;
	 */
	public static int getConvertWeekDay(Date myDate) {
		int day = getWeekDay(myDate);
		int result = day - 1;
		if (result == 0)
			result = 7;
		return result;
	}

	public static int getTimeFromDate(Date myDate) {
		SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
		int result = Integer.parseInt(sdf.format(myDate));
		return result;
	}

	public static Date shortCNMonth(String CNdDteStr) {
		formatter = new SimpleDateFormat("yyyy年MM月");
		setTimeZone(formatter);
		Date date = new Date();
		try {
			date = formatter.parse(CNdDteStr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	public static String getLastDayStr(Date date) {
		// 获取Calendar
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeZone(CUSTOM_TIMEZONE);
		// 设置时间,当前时间不用设置
		calendar.setTime(date);

		// 设置日期为本月最大日期
		calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
		// 打印
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		setTimeZone(format);
		return format.format(calendar.getTime()).substring(0, 11) + "23:59:59";

	}

	/**
	 * 获取当前时间的前n天
	 * 
	 * @param n
	 * @return
	 */
	public static String[] getDateArround(int n) {
		String[] arr = new String[2];
		Date date = new Date();// 取时间
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		calendar.add(calendar.DATE, n);// 把日期往后增加一天.整数往后推,负数往前移动
		date = calendar.getTime(); // 这个时间就是日期往后推一天的结果
		arr[0] = format.format(date).substring(0, 11) + "00:00:00";
		arr[1] = format.format(date).substring(0, 11) + "23:59:59";
		return arr;
	}

	/**
	 * 获取当给定年月的时间区间
	 * 
	 * @param dateString
	 *            (2013年4月)
	 * @return 2013-04-01 00:00:00 2013-05-01 00:00:00
	 */
	public static String[] getDateMonth(String dateString) {
		String[] arr = new String[2];
		String time = dateString.replace("年", "-").replace("月", "");
		Date date = null;
		Date date2 = null;
		try {
			date = format2.parse(time);
			Calendar calendar = new GregorianCalendar();
			Calendar calendar2 = new GregorianCalendar();
			calendar.setTime(date);
			calendar2.setTime(date);
			calendar.set(calendar.DATE, 1);
			calendar2.set(calendar.MONTH, calendar.get(calendar.MONTH) + 1);

			date = calendar.getTime();
			date2 = calendar2.getTime();
			arr[0] = format.format(date);
			arr[1] = format.format(date2);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return arr;
	}

	/**
	 * 比较时间 time和当前时间的间隔是否小于n分钟
	 * 
	 * @param boolen
	 * @return
	 */
	public static Boolean compareTime(String time, int n) {
		long time_l = 0;
		Boolean judge = false;
		try {
			time_l = Long.parseLong(time);
			judge = true;
		} catch (NumberFormatException e) {
			judge = false;
		}
		if (!judge)
			return false;
		Boolean bo = false;
		long timeNow_l = System.currentTimeMillis();
		long diff = timeNow_l - time_l;
		long fiveMin = 60 * 1000 * n;
		if (diff < fiveMin) {
			bo = true;
		}
		if (!bo) {
			log.info(timeNow_l + "-" + time + "=" + diff);
			log.info(diff + "<" + fiveMin + "==" + bo);
		}
		return bo;
	}

	public static void main(String[] args) {
		/*
		 * System.out.println(longDate());
		 * System.out.println(DateFormatter.longDateGB());
		 */
	}

	/**
	 * 获取当前时间的前n个月，type =0以年月为分隔符 type=1以-为分隔符
	 * 
	 */
	public static List<String> getDateOfMonth(int n, String type) {
		List<String> list = new ArrayList<String>();
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		String time = sdf.format(date);
		String[] item = time.split("-");

		for (int i = 0; i < n; i++) {
			int year = Integer.parseInt(item[0]);
			int month = Integer.parseInt(item[1]);
			if ((month - i) <= 0) {
				month = month + 12 - i;
				year = year - 1;
			} else {
				month = month - i;
			}
			if (type.equals("0")) {
				time = year + "年" + month + "月";
			} else {
				if (month >= 10) {
					time = year + "-" + month;
				} else {
					time = year + "-0" + month;
				}
			}
			list.add(time);
		}

		return list;
	}

	/**
	 * 获取两时间段的天数
	 * 
	 */
	public static int daysBetween(Date smdate, Date bdate) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		smdate = sdf.parse(sdf.format(smdate));
		bdate = sdf.parse(sdf.format(bdate));
		Calendar cal = Calendar.getInstance();
		cal.setTime(smdate);
		long time1 = cal.getTimeInMillis();
		cal.setTime(bdate);
		long time2 = cal.getTimeInMillis();
		long between_days = (time2 - time1) / (1000 * 3600 * 24);

		return Integer.parseInt(String.valueOf(between_days));
	}

	public static long getTime(String dateStr) {
		Date date = parser(dateStr);
		return date.getTime();
	}

}
