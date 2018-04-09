Received: from aserp2120.oracle.com ([141.146.126.78]:33846 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbeDIFWK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 Apr 2018 01:22:10 -0400
Subject: Re: [PATCH v2] fstests: btrfs/159 superblock corruption test case
References: <20180329102848.12669-1-anand.jain@oracle.com>
 <20180405062849.2351-1-anand.jain@oracle.com> <20180408033803.GB2932@desktop>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <863b449d-0353-4825-3e29-81405b2745d3@oracle.com>
Date: Mon, 9 Apr 2018 13:24:09 +0800
MIME-Version: 1.0
In-Reply-To: <20180408033803.GB2932@desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



>> +mount_opt_minus_args()
>> +{
>> +	local nr
>> +	local mnt_opt=""
>> +
>> +	nr=`_scratch_mount_options | awk '{print NF}'`
>> +	if [ $nr -eq 4 ]; then
> 
> Seems this only works with "scratch_mount_options" returns something
> like:
> 
> "-o opt dev mnt" or "-o opt1,opt2 dev mnt"
> 
> but not
> 
> "-oopt dev mnt" nor
> "-o opt1 -o opt2 dev mnt" nor if $SELINUX_MOUNT_OPTIONS not empty.
> 
> Also if MOUNT_OPTIONS is "-oopt1 -oopt2", mount_opt_minus_args would
> return something like "-o -oopt2,device=<dev>", which are not valid
> mount options.

  Oh. Yes. This function is getting complicated. I have dropped this
  function in v3 which is kind of much better.

>> +# Test if the mount fails if the primary superblock csum is corrupted.
>> +check_primary()
>> +{
>> +	local bytenr=65536
>> +	echo -e "\\ncheck_primary\\n" | tee -a $seqres.full
>> +
>> +	wipe
>> +	_scratch_pool_mkfs "-mraid1 -draid1"
>> +	_reload_fs_module "btrfs"
>> +
>> +	#corrupt bytenr DEV_BAD
>> +	od -j$bytenr -N1 -An -x $DEV_BAD |\
>> +		dd status=none of=$DEV_BAD ibs=1 obs=1 seek=$bytenr count=1 conv=fsync
>> +
>> +	#must fail
>> +	_mount `mount_opt_minus_args device=$DEV_GOOD` $DEV_BAD $SCRATCH_MNT 2>&1 |\
>> +	      _filter_error_mount
> 
> If I read the code correctly, the purpose of mount_opt_minus_args is to
> remove the device and mount point mount arguments and keep other options
> if there's any, then append "-o device=<dev>" as mount options.
> 
> If so, I think you could use "_common_dev_mount_options", e.g.
> 
> 	_mount `_common_dev_mount_options -o device=$DEV_GOOD` $DEV_BAD $SCRATCH_MNT ...
> 
> But do mount options really matter in this test? Could we just mount
> with "-o device=<dev>"?

  In fact for this test it doesn't matter, yes we could just use
  "-o device=<dev>". But I thought its xfstests rule that it must be
  used. Anyway in V3, I am changing the device itself on which
  corrupted-SB would reside, so now we can let the default _scratch_mount
  do its job as usual. Which means it shall use the config mount options.
  V3 is in the ML for the review.

Thanks, Anand

> Thanks,
> Eryu


