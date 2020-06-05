# EMC_Unity_auto_storage_provisioning

This code provides the ability to automate EMC Unity 480 XT LUN creation and mapping to clustered hosts with a single click job using shell scrpting as backend and jenkins as UI frontend. Lun creation, aloocation to hosts with proper HLU IDs for different host clusters is no longer a time consuming and manual task. With the help of jenkins storage requestors will be mailed automatically about their auto provisioned LUNs..

Pre-Requisites..

1.  Working EMC Unity storage box.
2.  UEMCLI installed on any linux machine.
3.  Optional jenkins for UI needs.
