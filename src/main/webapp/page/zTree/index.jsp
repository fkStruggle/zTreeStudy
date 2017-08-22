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
  <link rel="stylesheet" href="<%=path %>/css/zTree/zTreeStyle/zTreeStyle.css" type="text/css">
  <link rel="stylesheet" href="<%=path%>/bootstrap/css/bootstrap.min.css">
 </HEAD>
<BODY>
<div>
   <ul id="treeDemo" class="ztree"></ul>
</div>

<!-- 新增弹出狂 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" id="myModalLabel">
					新增机构
				</h4>
			</div>
			<div class="modal-body">
				机构名称:<input id="orgName" type="text" name ="deptname"/>
				      <input id="deptparentid" type="hidden" name ="deptparentid"/>
			</div>
			<div class="modal-footer">
				<span class="btn btn-default" data-dismiss="modal">
					关闭
				</span>
				<span class="btn btn-primary" onclick="addDept();">
					确定
				</span>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
	
	
</div>

<script type="text/javascript" src="<%=path%>/js/importJs/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="<%=path%>/js/importJs/zTree/jquery.ztree.all.min.js"></script>
  <script type="text/javascript" src="<%=path%>/bootstrap/js/bootstrap.min.js"></script>
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
	//在树节点后增加添加按钮
	function addHoverDom(treeId, treeNode) {
		//新增时先清空deptparentid与orgname
		$("#deptparentid").val('');
		$("#orgName").val('');
		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
		//if (treeNode.level <= 2) {
			var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='添加组织机构' onfocus='this.blur();'  onclick='removeDataDept()'></span>";
			sObj.after(addStr);
			var btn = $("#addBtn_"+treeNode.tId);
			if (btn) btn.bind("click", function(){
				$('#myModal').modal("show");
				$("#deptparentid").val(treeNode.deptid);
				return false;
			});
		//}
	};
	//
	function removeDataDept(){
	}
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};
	
	//拖拽后
    function zTreeOnDrop(event, treeId, treeNodes, targetNode, moveType) {
		debugger;
		if(treeNodes[0].deptparentid==targetNode.deptparentid){
			return true;
		}
        console.log(treeNodes.length + "," + (targetNode ? (targetNode.tId + ", " + targetNode.name) : "isRoot" ));
        
        var   dragIds= new Array();
        for(var i = 0,l=treeNodes.length;i<l;i++){
			var tempId = treeNodes[i];
			dragIds.push(tempId.deptid);
		} 
        var data ={};
        data.newParaentId = targetNode.deptid;
        data.deptIds = dragIds;
        $.ajax({
        	type:"post",
        	data:data,
        	url:"<%=path%>/dept/upDePaIdByDrag",
        	success:function(data){
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
   	        		zNodes = data.data;
   	        		zTreeObj = $.fn.zTree.init($("#treeDemo"), setting,zNodes);
   	        		var nodes =zTreeObj.transformToArray(zTreeObj.getNodes());
   	        		for(var i = 0;i<nodes.length;i++){
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
   	        				nodes[i].icon= "<%=path%>/css/zTree/zTreeStyle/img/diy/3.png";
   	        				//nodes[i].open=false;
   	        				//调用updateNode(node)接口进行更新
   		        			zTreeObj.updateNode(nodes[i]);
   		        			continue;
   	        			}
   	        			if(nodes[i].level==3){
   	        				nodes[i].icon= "<%=path%>/css/zTree/zTreeStyle/img/diy/5.png";
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
		//TODO 
		//增加编辑弹出框
		alert('编辑成功'+treeNode.deptparentid);
		return false;
	}
	
	//新增部门
	function addDept(){
		var orgName = $("#orgName").val();
		var deptparentid = $("#deptparentid").val();
		var data={};
		data.deptname = orgName;
		data.deptparentid = deptparentid;
		$.ajax({
			 url :"<%=path%>/dept/insDept",
			 type:"post",
			 data:JSON.stringify(data),
			 contentType:"application/json;charset=utf-8",
			 success:function(data){
				 if(data.isSuccess ==true){
					 updateTree();
					 $("#myModal").modal("hide");
				 }
			 }
		});
	}
  </SCRIPT>
</BODY>
</HTML>