#!/bin/bash

source emc_uty_480
rm -f created_lun_name
calc(){ awk "BEGIN { print "$*" }"; }

#Function to calculate concurrent LUN number..
lun_name()
{

last_lun_zero_padded=`echo $last_lun | sed 's/^0*//'`
hlu_id_zero_unpadded=`calc $last_lun_zero_padded+$n`
lun_id=`echo $hlu_id_zero_unpadded`
char=$hlu_id_zero_unpadded
char_cnt=`echo ${#char}`
if [ $char_cnt == 1 ]; then
  hlu_id=`echo 00$hlu_id_zero_unpadded`
elif [ $char_cnt == 2 ]; then
  hlu_id=`echo 0$hlu_id_zero_unpadded`
elif [ $char_cnt == 3 ]; then
  hlu_id=`echo $hlu_id_zero_unpadded`
fi

}

if [ $1 == "Workload" ]; then
  host=Host_10
  last_lun=`uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /remote/host/hlu -host $host show -detail | grep "LUN name" | awk '{print $4}' | sort | rev | cut -b 1-3 | rev | tail -n 1`
  for ((n=1;n<=$2;n++));
  do
    lun_name $last_lun $n
    echo "DC-ESXI-WRKLD-LUN-$hlu_id" >> created_lun_name
    echo "creating lun DC-ESXI-WRKLD-LUN-$hlu_id in Workload Cluster.."
    uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /stor/prov/luns/lun create -name "DC-ESXI-WRKLD-LUN-$hlu_id" -poolName EMC_UTY_GENERIC_POOL -size $3 -thin yes -dataReduction yes -advancedDedup yes -lunHosts Host_15,Host_6,Host_11,Host_14,Host_7,Host_3,Host_12,Host_2,Host_10,Host_5 -hlus $lun_id,$lun_id,$lun_id,$lun_id,$lun_id,$lun_id,$lun_id,$lun_id,$lun_id,$lun_id
  done

elif [ $1 == "TFS" ]; then
  host=Host_9
  last_lun=`uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /remote/host/hlu -host $host show -detail | grep "LUN name" | awk '{print $4}' | sort | rev | cut -b 1-3 | rev | tail -n 1`
  for ((n=1;n<=$2;n++));
  do
    lun_name $last_lun $n
    echo "DC-ESXI-TFS-LUN-$hlu_id" >> created_lun_name
    echo "creating lun DC-ESXI-TFS-LUN-$hlu_id in TFS Cluster.."
    uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /stor/prov/luns/lun create -name "DC-ESXI-TFS-LUN-$hlu_id" -poolName EMC_UTY_GENERIC_POOL -size $3 -thin yes -dataReduction yes -advancedDedup yes -lunHosts Host_17,Host_9 -hlus $lun_id,$lun_id
  done

elif [ $1 == "Edge" ]; then
  host=Host_16
  last_lun=`uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /remote/host/hlu -host $host show -detail | grep "LUN name" | awk '{print $4}' | sort | rev | cut -b 1-3 | rev | tail -n 1`
  for ((n=1;n<=$2;n++));
  do
    lun_name $last_lun $n
    echo "DC-ESXI-EDGE-LUN-$hlu_id" >> created_lun_name
    echo "creating lun DC-ESXI-EDGE-LUN-$hlu_id in Edge Cluster.."
    uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /stor/prov/luns/lun create -name "DC-ESXI-EDGE-LUN-$hlu_id" -poolName EMC_UTY_GENERIC_POOL -size $3 -thin yes -dataReduction yes -advancedDedup yes -lunHosts Host_1,Host_16 -hlus $lun_id,$lun_id
  done

elif [ $1 == "Mgmt" ]; then
  host=Host_4
  last_lun=`uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /remote/host/hlu -host $host show -detail | grep "LUN name" | awk '{print $4}' | sort | rev | cut -b 1-3 | rev | tail -n 1`
  for ((n=1;n<=$2;n++));
  do
    lun_name $last_lun $n
    echo "DC-ESXI-MGMT-LUN-$hlu_id" >> created_lun_name
    echo "creating lun DC-ESXI-MGMT-LUN-$hlu_id in Management Cluster.."
    uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /stor/prov/luns/lun create -name "DC-ESXI-MGMT-LUN-$hlu_id" -poolName EMC_UTY_GENERIC_POOL -size $3 -thin yes -dataReduction yes -advancedDedup yes -lunHosts Host_13,Host_8,Host_4 -hlus $lun_id,$lun_id,$lun_id
  done

elif [ $1 == "Openshift" ]; then
  host=Host_26
  last_lun=`uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /remote/host/hlu -host $host show -detail | grep "LUN name" | awk '{print $4}' | sort | rev | cut -b 1-3 | rev | tail -n 1`
  for ((n=1;n<=$2;n++));
  do
    lun_name $last_lun $n
    echo "DC-RHEV-OSFT-LUN-$hlu_id" >> created_lun_name
    echo "creating lun DC-RHEV-OSFT-LUN-$hlu_id in Openshift Cluster"
    uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /stor/prov/luns/lun create -name "DC-RHEV-OSFT-LUN-$hlu_id" -poolName EMC_UTY_GENERIC_POOL -size $3 -thin yes -dataReduction yes -advancedDedup yes -lunHosts Host_29,Host_31,Host_26,Host_32,Host_33,Host_34,Host_27,Host_35,Host_36,Host_37,Host_38,Host_39,Host_40,Host_28,Host_30 -hlus $lun_id,$lun_id,$lun_id,$lun_id,$lun_id,$lun_id,$lun_id,$lun_id,$lun_id,$lun_id,$lun_id,$lun_id,$lun_id,$lun_id,$lun_id
  done

elif [ $1 == "K8S" ]; then
  host=Host_44
  last_lun=`uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /remote/host/hlu -host $host show -detail | grep "LUN name" | awk '{print $4}' | sort | rev | cut -b 1-3 | rev | tail -n 1`
  for ((n=1;n<=$2;n++));
  do
    lun_name $last_lun $n
    echo "DC-RHEV-K8S-LUN-$hlu_id" >> created_lun_name
    echo "creating lun DC-RHEV-K8S-LUN-$hlu_id in K8S Cluster"
    uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /stor/prov/luns/lun create -name "DC-RHEV-K8S-LUN-$hlu_id" -poolName EMC_UTY_GENERIC_POOL -size $3 -thin yes -dataReduction yes -advancedDedup yes -lunHosts Host_44,Host_42,Host_45,Host_43 -hlus $lun_id,$lun_id,$lun_id,$lun_id
  done

elif [ $1 == "RHEV-CLUSTER1" ]; then
  host=Host_18
  last_lun=`uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /remote/host/hlu -host $host show -detail | grep "LUN name" | awk '{print $4}' | sort | rev | cut -b 1-3 | rev | tail -n 1`
  for ((n=1;n<=$2;n++));
  do
    lun_name $last_lun $n
    echo "DC-PHYS-RHEV-CLUSTER1-LUN-$hlu_id" >> created_lun_name
    echo "creating lun DC-PHYS-RHEV-CLUSTER1-LUN-$hlu_id in RHEV-CLUSTER1 server.."
    uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /stor/prov/luns/lun create -name "DC-PHYS-RHEV-CLUSTER1-LUN-$hlu_id" -poolName EMC_UTY_GENERIC_POOL -size $3 -thin yes -dataReduction yes -advancedDedup yes -lunHosts Host_18 -hlus $lun_id
  done

elif [ $1 == "RHEV-CLUSTER2" ]; then
  host=Host_20
  last_lun=`uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /remote/host/hlu -host $host show -detail | grep "LUN name" | awk '{print $4}' | sort | rev | cut -b 1-3 | rev | tail -n 1`
  for ((n=1;n<=$2;n++));
  do
    lun_name $last_lun $n
    echo "DC-PHYS-DEV-CODE-CENTER-LUN-$hlu_id" >> created_lun_name
    echo "creating lun DC-PHYS-DEV-CODE-CENTER-LUN-$hlu_id in RHEV-CLUSTER2 server.."
    uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /stor/prov/luns/lun create -name "DC-PHYS-DEV-CODE-CENTER-LUN-$hlu_id" -poolName EMC_UTY_GENERIC_POOL -size $3 -thin yes -dataReduction yes -advancedDedup yes -lunHosts Host_20 -hlus $lun_id
  done

elif [ $1 == "RHEV-CLUSTER3" ]; then
  host=Host_21
  last_lun=`uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /remote/host/hlu -host $host show -detail | grep "LUN name" | awk '{print $4}' | sort | rev | cut -b 1-3 | rev | tail -n 1`
  for ((n=1;n<=$2;n++));
  do
    lun_name $last_lun $n
    echo "DC-PHYS-RHEV-CLUSTER3-LUN-$hlu_id" >> created_lun_name
    echo "creating lun DC-PHYS-RHEV-CLUSTER3-LUN-$hlu_id in RHEV-CLUSTER3 server.."
    uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /stor/prov/luns/lun create -name "DC-PHYS-RHEV-CLUSTER3-LUN-$hlu_id" -poolName EMC_UTY_GENERIC_POOL -size $3 -thin yes -dataReduction yes -advancedDedup yes -lunHosts Host_21 -hlus $lun_id
  done

elif [ $1 == "RHEV-CLUSTER4" ]; then
  host=Host_19
  last_lun=`uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /remote/host/hlu -host $host show -detail | grep "LUN name" | awk '{print $4}' | sort | rev | cut -b 1-3 | rev | tail -n 1`
  for ((n=1;n<=$2;n++));
  do
    lun_name $last_lun $n
    echo "DC-PHYS-PROD-CODE-CENTER-LUN-$hlu_id" >> created_lun_name
    echo "creating lun DC-PHYS-PROD-CODE-CENTER-LUN-$hlu_id in RHEV-CLUSTER4 server.."
    uemcli -d $UTY_IPA -u $UTY_USR -p $UTY_PWD /stor/prov/luns/lun create -name "DC-PHYS-PROD-CODE-CENTER-LUN-$hlu_id" -poolName EMC_UTY_GENERIC_POOL -size $3 -thin yes -dataReduction yes -advancedDedup yes -lunHosts Host_19 -hlus $lun_id
  done

else
  echo "No matching host cluster found.."
fi
