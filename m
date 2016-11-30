Received: from cn.fujitsu.com ([59.151.112.132]:57173 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753383AbcK3A4P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Nov 2016 19:56:15 -0500
Subject: Re: [PATCH 01/10] fstests: common: Introduce function to check qgroup
 correctness
References: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
 <20161129073303.14776-2-quwenruo@cn.fujitsu.com>
 <20161129210155.GD31101@dastard>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <6f33e716-2ad2-f05a-1e09-d3ca6f63350d@cn.fujitsu.com>
Date: Wed, 30 Nov 2016 08:56:03 +0800
MIME-Version: 1.0
In-Reply-To: <20161129210155.GD31101@dastard>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



At 11/30/2016 05:01 AM, Dave Chinner wrote:
> On Tue, Nov 29, 2016 at 03:32:54PM +0800, Qu Wenruo wrote:
>> Old btrfs qgroup test cases uses fix golden output numbers, which limits
>> the coverage since they can't handle mount options like compress or
>> inode_map, and cause false alert.
>>
>> Introduce _btrfs_check_scratch_qgroup() function to check qgroup
>> correctness using "btrfs check --qgroup-report" function, which will
>> follow the way kernel handle qgroup and are proved very reliable.
>>
>> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
>> ---
>>  common/rc | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 8c99306..35d2d56 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3018,6 +3018,25 @@ _require_deletable_scratch_dev_pool()
>>  	done
>>  }
>>
>> +# We check if "btrfs check" support to check qgroup correctness
>> +# Old fixed golden output can cover case like compress and inode_map
>> +# mount options, which limits the coverage
>> +_require_btrfs_check_qgroup()
>> +{
>> +	_require_command "$BTRFS_UTIL_PROG" btrfs
>> +	output=$($BTRFS_UTIL_PROG check --help | grep "qgroup-report")
>> +	if [ -z "$output" ]; then
>> +		_notrun "$BTRFS_UTIL_PROG too old (must support 'check --qgroup-report')"
>> +	fi
>> +}
>
> Why wouldn't this just set a global variable that you then
> check in _check_scratch_fs and run the _btrfs_check_scratch_qgroup()
> call then?

The problem is, "btrfs check --qgroup-report" will do force report, even 
for case like qgroup rescan still running.

Some test, like btrfs/114 which tests rescan, false report will cause 
problem.

So here I choose the manually checking other than always do it at 
_check_scratch_fs().

>
> What about all the tests that currently run without this
> functionality being present? They will now notrun rather than use
> the golden output match - this seems like a regression to me,
> especially for distro QE testing older kernel/progs combinations...

In fact, the support of qgroup-report is introduced much earlier.
It's about v3.14.

For other fs, old tool combination would be OK, but for fs like btrfs, I 
don't think that's sane.

Although I could exclude these fixed golden output in next version for 
now, until we have a good agreement on the behavior.

BTW, currently btrfs qgroup test cases are already using "btrfs check 
--qgroup-report" in newer test cases.
Even without checking for the support of --qgroup-report option.
So it should already cause a lot of problem for any btrfs-progs earlier 
than v3.14.

But at least I didn't see such report in fstests ML.

Thanks,
Qu

>
>> +
>> +_btrfs_check_scratch_qgroup()
>> +{
>> +	_require_btrfs_check_qgroup
>
> This needs to go in the test itself before the test is run,
> not get hidden in a function call at the end of the test.
>
> Cheers,
>
> Dave.
>


