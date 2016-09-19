Received: from cn.fujitsu.com ([59.151.112.132]:31721 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750708AbcISEJB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Sep 2016 00:09:01 -0400
Subject: Re: [PATCH v6 1/6] fstests: common: Introduce _post_mount_hook for
 btrfs
References: <20160914015527.10274-1-quwenruo@cn.fujitsu.com>
 <20160914015527.10274-2-quwenruo@cn.fujitsu.com>
 <20160915042404.GS22388@dastard>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <ceac87a2-b089-db7f-ee29-5916c8bdf10a@cn.fujitsu.com>
Date: Mon, 19 Sep 2016 12:08:49 +0800
MIME-Version: 1.0
In-Reply-To: <20160915042404.GS22388@dastard>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, fdmanana@gmail.com, mfasheh@suse.de
List-ID: <fstests@vger.kernel.org>



At 09/15/2016 12:24 PM, Dave Chinner wrote:
> On Wed, Sep 14, 2016 at 09:55:22AM +0800, Qu Wenruo wrote:
>> Introduce _post_mount_hook(), which will be executed after mounting
>> scratch/test.
>>
>> It's quite useful for fs(OK, only btrfs yet, again) which needs to
>> use ioctl other than mount option to enable some of its feature.
>
> Just implement a _btrfs_mount() function (similar to
> _overlay_mount()) to do btrfs specific things at mount time.
>> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
>> ---
>>  common/rc | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 23c007a..631397f 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -321,6 +321,27 @@ _overlay_scratch_unmount()
>>  	$UMOUNT_PROG $SCRATCH_MNT
>>  }
>>
>> +_run_btrfs_post_mount_hook()
>> +{
>> +	mnt_point=$1
>> +	for n in $ALWAYS_ENABLE_BTRFS_FEATURE; do
>
> What's this magic, undefined, undocumented variable?

Yes this reminds me.

The biggest problem is, where is the document of all these variables?

common/config and config/examples all lacks variables like 
TIME_FACTOR/LOAD_FACTOR.

Or it's the time to doc them all?

Thanks,
Qu
>
> Cheers,
>
> Dave.
>


