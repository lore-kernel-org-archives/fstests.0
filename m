Received: from userp2130.oracle.com ([156.151.31.86]:59670 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeIZKSt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Sep 2018 06:18:49 -0400
Subject: Re: [PATCH v2 1/9] fstests: btrfs: _scratch_mkfs_sized fix min size
 without mixed option
References: <1537849462-619-1-git-send-email-anand.jain@oracle.com>
 <1537849462-619-2-git-send-email-anand.jain@oracle.com>
 <b054a402-0507-4990-6752-8d75b02a97ed@suse.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <68c6443f-6d2b-ba3a-40e1-994fa5ee32e3@oracle.com>
Date: Wed, 26 Sep 2018 12:07:43 +0800
MIME-Version: 1.0
In-Reply-To: <b054a402-0507-4990-6752-8d75b02a97ed@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
List-ID: <fstests@vger.kernel.org>



On 09/25/2018 06:51 PM, Nikolay Borisov wrote:
> 
> 
> On 25.09.2018 07:24, Anand Jain wrote:
>> As of now _scratch_mkfs_sized() checks if the requested size is below 1G
>> and forces the --mixed option for the mkfs.btrfs. Well the correct size
>> considering all possible group profiles at which we need to force the
>> mixed option is roughly 256Mbytes. So fix that.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> 
> Have you considered the implications of this w.r.t commit
> d4da414a9a9d ("common/rc: raise btrfs mixed mode threshold to 1GB")
 >
> Initially this threshold was 100mb then Omar changed it to 1g. Does this
> change affect generic/427?

d4da414a9a9d does not explain what was the problem that Omar wanted to 
address, mainly what was the failure about.

And no it does not affect. I have verified generic/427 with kernel 4.1 
and 4.19-rc5 with  btrfs-progs 4.1, 4.9 and latest from kdave they all 
run fine. Good to integrate.

Thanks, Anand

> 
>> ---
>>   common/rc | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index d5bb1feee2c3..90dc3002bc3d 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -969,7 +969,10 @@ _scratch_mkfs_sized()
>>   	;;
>>       btrfs)
>>   	local mixed_opt=
>> -	(( fssize <= 1024 * 1024 * 1024 )) && mixed_opt='--mixed'
>> +	# minimum size that's needed without the mixed option.
>> +	# Ref: btrfs-prog: btrfs_min_dev_size()
>> +	# Non mixed mode is also the default option.
>> +	(( fssize < $((256 * 1024 *1024)) )) && mixed_opt='--mixed'
>>   	$MKFS_BTRFS_PROG $MKFS_OPTIONS $mixed_opt -b $fssize $SCRATCH_DEV
>>   	;;
>>       jfs)
>>
