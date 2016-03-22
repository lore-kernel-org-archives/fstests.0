Received: from cn.fujitsu.com ([59.151.112.132]:33811 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753978AbcCVCJr (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 21 Mar 2016 22:09:47 -0400
Message-ID: <56F0A4C0.8000405@cn.fujitsu.com>
Date: Tue, 22 Mar 2016 09:49:52 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/083: disable dmesg check
References: <1454068444-23926-1-git-send-email-fenggw-fnst@cn.fujitsu.com> <20160131030503.GB5849@birch.djwong.org> <56CED40B.2020304@cn.fujitsu.com>
In-Reply-To: <56CED40B.2020304@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

hello,

On 02/25/2016 06:14 PM, Xiaoguang Wang wrote:
> Hello,
> 
> On 01/31/2016 11:05 AM, Darrick J. Wong wrote:
>> On Fri, Jan 29, 2016 at 07:54:04PM +0800, Guangwen Feng wrote:
>>> This test fuzzes the metadata and accesses the corrupted fs later,
>>> which always produces error info in dmesg and causes test fail,
>>> so fix this.
>>>
>>> Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
>>> ---
>>>  tests/xfs/083 | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/tests/xfs/083 b/tests/xfs/083
>>> index 8e14e88..558b964 100755
>>> --- a/tests/xfs/083
>>> +++ b/tests/xfs/083
>>> @@ -102,6 +102,11 @@ scratch_repair() {
>>>  }
>>>  
>>>  rm -f $seqres.full
>>> +
>>> +# We will access the corrupted fs later, which always produces error
>>> +# info in dmesg. We do not want the test to fail because of this.
>>> +_disable_dmesg_check
>>
>> What kind of message did you hit?  I'd thought that the checksum errors
>> didn't include any of the magic text that tripped _check_dmesg.
> We run this test case in kernel v4.5-rc5-206-g6dc390a and get this dmesg, please
> check the attachment. The "Internal error" is in this dmesg, so test case fails.
Could you please check the previous attachment and confirm if it's expected output, thanks.

Regards,
Xiaoguang Wang

> 
> Regards,
> Xiaoguang Wang
>>
>> --D
>>
>>> +
>>>  echo "See interesting results in $seqres.full" | sed -e "s,$RESULT_DIR,RESULT_DIR,g"
>>>  SRCDIR=`pwd`
>>>  test -z "${FUZZ_ARGS}" && FUZZ_ARGS="-3 -n 32"
>>> -- 
>>> 1.8.4.2
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
> 



