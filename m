Received: from userp2120.oracle.com ([156.151.31.85]:53588 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbfC2GcW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Mar 2019 02:32:22 -0400
Subject: Re: [PATCH] fstests: btrfs try use forget to unregister device
References: <1552988980-25710-1-git-send-email-anand.jain@oracle.com>
 <20190328175047.GR29086@twin.jikos.cz>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <7787e21a-3d37-e670-b782-0df43e256f83@oracle.com>
Date: Fri, 29 Mar 2019 14:32:10 +0800
MIME-Version: 1.0
In-Reply-To: <20190328175047.GR29086@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: dsterba@suse.cz
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 3/29/19 1:50 AM, David Sterba wrote:
> On Tue, Mar 19, 2019 at 05:49:40PM +0800, Anand Jain wrote:
>> btrfs module reload was introduced to unregister devices in the btrfs
>> kernel module.
>>
>> The problem with the module reload approach is that you can't run btrfs
>> test cases 124, 125, 154 and 164 on the system with btrfs as root fs.
>>
>> Patches [1] introduced btrfs forget feature which lets to cleanup the
>> kernel device list without kernel module reload.
>>
>>   [1]
>>   btrfs-progs: add cli to forget one or all scanned devices
> 
> The subject lines was changed to "btrfs-progs: device scan: add new
> option to forget one or all scanned devices"

  ok thanks will fix.

>>   btrfs: introduce new ioctl to unregister a btrfs device
> 
>> So this patch uses forget feature instead of kernel module reload, if
>> the forget feature is available.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   common/btrfs    | 20 ++++++++++++++++++++
>>   tests/btrfs/124 |  6 +++---
>>   tests/btrfs/125 |  6 +++---
>>   tests/btrfs/154 |  6 +++---
>>   tests/btrfs/164 |  4 ++--
>>   5 files changed, 31 insertions(+), 11 deletions(-)
>>
>> diff --git a/common/btrfs b/common/btrfs
>> index f6513c06f95f..e94e011db04e 100644
>> --- a/common/btrfs
>> +++ b/common/btrfs
>> @@ -382,3 +382,23 @@ _scratch_btrfs_sectorsize()
>>   	$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV |\
>>   		grep sectorsize | awk '{print $2}'
>>   }
>> +
>> +_btrfs_supports_forget()
>> +{
>> +	$BTRFS_UTIL_PROG device scan --help | grep -wq forget && \


>> +		$BTRFS_UTIL_PROG device scan --forget > /dev/null 2>&1
> 
> The second part actually unregisters all devices, is there some more
> lightweight way to detect the support?  > Like providing a valid block
> device but without btrfs. If the ioctl is supported, then it returns
> -ENOENT and if not supported then -EOPNOTSUPP.

_btrfs_supports_forget() has two different usage
   _require_btrfs_forget_if_not_fs_loadable
which is called in the beginning of the test so its fine to clean all 
the (unmounted) devices in the kernel.

    _btrfs_forget_if_not_fs_reload
Earlier we were reloading the btrfs.ko in the middle of the test case, 
so this is certainly more lightweight.

Looked into the return values if I could use any better [1]. So
_require_btrfs_forget_if_not_fs_loadable() need a btrfs on a loop device
to verify if we need to avoid unregister all devices. Bit messy though.

[1]
With btrfs patches:
We still get error if the device is not in the kernel dev_list.
--------
# mkfs.btrfs -fq /dev/sdb
# wipefs -a /dev/sdb
/dev/sdb: 8 bytes were erased at offset 0x00010040 (btrfs): 5f 42 48 52 
66 53 5f 4d
# mkfs.xfs -fq /dev/sdb
# btrfs dev scan --forget /dev/sdb; echo $?
0
# btrfs dev scan --forget /dev/sdb; echo $?
ERROR: Can't forget '/dev/sdb': No such file or directory
1
----------

With out any btrfs forget patches:
Usage error and error code = 1 (it should rather be EINVAL).
--------
# btrfs dev scan --forget  /dev/sda
usage: btrfs device scan [(-d|--all-devices)|<device> [<device>...]]

     Scan devices for a btrfs filesystem

      -d|--all-devices (deprecated)
1
-----------

With out the btrfs kernel patch:
Returns error code 1. (After the patch sent to the ML it will
return EOPNOTSUPP).
---------------
# btrfs dev scan --forget /dev/loop0; echo $?
ERROR: Can't forget '/dev/loop0': Inappropriate ioctl for device
1
---------------




>> +}
>> +
>> +_require_btrfs_forget_if_not_fs_loadable()
> 
> _require_btrfs_forget_or_module_loadable
> 
> We don't want to load the filesystem but the kernel module.

  Will fix.

>> +{
>> +	_btrfs_supports_forget && return
> 
> Why is the 'return' here? If the first command succeeds, then &&
> proceeds to return that does implicitli returns 0. So it's redundant, or
> I'm missing something subtle here.

  Hmm. Not sure if I understood. Do you mean we could

   _btrfs_supports_forget  || _require_loadable_fs_module "btrfs"

>> +
>> +	_require_loadable_fs_module "btrfs"
>> +}
>> +
>> +_btrfs_forget_if_not_fs_reload()
> 
> Same naming

Ok

Thanks, Anand

> 
>> +{
>> +	_btrfs_supports_forget && return
>> +
>> +	_reload_fs_module "btrfs"
>> +}
