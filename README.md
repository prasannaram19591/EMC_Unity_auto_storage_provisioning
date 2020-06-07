# EMC_Unity_auto_storage_provisioning

This code provides the ability to automate EMC Unity 480 XT LUN creation and mapping to clustered hosts with a single click job using shell scripting as backend and Jenkins as UI frontend. LUNs are thin provisioned, compression, dedupe and advanced dedupe enabled while creation itself so that you get the complete benefits of storage efficiency. LUN creation, allocation to hosts with proper HLU IDs for different host clusters is no longer a time consuming and manual task. With the help of Jenkins storage requestors will be mailed automatically about their auto provisioned LUNs..

Pre-Requisites..

1.  Working EMC Unity storage box.
2.  UEMCLI installed on any Linux machine.
3.  Optional Jenkins for UI needs.

