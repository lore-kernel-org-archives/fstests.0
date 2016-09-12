Received: from cn.fujitsu.com ([59.151.112.132]:30903 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755432AbcILA5s (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Sep 2016 20:57:48 -0400
Message-ID: <57D5FD89.8060303@cn.fujitsu.com>
Date: Mon, 12 Sep 2016 08:57:45 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/263: skip test if Q_XGETQSTATV hasn't been supported
 by kernel or xfsprogs
References: <1473410864-7780-1-git-send-email-yangx.jy@cn.fujitsu.com> <5863fb55-a0d6-8848-2297-5c15f68b3154@sandeen.net>
In-Reply-To: <5863fb55-a0d6-8848-2297-5c15f68b3154@sandeen.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

On 2016/09/09 21:15, Eric Sandeen wrote:
> On 9/9/16 3:47 AM, Xiao Yang wrote:
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   tests/xfs/263 | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tests/xfs/263 b/tests/xfs/263
>> index 1dc47ae..07f7ebc 100755
>> --- a/tests/xfs/263
>> +++ b/tests/xfs/263
>> @@ -58,6 +58,10 @@ _require_xfs_quota
>>   _require_xfs_mkfs_crc
>>   _require_xfs_crc
>>
>> +# check if Q_XGETQSTATV has been supported by kernel and xfsprogs
>> +grep -q 'Q_XGETQSTATV' /usr/include/linux/dqblk_xfs.h || _notrun "Q_XGETQSTATV hasn't been supported by kernel"
>> +grep -q 'Q_XGETQSTATV' /usr/include/xfs/xqm.h || _notrun "Q_XGETQSTATV hasn't been supported by xfsprogs"
> The installed headers may not even exist; if they are, they
> won't tell us anything about the binaries we're running.  If
> you really want to test for its presence, you'd need to somehow
> directly test both the running kernel and the installed xfs_quota
> binary.
>
> But whether or not we should run the test if XGETQSTATV is not
> present is another question; adding XGETQSTATV fixed a problem
> of incorrect reporting; if the test fails, we know the environment
> is not capable of that, and is reporting bad information.
>
> So it comes down to whether the test is intended to verify
> that the "xfs_quota -c state" command is working, or whether
> the XGETQSTATV interface is working, etc.
>
> Generally, we don't restrict test runs to environments where we
> know the test will pass.  So I would say that allowing this to
> run and fail is the correct option; it tells us that the installed
> kernel+xfsprogs will report bad information from the "state" command,
> and that is useful information to the tester.
>
> -Eric
>
Thanks for your suggestion, i got it.

Thanks,
Xiao Yang
>> +
>>   rm -f $seqres.full
>>
>>   function option_string()
>>
>
> .
>



