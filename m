Received: from cn.fujitsu.com ([59.151.112.132]:53437 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932077AbcE0IAp (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 27 May 2016 04:00:45 -0400
Message-ID: <5747FEA2.2080608@cn.fujitsu.com>
Date: Fri, 27 May 2016 16:00:34 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/122: add check number of structure
References: <20160526163249.GA4595@birch.djwong.org> <1464330792-24031-1-git-send-email-yangx.jy@cn.fujitsu.com> <20160527072828.GD9418@birch.djwong.org>
In-Reply-To: <20160527072828.GD9418@birch.djwong.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


> On Fri, May 27, 2016 at 02:33:12PM +0800, Xiao Yang wrote:
>> I think the number of structure is always changing based on
>> different xfsporg-dev version. If some expected structure is
>> missing in current environment, we won't check structure size
>> and offset and set the result to notrun.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   tests/xfs/122 | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/tests/xfs/122 b/tests/xfs/122
>> index 845cdd2..64f4a1b 100755
>> --- a/tests/xfs/122
>> +++ b/tests/xfs/122
>> @@ -239,6 +239,11 @@ if [ $XFSPROGS_VERSION -lt 30000 ]; then
>>   	echo 'sizeof( xfs_dsb_t ) = 208'>>$progout;
>>   fi
>>
>> +actual_num=`cat $progout | wc -l`
>> +if [ $actual_num -lt 148 ]; then
> I think the maintainer only cares that xfs/122 passes when run against
> current xfsprogs git.
>
> For certain, this shouldn't be hardcoded to 148.
>
> --D
>
Thanks for your review, i will rewrite this pacth as you said.

Regards,
Xiao Yang
>> +        _notrun "Some structure is missing in current envirment"
>> +fi
>> +
>>   LC_COLLATE=POSIX sort $progout
>>
>>   status=0
>> -- 
>> 1.8.3.1
>>
>>
>>
>
>



