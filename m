Received: from cn.fujitsu.com ([59.151.112.132]:53487 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752201AbdGXKdq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jul 2017 06:33:46 -0400
Message-ID: <5975CD06.3040706@cn.fujitsu.com>
Date: Mon, 24 Jul 2017 18:33:42 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] common/rc: factor out _ext4_disable_extent_zeroout()
 helper
References: <20170721070752.GH2478@eguan.usersys.redhat.com> <1500889747-12149-1-git-send-email-yangx.jy@cn.fujitsu.com> <20170724100423.GD9167@eguan.usersys.redhat.com>
In-Reply-To: <20170724100423.GD9167@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/07/24 18:04, Eryu Guan wrote:
> On Mon, Jul 24, 2017 at 05:49:07PM +0800, Xiao Yang wrote:
>> 1) This pattern is repeated in several seek_data/hole tests
>>     (e.g. generic/285, generic/436, generic/445 generic/448)
>>     and generic/009.  A common _ext4_disable_extent_zeroout()
>>     helper could be added and applied by generic/009 and
>>     _require_seek_data_hole().
>>
>> 2) On some old kernels(e.g. v3.1-v3.6), when vfs recognizes
>>     SEEK_DATA/HOLE flag&&  ext4 has no extent zeroout tunable
>>     in sysfs, these cases may trigger "sysfs entry not found"
>>     issue.  We can add check if extent_max_zeroout_kb exists
>>     on ext4 filesystem.
>>     The extent_max_zeroout_kb is introduced by:
>>     '67a5da564f97 ("ext4: make the zero-out chunk size tunable")'
>>
>> 3) Declare several vars as local in _require_seek_data_hole().
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> Thanks for doing this!
>
>> ---
>>   common/rc         | 29 ++++++++++++++++++++++-------
>>   tests/generic/009 |  7 +------
>>   tests/generic/285 |  6 ------
>>   tests/generic/436 |  6 ------
>>   tests/generic/445 |  6 ------
>>   tests/generic/448 |  6 ------
>>   6 files changed, 23 insertions(+), 37 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index bd989bb..b36a9bf 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -2304,16 +2304,31 @@ _require_fail_make_request()
>>    not found. Seems that CONFIG_FAIL_MAKE_REQUEST kernel config option not enabled"
>>   }
>>
>> -#
>> +# Disable extent zeroing for ext4 on the given device
>> +_ext4_disable_extent_zeroout()
>> +{
>> +	local dev=${1:-$TEST_DEV}
>> +	local sdev=`_short_dev $dev`
>> +
>> +	if [ "$FSTYP" == "ext4" ]; then
>> +		[ -f /sys/fs/ext4/$sdev/extent_max_zeroout_kb ]&&  \
>> +			echo 0>/sys/fs/ext4/$sdev/extent_max_zeroout_kb
>> +	fi
> I'd like the caller to do this FSTYP check if we name the function with
> a leading _ext4, it seems redundant to check FSTYP again when we know it
> only works for ext4.
Hi Eryu,

I prefer that only ext4 could call _ext4_disable_extent_zeroout.
I will send v2 patch as your above comment.  Thanks a lot.

Thanks,
Xiao Yang
> Or we can make it a function serves all FSTYP using a case switch, and
> ext4 is the only filesystem that needs action. But I'm not sure if it's
> necessary for other filesystems at all, even in the future, so I
> suggested _ext4_disable_extent_zeroout in the first place.
>
> Thanks,
> Eryu
>
>> +}
>> +
>>   # Check if the file system supports seek_data/hole
>> -#
>>   _require_seek_data_hole()
>>   {
>> -    testfile=$TEST_DIR/$$.seek
>> -    testseek=`$here/src/seek_sanity_test -t $testfile 2>&1`
>> -    rm -f $testfile&>/dev/null
>> -    echo $testseek | grep -q "Kernel does not support"&&  \
>> -        _notrun "File system does not support llseek(2) SEEK_DATA/HOLE"
>> +	local dev=${1:-$TEST_DEV}
>> +	local testfile=$TEST_DIR/$$.seek
>> +	local testseek=`$here/src/seek_sanity_test -t $testfile 2>&1`
>> +
>> +	rm -f $testfile&>/dev/null
>> +	echo $testseek | grep -q "Kernel does not support"&&  \
>> +		_notrun "File system does not support llseek(2) SEEK_DATA/HOLE"
>> +	# Disable extent zeroing for ext4 as that change where holes are
>> +	# created
>> +	_ext4_disable_extent_zeroout $dev
>>   }
>>
>>   _require_runas()
>> diff --git a/tests/generic/009 b/tests/generic/009
>> index 5902afd..a7ca060 100755
>> --- a/tests/generic/009
>> +++ b/tests/generic/009
>> @@ -48,15 +48,10 @@ _require_xfs_io_command "fzero"
>>   _require_xfs_io_command "fiemap"
>>   _require_xfs_io_command "falloc"
>>   _require_test
>> +_ext4_disable_extent_zeroout
>>
>>   testfile=$TEST_DIR/009.$$
>>
>> -# Disable extent zeroing for ext4 as that change where holes are created
>> -if [ "$FSTYP" = "ext4" ]; then
>> -	DEV=`_short_dev $TEST_DEV`
>> -	echo 0>/sys/fs/ext4/$DEV/extent_max_zeroout_kb
>> -fi
>> -
>>   # When PAGE_SIZE>  4096 xfs extent layout is different so it would not match
>>   # the output.
>>   if [ "$FSTYP" = "xfs" ]; then
>> diff --git a/tests/generic/285 b/tests/generic/285
>> index 16e70b1..3f7d298 100755
>> --- a/tests/generic/285
>> +++ b/tests/generic/285
>> @@ -47,12 +47,6 @@ BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
>>
>>   _require_test_program "seek_sanity_test"
>>
>> -# Disable extent zeroing for ext4 as that change where holes are created
>> -if [ "$FSTYP" = "ext4" ]; then
>> -	DEV=`_short_dev $TEST_DEV`
>> -	echo 0>/sys/fs/ext4/$DEV/extent_max_zeroout_kb
>> -fi
>> -
>>   _cleanup()
>>   {
>>   	eval "rm -f $BASE_TEST_FILE.*"
>> diff --git a/tests/generic/436 b/tests/generic/436
>> index bcd6ddc..6cda008 100755
>> --- a/tests/generic/436
>> +++ b/tests/generic/436
>> @@ -44,12 +44,6 @@ BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
>>
>>   _require_test_program "seek_sanity_test"
>>
>> -# Disable extent zeroing for ext4 as that change where holes are created
>> -if [ "$FSTYP" = "ext4" ]; then
>> -	DEV=`_short_dev $TEST_DEV`
>> -	echo 0>/sys/fs/ext4/$DEV/extent_max_zeroout_kb
>> -fi
>> -
>>   _cleanup()
>>   {
>>   	rm -f $tmp.* $BASE_TEST_FILE.*
>> diff --git a/tests/generic/445 b/tests/generic/445
>> index 81dd916..323a0ca 100755
>> --- a/tests/generic/445
>> +++ b/tests/generic/445
>> @@ -44,12 +44,6 @@ BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
>>
>>   _require_test_program "seek_sanity_test"
>>
>> -# Disable extent zeroing for ext4 as that change where holes are created
>> -if [ "$FSTYP" = "ext4" ]; then
>> -	DEV=`_short_dev $TEST_DEV`
>> -	echo 0>/sys/fs/ext4/$DEV/extent_max_zeroout_kb
>> -fi
>> -
>>   _cleanup()
>>   {
>>   	rm -f $tmp.* $BASE_TEST_FILE.*
>> diff --git a/tests/generic/448 b/tests/generic/448
>> index 87b99d7..22656f6 100755
>> --- a/tests/generic/448
>> +++ b/tests/generic/448
>> @@ -48,12 +48,6 @@ BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile_$seq
>>
>>   _require_test_program "seek_sanity_test"
>>
>> -# Disable extent zeroing for ext4 as that change where holes are created
>> -if [ "$FSTYP" = "ext4" ]; then
>> -	DEV=`_short_dev $TEST_DEV`
>> -	echo 0>/sys/fs/ext4/$DEV/extent_max_zeroout_kb
>> -fi
>> -
>>   $here/src/seek_sanity_test -s 18 -e 18 $BASE_TEST_FILE>  $seqres.full 2>&1 ||
>>   	_fail "seek sanity check failed!"
>>
>> -- 
>> 1.8.3.1
>>
>>
>>
>
> .
>



