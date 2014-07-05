
	/**
	 * File : namespace.js
	 * Description : 
	 * Create Date : 2011-01-17
	 */
	Namespace.register("OfCard.DatePicker");
	OfCard.DatePicker = function(){}
	//全局的时间
	var pickerDate = new Date(); 
	/**
	 * OfCard.DatePicker 构造
	 * @param div 要生成date的div位置
	 * @param title 
	 * @param endnum 月份个数
	 * @param startnum 往前推多少月
	 * @param 是否显示历史
	 * @param otherDay 特殊时间,如昨天,今天
	 * @param showType 显示方式 radio:单选按钮 select:下拉框
	 */
	OfCard.DatePicker = function(options){
		var defaults = {
			endnum : 6,
			startnum : 0,
			divName : 'queryDate',
			title : '',
			showHistory : false,
			otherDay : 'Today',
			showType : 'select'
		}
		
		this.options = $.extend(defaults,options);
		this.options.endnum = this.options.endnum > 12 ? 12 : this.options.endnum;
		this.options.startnum = this.options.startnum > 6 ? 6 : this.options.startnum;
		//this.getServcerDate();
	}
	/**
	 * 在页面中插入时间控件
	 * @param isHistory 是否为历时时段
	 */
	OfCard.DatePicker.prototype.initPicker = function(isHistory){
		$("#" + this.options.divName).html("");
		var n_year ;
		var n_month ; 
		var dateHtml = "";
				
		if(this.options.title && this.options.title != ''){
			dateHtml += this.options.title ;
		}else{
			dateHtml += "<label>时间：</label>";
		}
		var opts = '';
		for(var i= 0; i < this.options.endnum; i++){
			var date = pickerDate;
			var month = date.getMonth()+1;
			if(isHistory)
				month = month - this.options.startnum;
			var year = date.getFullYear();
			month = month-i;
			if(month<=0){
				year--;
				month = 12+month;
			}
			if(i == 0){
				n_year = year;
				n_month = month;
			}
			if(this.options.showType == "select"){
				
				opts += "<option  id='t"+year+"-"+month+"' value='"+year+"-"+month+"' >" + year+"年"+month+"月" + "</option>";
			}else if(this.options.showType == "radio"){
				dateHtml += "<span>"
				dateHtml += "<input type=\"radio\" name=\"timeRange\" id=\"t"+i+"\" value=\""+i+"\" onclick=\"new OfCard.DatePicker().updatePickerDate('"+year+"','"+month+"','Today')\"/>";
				dateHtml += "<label id=\"Month"+i+"\" for='t"+i+"' onclick=\"\">";
				dateHtml += year+"年"+month+"月";
				dateHtml += "</label>";
				dateHtml += "</span>"
			}
		}
		if(this.options.showType == "select"){
			dateHtml += "<select id='timeRange' name='timeRange' onchange='new OfCard.DatePicker().updatePickerDate(this.value)'>" + opts + "</select>";
		}
		dateHtml += "&nbsp;&nbsp;&nbsp;";
		dateHtml += "<input type=\"text\" id=\"starttime\" name=\"starttime\" class=\"Wdate\" value=\" \" onFocus=\"showMinDate()\" />";
		dateHtml += "<span>至</span>";
		dateHtml += "<input type=\"text\" id=\"endtime\" name=\"endtime\" class=\"Wdate\" value=\" \" onFocus=\"showMaxDate()\" />";
		if(this.options.showHistory=="true"||this.options.showHistory==true){
			dateHtml += "<a id='DatePicker_history' href='#' onclick=\"new OfCard.DatePicker('"+this.options.divName+"', '"+this.options.title+"' , '"+this.options.endnum+"' , '"+this.options.startnum+"','"+this.options.showHistory+"').history(true)\" >  （ 查看历史 ）  </a>";
			dateHtml += "<a id='DatePicker_now' href='#' onclick=\"new OfCard.DatePicker('"+this.options.divName+"', '"+this.options.title+"' , '"+this.options.endnum+"' , '"+this.options.startnum+"','"+this.options.showHistory+"').history(null)\" style='display:none'>  （查看现在）  </a>";
		}
		dateHtml += " (注:不能进行跨月查询)";
		$("#"+this.options.divName).html(dateHtml);
		//$('#picker_select>option:first').click();
		if(this.options.showType == "radio"){
			$('#t0').parent().addClass('checkLab');
		}
		if(this.options.otherDay){
			var date = pickerDate;
			var month = date.getMonth()+1;
			var year = date.getFullYear();
			if(this.options.showType == "select"){
				var d = year+'-'+month;
				this.updatePickerDate(d,month,this.options.otherDay);
			}else if(this.options.showType == "radio"){
				this.updatePickerDate(year,month,this.options.otherDay);
			}
		}else{
			if(this.options.showType == "select"){
				var d = n_year+'-'+n_month;
				this.updatePickerDate(d,month);
			}else if(this.options.showType == "radio"){
				this.updatePickerDate(n_year,n_month);
			}
		}
	}
	/**
	 * 更改日历控件的最大最小值
	 * @param value
	 * @return
	 */
	OfCard.DatePicker.prototype.updatePickerDate = function(year,month,otherDay){
		if(this.options.showType == "select"){
			var d = year.split('-');
			if(d.length>1){
				month = d[1];
				year = d[0];
			}
		}
		var self = this;
		var date = pickerDate;
		var yday = date.getDate();//新增的昨天 2011年3月9日 16:26:00
		if(otherDay == 'Yesterday'){//新增的昨天 2011年3月9日 16:26:00
			if(month==1&&yday==1){
				year--;
				month = 12
			}else if(yday==1){
				month = month-1;
			}
		}
		
		if(month<10){
			month="0"+month;
		}

		mindate = year +"-"+month+"-01"+" 00:00:00";
		if(otherDay=="Today"||year=="Month"){
			maxdate = date.getFullYear() +"-"+(date.getMonth()+1)+"-"+date.getDate()+"";
		}else if(otherDay == 'Yesterday'){//新增的昨天 2011年3月9日 16:26:00
			if(yday==1){
				yday = self.lastDate(year,month);
			}
			else
				yday --;
			maxdate = date.getFullYear() +"-"+(date.getMonth()+1)+"-"+yday+"";
		}else{
			maxdate = year +"-"+month+"-"+self.lastDate(year,month)+"";
		}
		var Maxmaxdate = "#F{$dp.$D(\'endtime\')||\'"+maxdate+" 00:00:00"+"\'}";//maxdate+" 00:00:00";
		var Minmindate = "#F{$dp.$D(\'starttime\')||\'"+mindate+"\'}";
		
		//默认为查最后1天
		//$('#starttime').val(year+'-'+month+'-'+self.lastDate(year,month)+' 00:00:00');
		//默认为1号
		//$('#starttime').val(year+'-'+month+'-1'+' 00:00:00');
		//默认为当天
		$('#starttime').val(year+'-'+month+'-01'+' 00:00:00');
		
        var date_$ = date.getDate();
        if(date_$<10){
			date_$="0"+date_$;
		}
        
        if(yday<10){
			yday="0"+yday;
		}
		if(otherDay=="Today"){
			$('#starttime').val(year+'-'+month+'-'+date_$+' 00:00:00');
			$('#endtime').val(year+'-'+month+'-'+date_$+' 23:59:59');//+date.getHours()+':'+date.getMinutes()+":"+date.getSeconds());
		}else if(otherDay == 'Yesterday'){//新增的昨天 2011年3月9日 16:26:00
			$('#starttime').val(year+'-'+month+'-'+yday+' 00:00:00');
			$('#endtime').val(year+'-'+month+'-'+yday+' 23:59:59');
		}else{
			$('#endtime').val(year+'-'+month+'-'+self.lastDate(year,month)+' 23:59:59');
		}
		showMinDate = function(){
			new WdatePicker({startDate:'2010-11-11',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:Maxmaxdate,minDate:mindate});
		}
		showMaxDate = function(){
			new WdatePicker({startDate:'2010-11-11',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:maxdate+" 23:59:59",minDate:Minmindate});
		}
	}
	
	//日历控件的focus方法
	var showMinDate = function(){
		WdatePicker({startDate:'2010-11-11',dateFmt:'yyyy-MM-dd HH:mm:ss'});
	}
	//日历控件的focus方法
	var showMaxDate = function(){
		WdatePicker({startDate:'2010-11-11',dateFmt:'yyyy-MM-dd HH:mm:ss'});
	}
	/**
	 * 判断是不是闰年
	 * @param year
	 * @return
	 */
	OfCard.DatePicker.prototype.isLeapYear =function(year){
		if (year % 4 != 0) 
			return false;
		if (year % 400 == 0) 
			return true;
		return year % 100 != 0;
	}
	/**
	 * 取出最大日期
	 * @param year
	 * @param month
	 * @return
	 */
	OfCard.DatePicker.prototype.lastDate = function(year,month){
		if(month<10 && month.length == 2){
			month=month.substring(1,2);
		}
		var self = this;
		var kLastDates = [ 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];
		if(month>12 || month<0){
			month = 0;
		}
		if(month==2 && self.isLeapYear(year)){
			return kLastDates[month] + 1;
		}else{
			return kLastDates[month]; 
		}
	}
	/**
	 * 历史效果
	 * @param ishistory
	 * @param divName
	 * @param title
	 * @param endnum
	 * @param startnum
	 * @return
	 */
	OfCard.DatePicker.prototype.history = function(ishistory){
		if(ishistory){
			this.initPicker(true);
			$('#DatePicker_now').show();
			$('#DatePicker_history').hide();
		}
		else{
			this.initPicker();
			$('#DatePicker_history').show();
			$('#DatePicker_now').hide();
		}
	}
	/**
	 * 获得最近的3个月
	 */
	OfCard.DatePicker.prototype.getMonth = function(){
		var date = pickerDate;
		var month = date.getMonth()+1;
		var year = date.getFullYear();
	 
		$('#Month').html(year+"年"+month+"月");
		$('#Month2').html(year+"年"+(month-1)+"月");
		$('#Month3').html(year+"年"+(month-2)+"月");
		if(month == 1){
			$('#Month2').html(year-1+"年"+12+"月");
			$('#Month3').html(year-1+"年"+11+"月");
		}
		if(month == 2){
			$('#Month3').html(year-1+"年"+12+"月");
		}
	}