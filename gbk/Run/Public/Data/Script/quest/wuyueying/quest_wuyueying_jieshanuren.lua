--截杀奴人

--MisDescBegin
x217010_g_ScriptId = 217010
x217010_g_MissionIdPre =181
x217010_g_MissionId = 182
x217010_g_MissionKind = 6
x217010_g_MissionLevel = 30
--x217010_g_ScriptIdNext = {ScriptId = 217010 ,LV = 1 }
x217010_g_Name	="拖雷" 
x217010_g_DemandItem ={}
x217010_g_DemandKill ={{id=456,num=20}}

x217010_g_MissionName="截杀奴人"
x217010_g_MissionInfo="    投效我们大蒙古国的郭宝玉，他知天文，通兵法，父汗得此大将，高兴得开了一次百羊宴！我得多谢你！\n \n    不过，找你可不是为了参加百羊宴，而是让你帮郭将军一个忙。他已经投效我们，这消息泄露到了金国那里，千家奴派他的手下赶往郭将军的老家。\n \n    "  --任务描述
x217010_g_MissionInfo2="，你要阻止这件事，在小粮仓的小道上，把他们拦截住杀了，不能让郭将军的家人受到损伤。"
x217010_g_MissionTarget="    #G拖雷#W命你到#G小粮仓#W的小道上，截杀20名#R乌月营奴人#W。"		                                                                                               
x217010_g_MissionComplete="    听到这消息，我就安心了，一路上辛苦了。"					--完成任务npc说话的话
x217010_g_ContinueInfo="    你一定要拦截住那些奴人。"
--任务奖励
x217010_g_MoneyBonus = 500

--固定物品奖励，最多8种
x217010_g_ItemBonus={}

--可选物品奖励，最多8种
x217010_g_RadioItemBonus={}

--MisDescEnd
x217010_g_ExpBonus = 4000
--**********************************

--任务入口函数

--**********************************

function x217010_OnDefaultEvent(sceneId, selfId, targetId)	--点击该任务后执行此脚本

	--检测列出条件
	if x217010_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--如果已接此任务
	if IsHaveMission(sceneId,selfId, x217010_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x217010_g_MissionId)
		if x217010_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x217010_g_MissionName)
			AddText(sceneId,x217010_g_ContinueInfo)
		        AddText(sceneId,"#Y任务目标#W") 
			AddText(sceneId,x217010_g_MissionTarget) 
			AddText(sceneId,format("\n    杀死乌月营奴人   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217010_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x217010_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x217010_g_MissionName)
		     AddText(sceneId,x217010_g_MissionComplete)
		     AddMoneyBonus(sceneId, x217010_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x217010_g_ScriptId, x217010_g_MissionId)
                end

        elseif x217010_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x217010_g_MissionName)
                AddText(sceneId,x217010_g_MissionInfo..GetName(sceneId, selfId)..x217010_g_MissionInfo2) 
		AddText(sceneId,"#Y任务目标#W") 
		AddText(sceneId,x217010_g_MissionTarget) 
		AddMoneyBonus(sceneId, x217010_g_MoneyBonus)
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x217010_g_ScriptId, x217010_g_MissionId)
        end
	
end



--**********************************

--列举事件

--**********************************

function x217010_OnEnumerate(sceneId, selfId, targetId)


	--如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId, selfId, x217010_g_MissionId) > 0 then
		return 
	end
	--如果已接此任务
	if  x217010_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x217010_g_ScriptId, x217010_g_MissionName)
	end
	
end



--**********************************

--检测接受条件

--**********************************

function x217010_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x217010_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--检测查看条件

--**********************************

function x217010_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==20) then
		if IsMissionHaveDone(sceneId, selfId, x217010_g_MissionIdPre) > 0 then
        	    	return 1
        	end
        end
        return 0
	
end

--**********************************

--接受

--**********************************

function x217010_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x217010_g_MissionId, x217010_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"接受任务："..x217010_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--放弃

--**********************************

function x217010_OnAbandon(sceneId, selfId)

	--删除玩家任务列表中对应的任务
	DelMission(sceneId, selfId, x217010_g_MissionId)
	for i, item in x217010_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--检测是否可以提交

--**********************************

function x217010_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x217010_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x217010_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--提交

--**********************************

function x217010_OnSubmit(sceneId, selfId, targetId, selectRadioId)
	if DelMission(sceneId, selfId, x217010_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x217010_g_MissionId)
		AddExp(sceneId, selfId, x217010_g_ExpBonus)
		AddMoney(sceneId, selfId, x217010_g_MoneyBonus)
		for i, item in x217010_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x217010_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		--CallScriptFunction( x217010_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--杀死怪物或玩家

--**********************************

function x217010_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x217010_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x217010_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x217010_g_DemandKill[1].id then 
       		    if num < x217010_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("杀死乌月营奴人   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x217010_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--进入区域事件

--**********************************

function x217010_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--道具改变

--**********************************

function x217010_OnItemChanged(sceneId, selfId, itemdataId)

end

