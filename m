Received: from [183.91.158.132] ([183.91.158.132]:33065 "EHLO
        heian.cn.fujitsu.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751282AbdHDGnK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 4 Aug 2017 02:43:10 -0400
Message-ID: <59841776.4020401@cn.fujitsu.com>
Date: Fri, 4 Aug 2017 14:43:02 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/424: add check for crc and finobt
References: <1501761914-16445-1-git-send-email-yangx.jy@cn.fujitsu.com> <829dce2e-162c-4ad7-98e9-1a8a9ecb102b@sandeen.net>
In-Reply-To: <829dce2e-162c-4ad7-98e9-1a8a9ecb102b@sandeen.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/08/03 22:57, Eric Sandeen wrote:
> On 8/3/17 7:05 AM, Xiao Yang wrote:
>> 1) When crc is not supported or disabled, this case could not indicate
>>     any expected error.  Running all tests without crc makes no sense.
> It's still fine to run the test.  The description indicates
> that errors may be seen on crc filesystems, but there's nothing
> wrong with a test which iterates over "type" commands in xfs_db,
> even without crcs.  It's possible that some other error could
> be found in the future.
>
> So perhaps the description should be updated; it does not "check for
> that false crc error," it simply checks that setting types causes
> /no/ error.
Hi Eric,

Agreed.  We can just update the description.
>
>> 2) When finobt is disabled, xfs_db fails to get current address of
>>     free_root, as below:
>>     xfs_db -c "agi" -c "addr free_root" -c "daddr" /dev/sda11
>>     Metadata CRC error detected at xfs_inobt block 0x0/0x1000
>>     ...
> I agree that the test should not be trying to set types that do
> not exist on the filesystem.
>
> But I think the right approach is to let the test run over whatever
> MKFS_OPTIONS have been specified, and be sure that the test can handle
> it properly, rather than forcing the test to run only with a certain
> set of options enabled.
OK=EF=BC=8C i will change the check for finobt as you suggested.
Thanks a lot for your comments.

Thanks,
Xiao Yang.
> Thanks,
> -Eric
>
>>     Running related tests without finobt makes no sense.
>>
>> We add check to fix it.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   tests/xfs/424 | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/xfs/424 b/tests/xfs/424
>> index 0a1eef9..165c390 100755
>> --- a/tests/xfs/424
>> +++ b/tests/xfs/424
>> @@ -55,9 +55,15 @@ rm -f $seqres.full
>>   _supported_os Linux
>>   _supported_fs xfs
>>   _require_scratch
>> +_require_xfs_mkfs_crc
>>
>>   echo "Silence is golden."
>>
>> +crc_finobt_enabled=3D"crc=3D1,finobt=3D0"
>> +
>> +[ _scratch_mkfs_xfs_supported -m crc=3D1,finobt=3D1>/dev/null 2>&1 ]&=
&  \
>> +	crc_finobt_enabled=3D"crc=3D1,finobt=3D1"
>> +
>>   # real QA test starts here
>>
>>   # for different sector sizes, ensure no CRC errors are falsely repor=
ted.
>> @@ -77,7 +83,7 @@ while [ $sec_sz -le 4096 ]; do
>>   done
>>
>>   for SECTOR_SIZE in $sector_sizes; do
>> -	$MKFS_XFS_PROG -f -s size=3D$SECTOR_SIZE $SCRATCH_DEV>  /dev/null
>> +	$MKFS_XFS_PROG -f -m "$crc_finobt_enabled" -s size=3D$SECTOR_SIZE $S=
CRATCH_DEV>  /dev/null
>>
>>   	for TYPE in agf agi agfl sb; do
>>   		DADDR=3D`_scratch_xfs_db -c "$TYPE" -c "daddr" | filter_dbval`
>> @@ -96,9 +102,11 @@ for SECTOR_SIZE in $sector_sizes; do
>>   	DADDR=3D`_scratch_xfs_db -c "agi" -c "addr root" -c "daddr" |
>>   		filter_dbval`
>>   	_scratch_xfs_db -c "daddr $DADDR" -c "type inobt"
>> -	DADDR=3D`_scratch_xfs_db -c "agi" -c "addr free_root" -c "daddr" |
>> -		filter_dbval`
>> -	_scratch_xfs_db -c "daddr $DADDR" -c "type finobt"
>> +	if [[ "$crc_finobt_enabled" =3D~ 'finobt=3D1' ]]; then
>> +		DADDR=3D`_scratch_xfs_db -c "agi" -c "addr free_root" -c "daddr" |
>> +			filter_dbval`
>> +		_scratch_xfs_db -c "daddr $DADDR" -c "type finobt"
>> +	fi
>>
>>   	_scratch_xfs_db -c "daddr $DADDR" -c "type text"
>>   	_scratch_xfs_db -c "daddr $DADDR" -c "type data"
>>
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> .
>



