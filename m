Received: from cn.fujitsu.com ([59.151.112.132]:26688 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751075AbdFADBu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 31 May 2017 23:01:50 -0400
Message-ID: <592F8395.1000400@cn.fujitsu.com>
Date: Thu, 1 Jun 2017 11:01:41 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] xfs/055: add missing 055.cfg
References: <1496221827-22720-1-git-send-email-yangx.jy@cn.fujitsu.com> <20170601025327.GU23805@eguan.usersys.redhat.com>
In-Reply-To: <20170601025327.GU23805@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/06/01 10:53, Eryu Guan wrote:
> On Wed, May 31, 2017 at 05:10:26PM +0800, Xiao Yang wrote:
>> _link_output_file sets output file suffix to null because 055.cfg is
>> missing, so add it.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> Thanks for the patch! But we eventually want to remove IRIX support, I
> don't think this is needed at this stage, especially that Eric Biggers
> has posted patches to remove IRIX support.
>
> BTW, your patch has '1/2' prefix, but I didn't see the second patch, do
> you have a second patch that didn't hit the list?
Hi Eryu

Yeah, i will send the second patch again. :-)

Thanks,
Xiao Yang
> Thanks,
> Eryu
>
>> ---
>>   tests/xfs/055.cfg | 2 ++
>>   1 file changed, 2 insertions(+)
>>   create mode 100644 tests/xfs/055.cfg
>>
>> diff --git a/tests/xfs/055.cfg b/tests/xfs/055.cfg
>> new file mode 100644
>> index 0000000..7ffdfc0
>> --- /dev/null
>> +++ b/tests/xfs/055.cfg
>> @@ -0,0 +1,2 @@
>> +irix: irix
>> +linux: linux
>> -- 
>> 1.8.3.1
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>



