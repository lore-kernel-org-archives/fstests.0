Received: from cn.fujitsu.com ([59.151.112.132]:31762 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750768AbcIFFGv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 6 Sep 2016 01:06:51 -0400
Subject: Re: [PATCH] fstests: common: Enhance _exclude_scratch_mount_option to
 handle multiply options and generic fs type
References: <20160905071333.24688-1-quwenruo@cn.fujitsu.com>
 <20160906042039.GN27776@eguan.usersys.redhat.com>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <1bdfe67d-17ca-c95b-a10d-f9ac072b1aca@cn.fujitsu.com>
Date: Tue, 6 Sep 2016 13:06:39 +0800
MIME-Version: 1.0
In-Reply-To: <20160906042039.GN27776@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



At 09/06/2016 12:20 PM, Eryu Guan wrote:
> On Mon, Sep 05, 2016 at 03:13:33PM +0800, Qu Wenruo wrote:
>> Enhance _exclude_scratch_mount_option() function to get real mount
>> options from $MOUNT_OPTIONS.
>
> This seems unnecessarily complex to me.

Considering the fact that we didn't specify any other options except -o, 
yes, it's a quite complex than original one.

But, it's still needed for case like "-oopt3" can't be handled by "grep 
-w", as there is no space between "-o" and "opt3".

>
>>
>> Now it can understand and extract real mount option from string like
>> "-o opt1,opt2 -oopt3".
>> Furthermore, it doesn't use grep method, which can lead to false alert
>> for options like inode_cache and noinode_cache.
>> It now do compare with the first n characters of the prohibited list,
>> so it can handle "data=" and above "no" prefix well.
>
> I think we can fix it by adding "-w" option to grep, and replacing
> "data=" with "data", "=" seems not necessary.

In that case, "-oopt3" can't be handled by "-w" option.

>
>>
>> And add a new parameter, 'fstype' for _exclude_scratch_mount_option().
>> So for generic test cases, it can still prohibit mount options for given
>> fs(mainly for btrfs though)
>
> This requires every caller of this helper provides an additional fstype
> argument, and in most cases this argument is not useful (generic or
> current FSTYP). If btrfs needs to be handled differently, how about
> checking the fstype in the test and adding additional mount option rules
> if fstype is btrfs?

Currently, only 2 callers in fact. ext4/271 and xfs/134.
So the cost is still quite low to add a 'fstype'.

The main object is, to info reviewer or testcase writer which fs type 
needs special handling.

Considering not every contributor will add comment about excluded mount 
options, and in case generic test cases needs to exclude one mount 
option for given fstype, it will be quite hard to find the reason.

So with new fstype parameter, at least we known which fstype is to be blame.
(Although, it will be btrfs for most of time)

>
>>
>> Finally, allow it to accept multiple options at the same time.
>> No need for multiple _exclude_scratch_mount_option lines now
>
> So _exclude_scratch_mount_option is simply:
>
> # skip test if MOUNT_OPTIONS contains the given mount options
> _exclude_scratch_mount_option()
> {
>         for opt in $*; do
>                 if echo $MOUNT_OPTIONS | grep -qw "$opt"; then
>                         _notrun "mount option \"$opt\" not allowed in this test"
>                 fi
>         done
> }
>
> (Note that the comment in current code is wrong, MKFS_OPTIONS should be
> MOUNT_OPTIONS)
Yes, I also noted that and changed it to MOUNT_OPTIONS.

Thanks,
Qu
>
> What do you and/or other people think?
>
> Thanks,
> Eryu
>
>>
>> Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
>> ---
>>  common/rc      | 41 ++++++++++++++++++++++++++++++++++++++---
>>  tests/ext4/271 |  6 ++----
>>  tests/xfs/134  |  3 +--
>>  3 files changed, 41 insertions(+), 9 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 04039a4..8fca637 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3183,11 +3183,46 @@ _require_cloner()
>>  		_notrun "cloner binary not present at $CLONER_PROG"
>>  }
>>
>> -# skip test if MKFS_OPTIONS contains the given string
>> +# Normalize mount options from global $MOUNT_OPTIONS
>> +# Will convert "-o options1,options2 -ooptions3" into
>> +# "options1 options2 options3" for easy access
>> +_normalize_mount_options()
>> +{
>> +	echo $MOUNT_OPTIONS | sed -n 's/-o\s*\(\S*\)/\1/gp' |\
>> +		sed 's/,/ /g'
>> +}
>> +
>> +# Helper for _exclude_scratch_mount_option , check if exclusive mount option $1
>> +# is in the custom mount options
>> +_check_one_exclusive_option()
>> +{
>> +	excl_opt=$1
>> +	shift
>> +	mnt_opts=$*
>> +	excl_len=${#excl_opt}
>> +
>> +	for n in $mnt_opts; do
>> +		# Handle mount option like "data="
>> +		sub_str=$(expr substr $n 1 ${excl_len})
>> +		if [ $sub_str == $excl_opt ]; then
>> +			_notrun "mount option \"$n\" not allowed in this test"
>> +		fi
>> +	done
>> +}
>> +
>> +# skip test if custom MOUNT_OPTIONS contains prohibited mount
>> +# options
>>  _exclude_scratch_mount_option()
>>  {
>> -	if echo $MOUNT_OPTIONS | grep -q "$1"; then
>> -		_notrun "mount option \"$1\" not allowed in this test"
>> +	fstype=$1
>> +	shift
>> +
>> +	normalized=$(_normalize_mount_options)
>> +	if [ $fstype == "generic" -o $fstype = $FSTYP ]; then
>> +		while [ $# -gt 1 ]; do
>> +			_check_one_exclusive_option $1 $normalized
>> +			shift
>> +		done
>>  	fi
>>  }
>>
>> diff --git a/tests/ext4/271 b/tests/ext4/271
>> index 8674090..f3a99b7 100755
>> --- a/tests/ext4/271
>> +++ b/tests/ext4/271
>> @@ -41,10 +41,8 @@ _supported_os Linux
>>  _require_scratch
>>  # this test needs no journal to be loaded, skip on journal related mount
>>  # options, otherwise mount would fail with "-o noload" mount option
>> -_exclude_scratch_mount_option "data="
>> -_exclude_scratch_mount_option "commit="
>> -_exclude_scratch_mount_option "journal_checksum"
>> -_exclude_scratch_mount_option "journal_async_commit"
>> +_exclude_scratch_mount_option ext4 "data=" "commit=" "journal_checksum" \
>> +				   "journal_async_commit"
>>
>>  rm -f $seqres.full
>>  _scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
>> diff --git a/tests/xfs/134 b/tests/xfs/134
>> index b3a1107..ca4a73d 100755
>> --- a/tests/xfs/134
>> +++ b/tests/xfs/134
>> @@ -51,8 +51,7 @@ _supported_os Linux IRIX
>>  _require_test
>>  _require_xfs_quota
>>  # we can't run with group quotas
>> -_exclude_scratch_mount_option "gquota"
>> -_exclude_scratch_mount_option "grpquota"
>> +_exclude_scratch_mount_option xfs "gquota" "grpquota"
>>
>>  dir=$SCRATCH_MNT/project
>>
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


