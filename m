Received: from mail.cn.fujitsu.com ([183.91.158.132]:60946 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750969AbdILCiy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Sep 2017 22:38:54 -0400
Message-ID: <59B748B9.7040309@cn.fujitsu.com>
Date: Tue, 12 Sep 2017 10:38:49 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] generic/456: add check for fallocate flags
References: <1505121946-4900-1-git-send-email-yangx.jy@cn.fujitsu.com> <CAOQ4uxgUkcoe3-o7jLzo4mWvuezLy_BV49AtVhMsF=ofH0hgYg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgUkcoe3-o7jLzo4mWvuezLy_BV49AtVhMsF=ofH0hgYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Hi Amir,

Thanks for your comments. :-)
Could you tell me which patch has fixed the ext4 bug?

On 2017/09/11 19:03, Amir Goldstein wrote:
> On Mon, Sep 11, 2017 at 12:25 PM, Xiao Yang<yangx.jy@cn.fujitsu.com>  wrote:
>> On RHEL6.9GA, this case could not emulate a crash and passed due
>> to unsupported collapse_range and zero_range instead of no bug.
>>
>> We added check for fallocate flags to avoid confusion.
>>
> I am not sure I understand the confusion.
>
> A bug was allegedly introduced to ext4 when introducing
> collapse_range and/or insert_range and this is a regression test
> for this alleged regression.
>
> In what way is it confusing that the test passes on an old kernel?
> There are a lot of tests in xfstests that test for regressions that
> were introduced by commit XYZ. I don't see those tests checking
> that they are running on kernel>  XYZ.
>
> BTW, this test also passes on btrfs and xfs, but it does not include
> _supported_fs ext4 against confusion.
On an old kernel(e.g. RHEL6.9GA), the test passed and got the following 
message in ext4.
----------------------------------------------------------------------
# /var/lib/xfstests/ltp/fsx -d --replay-ops /tmp/733.fsxops 
--record-ops=/tmp/733.dupops /mnt/xfstests/scratch/testfile
main: filesystem does not support fallocate mode FALLOC_FL_ZERO_RANGE, 
disabling!
main: filesystem does not support fallocate mode 
FALLOC_FL_COLLAPSE_RANGE, disabling!
main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE, 
disabling!
1 write 0x137dd thru    0x21445 (0xdc69 bytes)
fallocating to largest ever: 0x16ade
2 falloc        from 0xb531 to 0x16ade (0xb5ad bytes)
4 write 0x3e5ec thru    0x3ffff (0x1a14 bytes)
6 mapwrite      0x216ad thru    0x23dfb (0x274f bytes)
----------------------------------------------------------------------

We skip collapse_range and zero_range operations and cannot trigger the 
expected bug in ext4.

I want to distinguish between unsupported flags and no bug.  Do you 
think it needs to distinguish?
>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   tests/generic/456 | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/456 b/tests/generic/456
>> index 8debd3f..b72acea 100755
>> --- a/tests/generic/456
>> +++ b/tests/generic/456
>> @@ -67,11 +67,16 @@ write 0x3e5ec 0x1a14 0x21446
>>   zero_range 0x20fac 0x6d9c 0x40000 keep_size
>>   mapwrite 0x216ad 0x274f 0x40000
>>   EOF
>> -run_check $here/ltp/fsx -d --replay-ops $fsxops $SCRATCH_MNT/testfile
>> +touch $tmp.dupops
>> +run_check $here/ltp/fsx -d --replay-ops $fsxops --record-ops=$tmp.dupops $SCRATCH_MNT/testfile
>>
>>   _flakey_drop_and_remount
>>   _unmount_flakey
>>   _cleanup_flakey
>> +
>> +ops_name=$(awk '/skip/ {printf "%s ", $2}' $tmp.dupops)
>> +[ -n "$ops_name" ]&&  _notrun "fallocate does not support $ops_name"
>> +
> If you must add some check, please add
> _require_xfs_io_command "fcollapse"
> _require_xfs_io_command "fzero"
>
> It is not really a must for this test and its not even really testing if fs
> supports those commands, but that is de-facto standard for not
> running fcollapse/fzero tests.
IMO, _require_xfs_io_command only check if xfs_io command supports 
collapse_range or zero_range,
and it does not mean that fallocate(2)  supports collapse_range or 
zero_range.

I am not sure it is necessary to add some check.

Thanks,
Xiao Yang.
> Thanks,
> Amir.
>
>
>



