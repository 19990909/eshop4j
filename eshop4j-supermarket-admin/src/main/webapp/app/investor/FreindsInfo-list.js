
$(document).ready(function() {
    var table = $('#dtable').DataTable( {
    	dom: "Bfrtip",
        "processing": true,
        "serverSide": true,
        "language": {
        	select: {
                rows: {
                    _: "已选择 %d 行",
                    1: "已选择 1 行"
                }
            },
        	"sProcessing":   "处理中...",
        	"sLengthMenu":   "显示 _MENU_ 项结果",
        	"sZeroRecords":  "没有匹配结果",
        	"sInfo":         "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
        	"sInfoEmpty":    "显示第 0 至 0 项结果，共 0 项",
        	"sInfoFiltered": "(由 _MAX_ 项结果过滤)",
        	"sInfoPostFix":  "",
        	"sSearch":       "搜索:",
        	"sSearchPlaceholder":"姓名、电话",
        	"sUrl":          "",
        	"sEmptyTable":     "表中数据为空",
        	"sLoadingRecords": "载入中...",
        	"sInfoThousands":  ",",
        	"oPaginate": {
        		"sFirst":    "首页",
        		"sPrevious": "上页",
        		"sNext":     "下页",
        		"sLast":     "末页"
        	},
        	"oAria": {
        		"sSortAscending":  ": 以升序排列此列",
        		"sSortDescending": ": 以降序排列此列"
        	}
        },
        "ajax": {
            "url": "/rest/freindsInfo/list",
            "type": "POST",
            "data":function(d){return {'_dt_json':JSON.stringify(d), 'userId':$('#userId').val()};}//传递对象太多，json化
        },
        columnDefs:[
                    {
                    	targets:0,
                    	data:"id",
                    	render:function(data,type,full,meta){
                        	return meta.row+1;
                        }
                    }
                    ],
        "columns": [
            { "data": "id","orderable": false },
            { "data": "userName","orderable": false },
            { "data": "mobile","orderable": false },
            { "data": "authentication","orderable": false },
            { "data": "crtTime","orderable": false },
            { "data": "investAmount","orderable": false },
			    
        ],
        select: true
    } );
    
} );
