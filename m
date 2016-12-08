Received: from cn.fujitsu.com ([59.151.112.132]:60448 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750871AbcLHFuG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Dec 2016 00:50:06 -0500
Subject: Re: [PATCH 2/2] fstests: btrfs: Use _require_btrfs_qgroup_report to
 replace open code
References: <20161208020456.16116-1-quwenruo@cn.fujitsu.com>
 <20161208020456.16116-2-quwenruo@cn.fujitsu.com>
 <20161208052742.GG29149@eguan.usersys.redhat.com>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <0691e6cd-b9fb-79e1-f2fb-d5607f554007@cn.fujitsu.com>
Date: Thu, 8 Dec 2016 13:49:58 +0800
MIME-Version: 1.0
In-Reply-To: <20161208052742.GG29149@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



At 12/08/2016 01:27 PM, Eryu Guan wrote:
> On Thu, Dec 08, 2016 at 10:04:56AM +0800, Qu Wenruo wrote:
>> Introduce new _require_btrfs_qgroup_report function, which will check
>> the accessibility to "btrfs check --qgroup-report", then set a global
>> flag to info _check_scratch_fs() to do extra qgroup check.
>>
>> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
>> ---
>>  common/rc       | 22 ++++++++++++++++++++++
>
> This needs rebase too.
>
>>  tests/btrfs/022 |  5 +++++
>>  tests/btrfs/028 |  5 ++---
>>  tests/btrfs/042 |  6 ++----
>>  tests/btrfs/099 |  1 +
>>  tests/btrfs/104 | 20 +++++---------------
>>  tests/btrfs/122 | 10 +++-------
>>  tests/btrfs/123 |  5 ++---
>>  8 files changed, 42 insertions(+), 32 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 1703232..bce3a09 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -2624,6 +2624,20 @@ _check_btrfs_filesystem()
>>          mountpoint=`_umount_or_remount_ro $device`
>>      fi
>>
>> +    # Check qgroup numbers
>> +    if [ "$BTRFS_NEED_QGROUP_REPORT" == "yes" ];then
>
> So we can bypass the _require_btrfs_qgroup_report check if we set
> BTRFS_NEED_QGROUP_REPORT to "yes" directly, right? How about doing
> something like _require_scratch do, e.g. touching some signal file in
> $RESULT_DIR and only do qgroup check if that file exists?

Nice idea.

>
>> +	    btrfsck $device --qgroup-report > $tmp.qgroup_report 2>&1
>
> Shouldn't "$BTRFS_UTIL_PROG check $device ..." be used for new code? I
> might be wrong on this, I think btrfsck is deprecated.

Oh, the code in common/btrfs is just too old.
I'll update them together in next version.

Thanks,
Qu

>
> Thanks,
> Eryu
>
>


