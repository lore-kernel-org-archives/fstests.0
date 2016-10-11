Received: from cn.fujitsu.com ([59.151.112.132]:9374 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752861AbcJKFfx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Oct 2016 01:35:53 -0400
Subject: Re: [PATCH] generic/175: disable inline data feature for btrfs
References: <20161010050647.30262-1-wangxg.fnst@cn.fujitsu.com>
 <20161010230938.GG23194@dastard>
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Message-ID: <57FC78D9.8030209@cn.fujitsu.com>
Date: Tue, 11 Oct 2016 13:30:01 +0800
MIME-Version: 1.0
In-Reply-To: <20161010230938.GG23194@dastard>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

hi,

On 10/11/2016 07:09 AM, Dave Chinner wrote:
> On Mon, Oct 10, 2016 at 01:06:47PM +0800, Wang Xiaoguang wrote:
>> For btrfs, if compression is enabled, it may generate inline data for a
>> blocksize data range, this inline data is stored in fs tree, will not have
>> a individual extent, try to reflink this data range at a not-zero offset
>> will return EOPNOTSUPP, so here we disable inline data feature for btrfs.
>>
>> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
>> ---
>>   tests/generic/175 | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/tests/generic/175 b/tests/generic/175
>> index 964580c..b3f90dc 100755
>> --- a/tests/generic/175
>> +++ b/tests/generic/175
>> @@ -50,6 +50,13 @@ rm -f "$seqres.full"
>>   
>>   echo "Format and mount"
>>   _scratch_mkfs > "$seqres.full" 2>&1
>> +# For btrfs, if compression is enabled, it may generate inline data for a
>> +# blocksize data range, this inline data is stored in fs tree, will not have
>> +# a individual extent, try to reflink this data range at a not-zero offset
>> +# will return EOPNOTSUPP, so here we disable inline data feature for btrfs.
>> +if [ "$FSTYP" = "btrfs" ]; then
>> +	export MOUNT_OPTIONS="-o max_inline=0 $MOUNT_OPTIONS"
>> +fi
> Can we /please stop/ putting special case code like this in tests?
>
> This is an unsustainable and unmaintainable practice - it's making a
> mess of the test code. If there are specific mount options that
> needs to be avoided, then add an option to filter them out. e.g.
> something like this:
>
> _scratch_options_filter btrfs compress
>
> so that it removes any compression option from the btrfs mount/mkfs
> that is run for that test.
OK, I see, thanks.

Regards,
Xiaoguang Wang

>
> Cheers,
>
> Dave.



