<%@ page language="java" contentType="text/html; charset=UTF-8"
									pageEncoding="UTF-8"%>
<%@include file="/common/common.jsp"%>
<%
    String path = request.getContextPath();
%>
<!DOCTYPE html>
<HTML>
 <HEAD>
  <TITLE> ZTREE DEMO </TITLE>
  <meta http-equiv="content-type" content="text/html; charset=UTF-8">
 <!--  <link rel="stylesheet" href="demoStyle/demo.css" type="text/css"> -->
  <link rel="stylesheet" href="<%=path %>/css/zTree/zTreeStyle/zTreeStyle.css" type="text/css">
  <script type="text/javascript"
									src="<%=path%>/js/importJs/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="<%=path%>/js/importJs/zTree/jquery.ztree.all.min.js"></script>
  <SCRIPT type="text/javascript" >
  $(function(){
	  var zTreeObj;
	   // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
	   var setting = {
		   async:{
			   enable: true,
			   type: "get",
			   url: "http://localhost:8080/zTreeStudy/dept/getDepts",  
		   },
		   //data放置有先后顺序，不然有可能树的上下级未初始化
		  /*  data: {
				simpleData: {
					enable: true,
					idKey: "id",
					pIdKey: "pId",
					rootPId: 0
				}
			}, */
			 data: {
				    key:{
				    	name:"deptName"
				    },
					simpleData: {
						enable: true,
						idKey: "deptId",
						pIdKey: "deptParentId",
						rootPId: 0
					}
				},
			//回调函数执行，与edit属性有顺序关系
			callback: {
				//拖拽
				onDrag: zTreeOnDrag,
				//拖拽过程中
				onDragMove: zTreeOnDragMove
			},
			view: {
		    //鼠标放到接点上，显示默认自定义控件，类似显示一个新增的按钮
			addHoverDom: addHoverDom,
			//removeHoverDom: removeHoverDom
	        }, 
	       edit:{
		   enable: true,
		   //显示自带按钮
		   showRemoveBtn : true,
		   showRenameBtn : true,
		   drag:{
			   //拖拽
			   isMove:true,
			   //isCopy:true
		   }
		   
			
	   }};
	   // zTree 的数据属性，深入使用请参考 API 文档（zTreeNode 节点数据详解）
	   var zNodes = [
	   {name:"test1", open:true, children:[
	      {name:"test1_1"}, {name:"test1_2"},{name:"test1_3",open:true,children:[{name:"test1_3_1",open:true}]}]},
	   {name:"test2", open:true, children:[
	      {name:"test2_1"}, {name:"test2_2"}]}
	   ];
	   
	   var treeNodes = [
	                    //设置图片图标，固定了
	                    {"id":1, "pId":0, "name":"test1",icon:"../../css/zTree/zTreeStyle/img/diy/1_open.png"},
	                    {"id":11, "pId":1, "name":"test11"},
	                    {"id":12, "pId":1, "name":"test12"},
	                    {"id":111, "pId":11, "name":"test111"},
	                    {"id":112, "pId":11, "name":"test112"},
	                    {"id":121, "pId":12, "name":"test121"},
	                    {"id":122, "pId":12, "name":"test122"}
	                ];
	   
	   
	   $(document).ready(function(){
	      //zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, treeNodes);
	      debugger;
		   zTreeObj = $.fn.zTree.init($("#treeDemo"), setting);
	   });
  });
   
   
   
   function addDiyDom(treeId, treeNode) {
	   
		var aObj = $("#" + treeNode.tId + "_a");
		if ($("#diyBtn_"+treeNode.id).length>0) return;
		var editStr = "<span id='diyBtn_space_" +treeNode.id+ "' > </span>"
			+ "<button type='button' class='diyBtn1' id='diyBtn_" + treeNode.id
			+ "' title='"+treeNode.name+"' onfocus='this.blur();'></button>";
		aObj.append(editStr);
		var btn = $("#diyBtn_"+treeNode.id);
		if (btn) btn.bind("click", function(){alert("diy Button for " + treeNode.name);});
	};
	
	function addHoverDom(treeId, treeNode) {
		//debugger;
		var aObj = $("#" + treeNode.tId + "_a");
		if ($("#diyBtn_"+treeNode.id).length>0) return;
		var editStr = "<span id='diyBtn_space_" +treeNode.id+ "' > </span>"
			+ "<button type='button' class='diyBtn1' id='diyBtn_" + treeNode.id
			+ "' title='"+treeNode.name+"' onfocus='this.blur();'></button>";
		aObj.append(editStr);
		var btn = $("#diyBtn_"+treeNode.id);
		if (btn) btn.bind("click", function(){alert("diy Button for " + treeNode.name);});
	};
	function removeHoverDom(treeId, treeNode) {
		$("#diyBtn_"+treeNode.id).unbind().remove();
		$("#diyBtn_space_" +treeNode.id).unbind().remove();
	};
	
	function zTreeOnDrag(event, treeId, treeNodes) {
		debugger;
	    alert(treeNodes.length);
	};
	
	function zTreeOnDragMove(event, treeId, treeNodes) {
		debugger;
	    console.log(event.target);
	};
  </SCRIPT>
 </HEAD>
<BODY>
<div>
   <ul id="treeDemo" class="ztree"></ul>
</div>
</BODY>
</HTML>