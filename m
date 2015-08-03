Received: from cn.fujitsu.com ([59.151.112.132]:47394 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751393AbbHCEuA (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 3 Aug 2015 00:50:00 -0400
Message-ID: <55BEF1A3.9060103@cn.fujitsu.com>
Date: Mon, 3 Aug 2015 12:44:19 +0800
From: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/5] xfstest: add ubifs support
References: <1438236417-24612-1-git-send-email-yangds.fnst@cn.fujitsu.com> <1438236417-24612-2-git-send-email-yangds.fnst@cn.fujitsu.com> <20150803041229.GQ3902@dastard>
In-Reply-To: <20150803041229.GQ3902@dastard>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: eguan@redhat.com, fstests@vger.kernel.org, dedekind1@gmail.com, richard.weinberger@gmail.com, linux-mtd@lists.infradead.org
List-ID: <fstests@vger.kernel.org>

On 08/03/2015 12:12 PM, Dave Chinner wrote:
> On Thu, Jul 30, 2015 at 02:06:53PM +0800, Dongsheng Yang wrote:
>> Signed-off-by: Dongsheng Yang <yangds.fnst@cn.fujitsu.com>
>> ---
>>   check         | 2 ++
>>   common/config | 9 +++++----
>>   common/rc     | 8 ++++++--
>>   3 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/check b/check
>> index a300130..20d45f8 100755
>> --- a/check
>> +++ b/check
>> @@ -69,6 +69,7 @@ check options
>>       -nfs                test NFS
>>       -cifs               test CIFS
>>       -tmpfs              test TMPFS
>> +    -ubifs		test ubifs
>>       -l			line mode diff
>>       -udiff		show unified diff (default)
>>       -n			show me, do not run tests
>> @@ -207,6 +208,7 @@ while [ $# -gt 0 ]; do
>>   	-nfs)	FSTYP=nfs ;;
>>   	-cifs)	FSTYP=cifs ;;
>>   	-tmpfs)	FSTYP=tmpfs ;;
>> +	-ubifs)	FSTYP=ubifs ;;
>
> It's a local device - we should be able to probe it to find FSTYP
> like we do with all other local devices. Probing is much preferable
> to adding more FS specific CLI options....

That's true, it's not necessary, I agree probing is better.
I will remove this line in next version.
>
>> diff --git a/common/config b/common/config
>> index 8e21c28..2c809b6 100644
>> --- a/common/config
>> +++ b/common/config
>> @@ -220,6 +220,7 @@ case "$HOSTOS" in
>>           export MKFS_EXT4_PROG="`set_prog_path mkfs.ext4`"
>>           export MKFS_UDF_PROG="`set_prog_path mkudffs`"
>>           export MKFS_BTRFS_PROG="`set_btrfs_mkfs_prog_path_with_opts`"
>> +        export MKFS_UBIFS_PROG="`set_prog_path mkfs.ubifs`"
>>           export MKFS_F2FS_PROG="`set_prog_path mkfs.f2fs`"
>>           export DUMP_F2FS_PROG="`set_prog_path dump.f2fs`"
>>           export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
>> @@ -465,9 +466,9 @@ get_next_config() {
>>   		exit 1
>>   	fi
>>
>> -	echo $TEST_DEV | grep -qE ":|//" > /dev/null 2>&1
>> +	echo $TEST_DEV | grep -qE ":|//|ubi" > /dev/null 2>&1
>>   	if [ ! -b "$TEST_DEV" -a "$?" != "0" ]; then
>> -		echo "common/config: Error: \$TEST_DEV ($TEST_DEV) is not a block device or a network filesystem"
>> +		echo "common/config: Error: \$TEST_DEV ($TEST_DEV) is not a block device or a network filesystem or ubi device"
>>   		exit 1
>>   	fi
>>
>> @@ -488,9 +489,9 @@ get_next_config() {
>>   		export SCRATCH_DEV_NOT_SET=true
>>   	fi
>>
>> -	echo $SCRATCH_DEV | grep -qE ":|//" > /dev/null 2>&1
>> +	echo $SCRATCH_DEV | grep -qE ":|//|ubi" > /dev/null 2>&1
>>   	if [ ! -z "$SCRATCH_DEV" -a ! -b "$SCRATCH_DEV" -a "$?" != "0" ]; then
>> -		echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) is not a block device or a network filesystem"
>> +		echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) is not a block device or a network filesystem or ubi device"
>>   		exit 1
>>   	fi
>
> Hmmm - how do we validate that we were passed a valid ubi device in
> TEST_DEV/SCRATCH_DEV? (goes back to the probing question above...)

I am using the following config for my testing. So if we want to
test ubifs, we have to pass a ubi volume to it. the name of it
looks as ubiX_X.

# cat local.config
# Ideally define at least these 4 to match your environment
# The first 2 are required.
# See README for other variables which can be set.
#
# Note: SCRATCH_DEV >will< get overwritten!

export TEST_DEV=/dev/ubi0_0
export TEST_DIR=/mnt/test
export SCRATCH_DEV=/dev/ubi0_1
export SCRATCH_MNT=/mnt/scratch

>
>> diff --git a/common/rc b/common/rc
>> index 610045e..b206827 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1106,7 +1106,7 @@ _require_scratch_nocheck()
>>   		     _notrun "this test requires a valid \$SCRATCH_MNT"
>>   		fi
>>   		;;
>> -	tmpfs)
>> +	tmpfs|ubifs)
>>   		if [ -z "$SCRATCH_DEV" -o ! -d "$SCRATCH_MNT" ];
>>   		then
>>   		    _notrun "this test requires a valid \$SCRATCH_MNT and unique $SCRATCH_DEV"
>> @@ -1180,7 +1180,7 @@ _require_test()
>>   		     _notrun "this test requires a valid \$TEST_DIR"
>>   		fi
>>   		;;
>> -	tmpfs)
>> +	tmpfs|ubifs)
>>   		if [ -z "$TEST_DEV" -o ! -d "$TEST_DIR" ];
>>   		then
>>   		    _notrun "this test requires a valid \$TEST_DIR and unique $TEST_DEV"
>> @@ -2054,6 +2054,8 @@ _check_test_fs()
>>       tmpfs)
>>   	# no way to check consistency for tmpfs
>>   	;;
>> +    ubifs)
>> +	;;
>>       *)
>>   	_check_generic_filesystem $TEST_DEV
>>   	;;
>> @@ -2092,6 +2094,8 @@ _check_scratch_fs()
>>       tmpfs)
>>   	# no way to check consistency for tmpfs
>>   	;;
>> +    ubifs)
>> +	;;
>
> There is no fsck.ubifs? How do you validate the filesystem is
> consistent?
>
> Keep in minds that the people you are asking to review/commit this
> code have no idea what UBIFS is or how it works, so you need to
> explain why xfstests requires non-standard configuration and
> bypassing of the config sanity testing...
>
> Cheers,
>
> Dave.
>

