Received: from userp2120.oracle.com ([156.151.31.85]:58314 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeDEGMn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Apr 2018 02:12:43 -0400
Subject: Re: [PATCH typo-fixed] fstests: btrfs: 159 superblock corruption test
 case
References: <20180329102848.12669-1-anand.jain@oracle.com>
 <20180404024620.GN30836@localhost.localdomain>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <55000ab3-f73c-329a-1e8c-ed234a8042f5@oracle.com>
Date: Thu, 5 Apr 2018 14:14:35 +0800
MIME-Version: 1.0
In-Reply-To: <20180404024620.GN30836@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +status=1	# failure is the default!
> 
> Please use './new btrfs' to generate new test template, which defines
> variables like 'tmp' and 'here', these variables may not be used in the
> test explicitly, but they could be used by some helper functions,
> especially the "$tmp" var. (Or please don't remove them from template :)

  Ok. May be its a good idea to have an _init() to set mandatory stuffs?

>> +MNT_OPT=$(echo $MOUNT_OPTIONS | cut -d" " -f2-)

> I'm not sure about the purpose of this MNT_OPT, and it could be empty
> and causes problems in test. Please see below.

  Test case here need control of the device(s) used for the mount.
  Thats awkward I missed no mount-option secnario. Will fix.

>> +	echo -e "\\ncheck_copy1_fsid\\n{" | tee -a $seqres.full
> 
> Hmm, I don't think the "{ }" block is necessary in .out file, IMHO it
> makes the diff context harder to read when test fails. Just echo the
> test name would be fine.

  Ok. Will take that out.


>> +	_mount -o $MNT_OPT $DEV_BAD $SCRATCH_MNT 2>&1 | _filter_scratch_pool
> 
> When $MOUNT_OPTIONS is empty, this mount fails as
> 
> +mount: can't find /mnt/scratch in /etc/fstab
> 
> And I think we need to umount $SCRATCH_MNT here in case a buggy btrfs
> module allowed the mount, as the next test assumes the device is not
> mounted anywhere. Otherwise I see failures like:
> 
> +ERROR: /dev/loop1 is mounted
> +mount failed

  got it.

>> +
>> +	echo -e "good\\n}" | tee -a $seqres.full
>> +}
>> +
>> +# As in Linux kernel 4.16 if the primary is corrupted mount will fail.
>> +# Which might change in the long run.
>> +check_primary()
>> +{
>> +	local bytenr=65536
>> +	echo -e "\\ncheck_primary\\n{" | tee -a $seqres.full
>> +
>> +	wipe
>> +	_scratch_pool_mkfs "-mraid1 -draid1"
>> +	_reload_fs_module "btrfs"
>> +
>> +	#To corrupt a disk block, read in hex, write in dec
>> +	od -j$bytenr -N1 -An -x $DEV_BAD |\
>> +		dd status=none of=$DEV_BAD ibs=1 obs=1 seek=$bytenr count=1|\
>> +		tee -a $seqres.full
>> +	_mount -o $MNT_OPT,device=$DEV_GOOD $DEV_BAD $SCRATCH_MNT 2>&1 | _filter_scratch_pool
> 
> Same here, need to umount $SCRATCH_MNT.
> 
> Also, if a mount failure is expected (as it's recorded in the golden
> image file), you need _filter_error_mount here, and _filter_scratch_pool
> can be dropped, because _filter_error_mount will remove all
> $SCRATCH_DEV/MNT from the mount output. For more details please see
> commit 94d3a4f00cbd ("fstests: filter mount error message for EUCLEAN
> and ESTALE").

  I am fixing this in v2.

Thanks, Anand
