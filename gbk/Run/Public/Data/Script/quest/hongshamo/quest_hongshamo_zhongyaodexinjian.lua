--重要的信件

--MisDescBegin
x205001_g_ScriptId = 205001
x205001_g_MissionIdPre =40
x205001_g_MissionId = 41
x205001_g_MissionKind = 11
x205001_g_MissionLevel = 55
--x205001_g_ScriptIdNext = {ScriptId = 205002 ,LV = 1 }
x205001_g_Name	="艾山" 
x205001_g_Name2	="速不台" 
x205001_g_DemandItem ={{id=13010006,num=1}}
x205001_g_noDemandKill ={{id=301,num=1}}	

x205001_g_MissionName="重要的信件"
x205001_g_MissionInfo="    <见到了你，商团的团长艾山一脸苍白，身边的那些尸体是跟随他多年的朋友和亲人，而他负责押运的那些马匹和货物，已经被盗贼给抢走。>\n \n    西北方向（30，45）跑了，不用管我，你一定要追上那些盗贼，把我们的货物给抢回来！因为……那些货物里面有一封很重要的信，一定要拿回来，交给#G速不台#W将军保管"  --任务描述
x205001_g_MissionTarget="    杀掉#R逃窜的盗贼#W（30，45），把#c0080C0重要的信#W信给抢回来，交给#G速不台#W将军。"		
x205001_g_MissionComplete="    幸好有你的帮忙，这封信千万不能丢失。"					--完成任务npc说话的话
x205001_g_ContinueInfo="    不管付出多大代价，也要把那件东西给拿回来。"
--任务奖励
x205001_g_MoneyBonus = 10000
--固定物品奖励，最多8种
x205001_g_ItemBonus={}

--可选物品奖励，最多8种
x205001_g_RadioItemBonus={}

--MisDescEnd
x205001_g_ExpBonus = 1000
--**********************************

--任务入口函数

--**********************************

function x205001_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x205001_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x205001_g_MissionId) > 0 then
		if x205001_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x205001_g_MissionName)
			AddText(sceneId,x205001_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x205001_g_MissionTarget) 
			AddText(sceneId,format("\n    重要的信   %d/%d", LuaFnGetItemCount(sceneId,selfId,x205001_g_DemandItem[1].id),x205001_g_DemandItem[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x205001_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x205001_g_MissionName)
		     AddText(sceneId,x205001_g_MissionComplete)
		     --AddText(sceneId,"#Y需要物品#W") 
		     --for i, item in pairs(x205001_g_DemandItem) do  
		     --AddItemBonus(sceneId, item.id, item.num)
		     --end
		     AddMoneyBonus(sceneId, x205001_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x205001_g_ScriptId, x205001_g_MissionId)
                end

        elseif x205001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x205001_g_MissionName)
                AddText(sceneId,x205001_g_MissionInfo) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x205001_g_MissionTarget) 
		AddMoneyBonus(sceneId, x205001_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x205001_g_ScriptId, x205001_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x205001_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x205001_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x205001_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x205001_g_ScriptId, x205001_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x205001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x205001_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x205001_CheckPushList(sceneId, selfId, targetId)
        if (sceneId==5) then
        	if (GetName(sceneId,targetId)==x205001_g_Name) then
        	       if IsMissionHaveDone(sceneId, selfId, x205001_g_MissionIdPre) > 0 then
        	            if IsHaveMission(sceneId,selfId, x205001_g_MissionId)<= 0 then
        	            	return 1
        	            end
        	       end
        	end
		if (GetName(sceneId,targetId)==x205001_g_Name2) then
			    if IsHaveMission(sceneId,selfId, x205001_g_MissionId) > 0 then
			    	return 1
        	            end
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x205001_OnAccept(sceneId, selfId)

	                                                  
		        BeginEvent(sceneId)
			AddMission( sceneId, selfId, x205001_g_MissionId, x205001_g_ScriptId, 1, 0, 0)
			AddText(sceneId,"接受任务："..x205001_g_MissionName) 
			EndEvent()
			DispatchMissionTips(sceneId, selfId)                   
	                                                                     
	     
end



--**********************************

--放弃

--**********************************

function x205001_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x205001_g_MissionId)
	for i, item in pairs(x205001_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x205001_CheckSubmit( sceneId, selfId, targetId)

	if LuaFnGetItemCount(sceneId,selfId,x205001_g_DemandItem[1].id) == x205001_g_DemandItem[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x205001_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x205001_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x205001_g_MissionId)
		AddExp(sceneId, selfId, x205001_g_ExpBonus)
		AddMoney(sceneId, selfId, x205001_g_MoneyBonus)
		for i, item in pairs(x205001_g_RadioItemBonus) do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in pairs(x205001_g_DemandItem) do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x205001_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x205001_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x205001_g_MissionId) >= 0 then                                       
       		 if objdataId == x205001_g_noDemandKill[1].id then 
       		    if LuaFnGetItemCount(sceneId,selfId,x205001_g_DemandItem[1].id) < x205001_g_DemandItem[1].num then
       		         if random(1,100)>90 then
       		        	 BeginAddItem(sceneId)                                                    
				 AddItem( sceneId,x205001_g_DemandItem[1].id, 1 )             
				 ret = EndAddItem(sceneId,selfId)                                 
		        	 if ret > 0 then                                                  
		        	 	BeginEvent(sceneId)
				 	AddText(sceneId,format("重要的信   %d/%d", LuaFnGetItemCount(sceneId,selfId,x205001_g_DemandItem[1].id)+1,x205001_g_DemandItem[1].num )) 
				 	EndEvent()
				 	DispatchMissionTips(sceneId, selfId)
				 	AddItemListToHuman(sceneId,selfId) 
		        	 else                                                             
		        	 	BeginEvent(sceneId)                                      
				     	AddText(sceneId,"物品栏已满！")                    
				        EndEvent(sceneId)                                        
				        DispatchMissionTips(sceneId,selfId) 
				 end                     
		         end             
       		    end
       		 end
       		 
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x205001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x205001_OnItemChanged(sceneId, selfId, itemdataId)

end

