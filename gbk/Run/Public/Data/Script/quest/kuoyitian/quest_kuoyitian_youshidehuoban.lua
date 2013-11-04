--��ʱ�Ļ��

--MisDescBegin
x214001_g_ScriptId = 214001
x214001_g_MissionIdPre =107
x214001_g_MissionId = 108
x214001_g_MissionKind = 3
x214001_g_MissionLevel = 15
x214001_g_ScriptIdNext = {ScriptId = 214002 ,LV = 1 }
x214001_g_Name	="��ľ��"
x214001_g_Name2	="�ϴ�"  
x214001_g_DemandItem ={}
x214001_g_DemandKill ={{id=358,num=25}}

x214001_g_MissionName="��ʱ�Ļ��"
x214001_g_MissionInfo="    ��9���ʱ��̩������׷ɱ���ϴ𰲾�����һ���������Ҳ�����ë�������ʱ�����Ҿͷ��ģ����ҳ�����һ��Ȣ��Ϊ�ޡ�\n \n    һֱ�������Ҷ�û�����ǹ�������<��ľ��˵�������ʱ��¶����һ˿��ɬ>\n \n    ���ͱ�����D����"  --��������
x214001_g_MissionInfo2="����Ҫ�����ȥ������25��Χ������̩�����˸�ɱ�ˣ�������������"
x214001_g_MissionTarget="    ��D��ȥ��ɱ��25��#R̩����ʿ��#W��Ȼ���#G�ϴ�#W̸̸��"		                                                                                               
x214001_g_MissionComplete="    лл�����ȣ�"					--�������npc˵���Ļ�
x214001_g_ContinueInfo="    ��ɱ�˸�������Щ̩����������"
--������
x214001_g_MoneyBonus = 600
--�̶���Ʒ���������8��
x214001_g_ItemBonus={}

--��ѡ��Ʒ���������8��
x214001_g_RadioItemBonus={}

--MisDescEnd
x214001_g_ExpBonus = 6500
--**********************************

--������ں���

--**********************************

function x214001_OnDefaultEvent(sceneId, selfId, targetId)	--����������ִ�д˽ű�

	--����г�����
	if x214001_CheckPushList(sceneId, selfId, targetId) <= 0 then
		return
	end

	--����ѽӴ�����
	if IsHaveMission(sceneId,selfId, x214001_g_MissionId) > 0 then
	misIndex = GetMissionIndexByID(sceneId,selfId,x214001_g_MissionId)
		if x214001_CheckSubmit(sceneId, selfId, targetId) <= 0 then
                        BeginEvent(sceneId)
			AddText(sceneId,"#Y"..x214001_g_MissionName)
			AddText(sceneId,x214001_g_ContinueInfo)
		        AddText(sceneId,"#Y����Ŀ��#W") 
			AddText(sceneId,x214001_g_MissionTarget) 
			AddText(sceneId,format("\n    ɱ��̩����ʿ��   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214001_g_DemandKill[1].num ))
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
		end

		     
                if x214001_CheckSubmit(sceneId, selfId, targetId) > 0 then
                     BeginEvent(sceneId)
                     AddText(sceneId,"#Y"..x214001_g_MissionName)
		     AddText(sceneId,x214001_g_MissionComplete)
		     AddMoneyBonus(sceneId, x214001_g_MoneyBonus)
		     EndEvent()
                     DispatchMissionContinueInfo(sceneId, selfId, targetId, x214001_g_ScriptId, x214001_g_MissionId)
                end

        elseif x214001_CheckAccept(sceneId, selfId, targetId) > 0 then
	    	
		--�����������ʱ��ʾ����Ϣ
		BeginEvent(sceneId)
		AddText(sceneId,"#Y"..x214001_g_MissionName)
                AddText(sceneId,x214001_g_MissionInfo..GetName(sceneId, selfId)..x214001_g_MissionInfo2) 
		AddText(sceneId,"#Y����Ŀ��#W") 
		AddText(sceneId,x214001_g_MissionTarget) 
		AddMoneyBonus(sceneId, x214001_g_MoneyBonus)	
		EndEvent()
		
		DispatchMissionInfo(sceneId, selfId, targetId, x214001_g_ScriptId, x214001_g_MissionId)
        end
	
end



--**********************************

--�о��¼�

--**********************************

function x214001_OnEnumerate(sceneId, selfId, targetId)


	--��������ɹ��������
	if IsMissionHaveDone(sceneId, selfId, x214001_g_MissionId) > 0 then
		return 
	end
	--����ѽӴ�����
	if  x214001_CheckPushList(sceneId, selfId, targetId) > 0 then
		AddNumText(sceneId, x214001_g_ScriptId, x214001_g_MissionName)
	end
	
end



--**********************************

--����������

--**********************************

function x214001_CheckAccept(sceneId, selfId, targetId)

	if (GetName(sceneId,targetId)==x214001_g_Name) then 
					return 1
	end
	return 0
end


--**********************************

--���鿴����

--**********************************

function x214001_CheckPushList(sceneId, selfId, targetId)
	if (sceneId==14) then
		if IsMissionHaveDone(sceneId, selfId, x214001_g_MissionIdPre) > 0 then
			if (GetName(sceneId,targetId)==x214001_g_Name) then 
				if IsHaveMission(sceneId,selfId, x214001_g_MissionId) <= 0 then
        	    			return 1
        	    		end
        	    	end
        	    	if (GetName(sceneId,targetId)==x214001_g_Name2) then 
				if IsHaveMission(sceneId,selfId, x214001_g_MissionId) > 0 then
        	    			return 1
        	    		end
        	    	end
        	end
        end
        return 0
	
end

--**********************************

--����

--**********************************

function x214001_OnAccept(sceneId, selfId)

	        BeginEvent(sceneId)
		AddMission( sceneId, selfId, x214001_g_MissionId, x214001_g_ScriptId, 1, 0, 0)
		AddText(sceneId,"��������"..x214001_g_MissionName) 
		EndEvent()
		DispatchMissionTips(sceneId, selfId)
		                                               
	     
end



--**********************************

--����

--**********************************

function x214001_OnAbandon(sceneId, selfId)

	--ɾ����������б��ж�Ӧ������
	DelMission(sceneId, selfId, x214001_g_MissionId)
	for i, item in x214001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
	end

end



--**********************************

--����Ƿ�����ύ

--**********************************

function x214001_CheckSubmit( sceneId, selfId, targetId)
	misIndex = GetMissionIndexByID(sceneId,selfId,x214001_g_MissionId)
	if GetMissionParam(sceneId,selfId,misIndex,0) == x214001_g_DemandKill[1].num then
	        return 1
	end
	return 0

end



--**********************************

--�ύ

--**********************************

function x214001_OnSubmit(sceneId, selfId, targetId, selectRadioId)

	if DelMission(sceneId, selfId, x214001_g_MissionId) > 0 then
	
		MissionCom(sceneId, selfId, x214001_g_MissionId)
		AddExp(sceneId, selfId, x214001_g_ExpBonus)
		AddMoney(sceneId, selfId, x214001_g_MoneyBonus)
		for i, item in x214001_g_RadioItemBonus do
	        if item.id == selectRadioId then
	        item={{selectRadioID, 1}}
	        end
	        end

		for i, item in x214001_g_DemandItem do
		DelItem(sceneId, selfId, item.id, item.num)
		end
		CallScriptFunction( x214001_g_ScriptIdNext.ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
	

	
end



--**********************************

--ɱ����������

--**********************************

function x214001_OnKillObject(sceneId, selfId, objdataId)
	 if IsHaveMission(sceneId, selfId, x214001_g_MissionId) > 0 then 
	 misIndex = GetMissionIndexByID(sceneId,selfId,x214001_g_MissionId)  
	 num = GetMissionParam(sceneId,selfId,misIndex,0) 
	 	 if objdataId == x214001_g_DemandKill[1].id then 
       		    if num < x214001_g_DemandKill[1].num then
       		    	 SetMissionByIndex(sceneId,selfId,misIndex,0,num+1)
       		         BeginEvent(sceneId)
			 AddText(sceneId,format("ɱ��̩����ʿ��   %d/%d", GetMissionParam(sceneId,selfId,misIndex,0),x214001_g_DemandKill[1].num )) 
			 EndEvent()
			 DispatchMissionTips(sceneId, selfId)
		    end
       		 end
       		 
      end  

end



--**********************************

--���������¼�

--**********************************

function x214001_OnEnterArea(sceneId, selfId, zoneId)

end



--**********************************

--���߸ı�

--**********************************

function x214001_OnItemChanged(sceneId, selfId, itemdataId)

end
