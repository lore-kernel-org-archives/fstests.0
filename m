Received: from cn.fujitsu.com ([59.151.112.132]:60724 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755945AbcK2Iok (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Nov 2016 03:44:40 -0500
Subject: Re: [PATCH 01/10] fstests: common: Introduce function to check qgroup
 correctness
References: <20161129073303.14776-1-quwenruo@cn.fujitsu.com>
 <20161129073303.14776-2-quwenruo@cn.fujitsu.com>
 <20161129081623.GM22989@eguan.usersys.redhat.com>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <03813a09-9d7d-0d9d-3b04-02e79c3b3ec3@cn.fujitsu.com>
Date: Tue, 29 Nov 2016 16:44:32 +0800
MIME-Version: 1.0
In-Reply-To: <20161129081623.GM22989@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



At 11/29/2016 04:16 PM, Eryu Guan wrote:
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
>
> No need to save command output to a var, you can check the return value
> of btrfs, e.g.
>
> 	if ! $BTRFS_UTIL_PROG check --help | grep -q "qgroup-report"; then
> 		_notrun "..."
> 	fi

Thanks for the advice.

I'm not familiar with bash gramma, like the difference of [] or without [].
So I choose the tried and true method.

Anyway I'll change it in next version.

>
> The output is only needed when we need to do further operations on it,
> e.g. in _require_xfs_io_command.
>
>> +		_notrun "$BTRFS_UTIL_PROG too old (must support 'check --qgroup-report')"
>> +	fi
>> +}
>> +
>> +_btrfs_check_scratch_qgroup()
>> +{
>> +	_require_btrfs_check_qgroup
>
> This _require belongs to each test that calls
> _btrfs_check_scratch_qgroup.

Yes, I was originally planning to do it, but it seems that some other 
common function also uses this method.
So I choose this to reduce the modification.

I'm OK to change it in next version.

>
> And I think you can put the introduction of this helper and the
> conversions to use this helper all together in one patch (so we know why
> it's introduced and how it gets used from one patch), and all adding
> extra qgroup check updates to another patch.

The idea is allow further review for each test case modification.

Since some modification is easy to be wrong.
Like forget to add echo "Silence is golden" while removing the only output.

If all the modification are proved to be good, I can fold them all into 
one patch.

Thanks,
Qu

>
> Thanks,
> Eryu
>
>> +	$BTRFS_UTIL_PROG check --qgroup-report $SCRATCH_DEV 2>&1 |\
>> +		grep -E "Counts for qgroup.*are different"
>> +}
>> +
>>  # We check for btrfs and (optionally) features of the btrfs command
>>  _require_btrfs()
>>  {
>> --
>> 2.7.4
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


