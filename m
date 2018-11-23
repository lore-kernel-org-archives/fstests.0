Received: from mail.cn.fujitsu.com ([183.91.158.132]:22959 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730451AbeKWQA7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Nov 2018 11:00:59 -0500
Message-ID: <5BF78D95.4050207@cn.fujitsu.com>
Date: Fri, 23 Nov 2018 13:18:13 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] common/rc: Check more options for filefrag command
References: <1542703268-30302-1-git-send-email-yangx.jy@cn.fujitsu.com> <20181123051251.GJ3889@desktop>
In-Reply-To: <20181123051251.GJ3889@desktop>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Eryu,

Thanks for your comment.
Your idea seems better to me, and i will send a v2 patch.  :-)

Best Regards,
Xiao Yang
On 2018/11/23 13:12, Eryu Guan wrote:

> On Tue, Nov 20, 2018 at 04:41:08PM +0800, Xiao Yang wrote:
>> In generic/519, filefrag command use FIBMAP ioctl(-B option) to print
>> output in extent format(-e option) on purpose and sync file(-s option),
>> so check if the command supports all of these options by _require_filefrag_options().
>>
>> Rename _require_fibmap() to _require_filefrag_options()
>> Also remove duplicate _require_command "$FILEFRAG_PROG" filefrag
>>
>> References:
>> 1) filefrag supports -e option by commit 2508eaa since v1.42.7.
>> 2) filefrag supports -B option by commit 5d5e01d since v1.41.9.
>> 3) filefrag supports -s option by commit e62847c since v1.41.6.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   common/rc         | 12 +++++++-----
>>   tests/generic/519 |  3 +--
>>   2 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index ecb1738..5a11359 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3843,17 +3843,19 @@ _require_scratch_btime()
>>   	_scratch_unmount
>>   }
>>
>> -_require_fibmap()
>> +_require_filefrag_options()
>>   {
>>   	_require_command "$FILEFRAG_PROG" filefrag
>>
>> -	local file="$TEST_DIR/fibmap_testfile"
>> +	local options=$1
>> +	local file="$TEST_DIR/testfile"
>>
>>   	echo "XX">  $file
>> -	${FILEFRAG_PROG} -B $file 2>&1 | grep -q "FIBMAP[[:space:]]*unsupported"
>> -	if [ $? -eq 0 ]; then
>> +	local output=`${FILEFRAG_PROG} $options $file 2>&1`
>> +	echo $output | grep -q "FIBMAP[[:space:]]*unsupported"&&  \
>>   		_notrun "FIBMAP not supported by this filesystem"
> I think we'd better to split the FIBMAP check from the other options
> check. e.g. keep the _require_fibmap() function, but require needed
> options first there.
>
> _require_fibmap()
> {
> 	_require_filefrag_options "B"
> 	<other FIBMAP checks>
> }
>
>> -	fi
>> +	echo $output | grep -q "invalid option"&&  \
>> +		_notrun "filefrag doesn't support $options option"
>>   	rm -f $file
>>   }
>>
>> diff --git a/tests/generic/519 b/tests/generic/519
>> index 229c5b4..ccc15d4 100755
>> --- a/tests/generic/519
>> +++ b/tests/generic/519
>> @@ -33,8 +33,7 @@ rm -f $seqres.full
>>   _supported_fs generic
>>   _supported_os Linux
>>   _require_scratch
>> -_require_command "$FILEFRAG_PROG" filefrag
>> -_require_fibmap
>> +_require_filefrag_options "-Bes"
> And we require fibmap and other needed options in the test, e.g.
>
> _require_fibmap
> _require_filefrag_options "es"
>
> Note that no "-" in the required options.
>
> Thanks,
> Eryu
>
>>
>>   testfile="$SCRATCH_MNT/$seq-testfile"
>>
>> -- 
>> 1.8.3.1
>>
>>
>>
>
>
