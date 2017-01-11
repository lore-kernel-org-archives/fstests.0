Received: from cn.fujitsu.com ([59.151.112.132]:5183 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1762313AbdAKHt6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Jan 2017 02:49:58 -0500
Message-ID: <5875E397.9060708@cn.fujitsu.com>
Date: Wed, 11 Jan 2017 15:49:43 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] generic/102: Update strict check
References: <1483606569-6515-1-git-send-email-yangx.jy@cn.fujitsu.com> <20170105093843.GU1859@eguan.usersys.redhat.com>
In-Reply-To: <20170105093843.GU1859@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/01/05 17:38, Eryu Guan wrote:
> On Thu, Jan 05, 2017 at 04:56:09PM +0800, Xiao Yang wrote:
>> Low memory may lead to "written less bytes than
>> requested".  We only care about if xfs_io returned
>> ENOSPC or not, so we can check stderr of xfs_io
>> instead of stdout.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> I thought this was fine, but I'm not sure now. Because I recalled that
> there was an ext4 bug in dax mount exposed by generic/102, and it was
> the case that xfs_io returned less bytes than requested. See commit
>
> e84dfbe ext4: retry block allocation for failed DIO and DAX writes
>
> If we discard all the xfs_io stdout, we may miss such bugs in the
> future. But I'd like to see more comments on this from filesystem
> developers.
>
Hi Eryu

Yes,  I'd like to see more comments on this from filesystem developers too.
New case may be added to test the ext4 bug in dax mount and we only care
about if xfs_io returned ENOSPC or not in generic/102.   Do you think so?
>> ---
>>   tests/generic/102     |  5 +++--
>>   tests/generic/102.out | 20 --------------------
>>   2 files changed, 3 insertions(+), 22 deletions(-)
>>
>> diff --git a/tests/generic/102 b/tests/generic/102
>> index 3cdc2ba..104edc0 100755
>> --- a/tests/generic/102
>> +++ b/tests/generic/102
>> @@ -54,8 +54,9 @@ _scratch_mount
>>   for ((i = 0; i<  10; i++)); do
>>   	echo "loop $i">>$seqres.full
>>
>> -	$XFS_IO_PROG -f -c "pwrite -b 1m 0 400m" "$SCRATCH_MNT"/file | \
>> -_filter_xfs_io | _filter_scratch
>> +	out="$($XFS_IO_PROG -f -c "pwrite -b 1m 0 400m" "$SCRATCH_MNT"/file 2>&1)"
>> +	echo $out>>$seqres.full 2>&1
>> +	echo $out | grep -q "No space left on device"&&  echo "pwrite failed with ENOSPC"
> If we want to discard xfs_io stdout, just redirect it to /dev/null,
> ENOSPC error messgage will go to stderr and break the golden image
> anyway.
Agree it.  I will send v2 patch as you said.

Thanks,
Xiao Yang
> Thanks,
> Eryu
>
>
>



