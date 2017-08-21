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
  var zNodes;
//zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
  var setting = {
	    async:{
		   enable: true,
	   }, 
	   //data放置有先后顺序，不然有可能树的上下级未初始化
		  data: {
			    key:{
			    	name:"deptname"
			    },
				simpleData: {
					enable: true,
					idKey: "deptid",
					pIdKey: "deptparentid",
					icon:"icon",
					open:"open",
					rootPId: 0
				}
			}, 
		//回调函数执行，与edit属性有顺序关系
		callback: {
			//拖拽
			//onDrag: zTreeOnDrag,
			//拖拽过程中
			//onDragMove: zTreeOnDragMove,
			//beforeDrag: zTreeBeforeDrag,
			onDrop: zTreeOnDrop,
			beforeRemove: zTreeBeforeRemove,
			beforeEditName: beforeEditName,
			
		},
		view: {
	    //鼠标放到接点上，显示默认自定义控件，类似显示一个新增的按钮
		addHoverDom: addHoverDom,
		removeHoverDom: removeHoverDom
       }, 
      edit:{
	   enable: true,
	   //不显示自带按钮
	   //showRemoveBtn : false,
	   //showRenameBtn : false,
	   showRemoveBtn: showRemoveBtn,
	   showRenameBtn: showRenameBtn,
	   removeTitle: "删除组织机构",
	   renameTitle: "修改组织机构",
	   drag:{
		   //拖拽
		   isMove:true,
		   //isCopy:true
	   }
  }};
  $(function(){
	  updateTree();
	   
	   // zTree 的数据属性，深入使用请参考 API 文档（zTreeNode 节点数据详解）
	   var treeNodes = [
	                    //设置图片图标，固定了
	                    {"id":1, "pId":0, "name":"test1",icon:"<%=path%>/css/zTree/zTreeStyle/img/diy/1_open.png"},
	                    {"id":11, "pId":1, "name":"test11"},
	                    {"id":12, "pId":1, "name":"test12"},
	                    {"id":111, "pId":11, "name":"test111"},
	                    {"id":112, "pId":11, "name":"test112"},
	                    {"id":121, "pId":12, "name":"test121"},
	                    {"id":122, "pId":12, "name":"test122"}
	                ];
	   
  });
   
   
   
/*    function addDiyDom(treeId, treeNode) {
	   
		var aObj = $("#" + treeNode.tId + "_a");
		if ($("#diyBtn_"+treeNode.id).length>0) return;
		var editStr = "<span id='diyBtn_space_" +treeNode.id+ "' > </span>"
			+ "<button type='button' class='diyBtn1' id='diyBtn_" + treeNode.id
			+ "' title='"+treeNode.name+"' onfocus='this.blur();'></button>";
		aObj.append(editStr);
		var btn = $("#diyBtn_"+treeNode.id);
		if (btn) btn.bind("click", function(){alert("diy Button for " + treeNode.name);});
	}; */
	
	//在树节点后增加添加按钮
	function addHoverDom(treeId, treeNode) {
		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
		if (treeNode.level <= 2) {
			var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='添加组织机构' onfocus='this.blur();'  onclick='removeDataDept()'></span>";
			sObj.after(addStr);
			var btn = $("#addBtn_"+treeNode.tId);
			if (btn) btn.bind("click", function(){
				/* thisformnodeId=treeNode.tId;
				
				var parentName = getParentDeptName(treeNode);
				if (parentName == "") {
					$("#parentDept").html(treeNode.name);
				} else {
					$("#parentDept").html(parentName + "/" + treeNode.name);
				}
				$("#parentDeptId").val(treeNode.id);
				$("#newDepartment").modal("show"); */
				alert('添加成功')
				return false;
			});
		}
	};
	//
	function removeDataDept(){
		/* $("#addMememberUserList").html("")
		$("#addOrgNo").val("");
		$("#addOrgName").val("")
		debugger;
		$("#parentDeptId").next().find("textarea").val(""); */
	}
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};
	
	 /* function addHoverDom(treeId, treeNode) {
		//debugger;
		var aObj = $("#" + treeNode.tId + "_a");
		if ($("#diyBtnAd_"+treeNode.deptid).length>0) return;
		var editStr = "<span id='diyBtn_space_" +treeNode.deptid+ "' > </span>"
			+ "<button type='button' value='新增' class='diyBtn1' id='diyBtnAd_" + treeNode.deptid
			+ "' title='新增' onfocus='this.blur();'></button>" 
			+ " <button type='button' value='修改' class='diyBtn2' id='diyBtnEd_" + treeNode.deptid
			+ "' title='修改' onfocus='this.blur();'></button>"
			+ " <button type='button' value='删除' class='diyBtn3' id='diyBtnDe_" + treeNode.deptid
			+ "' title='删除' onfocus='this.blur();'></button>";
		aObj.append(editStr);
		var btnAd = $("#diyBtnAd_"+treeNode.deptid);
		var btnEd = $("#diyBtnEd_"+treeNode.deptid);
		var btnDe = $("#diyBtnDe_"+treeNode.deptid);
		if (btnAd) btnAd.bind("click", function(){
			debugger;
			alert("diy Button for 新增 " + treeNode.deptname);});
		if (btnEd) btnEd.bind("click", function(){
			debugger;
			alert("diy Button for 修改" + treeNode.deptname);});
		if (btnDe) btnDe.bind("click", function(){
			debugger;
			alert("diy Button for 删除" + treeNode.deptname);});
	};
	function removeHoverDom(treeId, treeNode) {
		//新增按钮
		$("#diyBtnAd_"+treeNode.deptid).unbind().remove();
		//修改按钮
		$("#diyBtnEd_"+treeNode.deptid).unbind().remove();
		//删除按钮
		$("#diyBtnDe_"+treeNode.deptid).unbind().remove();
		$("#diyBtn_space_" +treeNode.deptid).unbind().remove();
	};  */
	/* function addHoverDom(treeId, treeNode) {
		debugger;
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
	}; */
	/* function zTreeOnDrag(event, treeId, treeNodes) {
		debugger;
	    alert(treeNodes.length);
	};
	
	function zTreeOnDragMove(event, treeId, treeNodes) {
		debugger;
	    console.log(event.target);
	}; */
	
	//拖拽的节点
	//v3.x 允许多个同级节点同时被拖拽，因此将此参数修改为 Array(JSON)
    //如果拖拽时多个被选择的节点不是同级关系，则只能拖拽鼠标当前所在位置的节点
    //拖拽的数组id
  /*   var dragIds =[]
	function zTreeBeforeDrag(treeId, treeNodes){
		debugger;
		for(var i = 0,l=treeNodes.length;i<l;i++){
			var tempId = treeNodes[i];
			dragIds.push(tempId.deptid);
			//禁止拖拽
			 if(tempId.drag == false){
				return false;
			} 
		} 
		return true;
	} */
	//拖拽后
    function zTreeOnDrop(event, treeId, treeNodes, targetNode, moveType) {
		debugger;
		if(treeNodes[0].deptparentid==targetNode.deptparentid){
			return true;
		}
        console.log(treeNodes.length + "," + (targetNode ? (targetNode.tId + ", " + targetNode.name) : "isRoot" ));
        
       // var dragIds =[];
        var   dragIds= new Array();
        for(var i = 0,l=treeNodes.length;i<l;i++){
			var tempId = treeNodes[i];
			dragIds.push(tempId.deptid);
		} 
       // var deptIds = JSON.stringify(dragIds); 
        var data ={};
       // var data ={"newParaentId":targetNode.deptid,"deptIds":deptIds};
        data.newParaentId = targetNode.deptid;
        data.deptIds = dragIds;
        $.ajax({
        	type:"post",
        	data:data,
        	url:"<%=path%>/dept/upDePaIdByDrag",
        	//dataType:"json",
        	//contentType:"application/json", 
        	sucess:function(data){
        		 if(data.isSuccess ==true){
        			 updateTree();
        		 }
        	 },error:function(data){
        		 alert("拖拽发生错误");
        	 }
        });
    };
    
    //更新树
    function updateTree(){
    	 $.ajax({
   		  url :"<%=path%>/dept/getDepts",
   	        	dataType:"json",
   	        	async:true,
   	        	success:function(data){
   	        		debugger;
   	        		zNodes = data.data;
   	        		zTreeObj = $.fn.zTree.init($("#treeDemo"), setting,zNodes);
   	        		//var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
   	        		//var nodes = treeObj.getNodes();
   	        		//var nodes = zTreeObj.getNodes();
   	        		var nodes =zTreeObj.transformToArray(zTreeObj.getNodes());
   	        		for(var i = 0;i<nodes.length;i++){
   	        			/* if(nodes[i].level==0){
   	        				nodes[i].icon= "icon01";
   		        			//调用updateNode(node)接口进行更新
   		        			zTree.updateNode(nodes[i]);
   	        			} */
   	        			if(nodes[i].level==0){
   	        				nodes[i].icon= "<%=path%>/css/zTree/zTreeStyle/img/diy/1_open.png";
   		        			//nodes[i].open=false;
   	        				//调用updateNode(node)接口进行更新
   		        			zTreeObj.updateNode(nodes[i]);
   		        			continue;
   	        			}
   	        			if(nodes[i].level==1){
   	        				nodes[i].icon= "<%=path%>/css/zTree/zTreeStyle/img/diy/1_close.png";
   	        				//nodes[i].open=false;
   	        				//调用updateNode(node)接口进行更新
   		        			zTreeObj.updateNode(nodes[i]);
   		        			continue;
   	        			}
   	        			
   	        			if(nodes[i].level==2){
   	        				nodes[i].icon= "<%=path%>/css/zTree/zTreeStyle/img/diy/1_close.png";
   	        				//nodes[i].open=false;
   	        				//调用updateNode(node)接口进行更新
   		        			zTreeObj.updateNode(nodes[i]);
   		        			continue;
   	        			}
   	        			if(nodes[i].level==3){
   	        				nodes[i].icon= "<%=path%>/css/zTree/zTreeStyle/img/diy/1_close.png";
   	        				//nodes[i].open=false;
   	        				//调用updateNode(node)接口进行更新
   		        			zTreeObj.updateNode(nodes[i]);
   		        			continue;
   	        			}
	        			
        			}
   	        	}
   	  });
    }
    
  //是否显示删除按钮
	function showRemoveBtn(treeId, treeNode){
		if(treeNode.showRemoveBtn == false){
			return false;
		}
		return true;
	}
	//是否显示编辑按钮
	function showRenameBtn(treeId, treeNode){
		if(treeNode.showRenameBtn == false){
			return false;
		}
		return true;
	}
	//删除前执行
	function zTreeBeforeRemove(treeId, treeNode){
		//禁止删除
		//TODO 
		//增加删除弹出框
		alert('删除成功'+treeNode.deptparentid);
		return false;
	}
	//禁止编辑
	function beforeEditName(treeId, treeNode){
		var level = treeNode.level;
		debugger;
		//TODO 
		//增加编辑弹出框
		alert('编辑成功'+treeNode.deptparentid);
		return false;
	}
  </SCRIPT>
 </HEAD>
<BODY>
<div>
   <ul id="treeDemo" class="ztree"></ul>
</div>
</BODY>
</HTML>