Received: from smtpbgau2.qq.com ([54.206.34.216]:46387 "EHLO smtpbgau2.qq.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbbFFK7Q (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 6 Jun 2015 06:59:16 -0400
Message-ID: <5572D133.6010304@foxmail.com>
Date: Sat, 06 Jun 2015 18:53:39 +0800
From: shhuiw <shhuiw@foxmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH] generic/324: fix small typos in comment
References: <1433464449-21027-1-git-send-email-shhuiw@foxmail.com> <20150605032850.GQ3672@dhcp-13-216.nay.redhat.com>
In-Reply-To: <20150605032850.GQ3672@dhcp-13-216.nay.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 06/05/2015 11:28 AM, Eryu Guan wrote:
> On Fri, Jun 05, 2015 at 08:34:09AM +0800, Wang Sheng-Hui wrote:
>> Fix some spelling mistakes in the comment.
> 
> I'd recommend you fix all comment typos in one patch, as the one in
> generic/288 and this one and any other spelling errors in comments. I'm
> sure you can find more :)
> 

Got it, Eryu.

Will collect the typos after walking through the code.

Regards,
Sheng-Hui

> Thanks,
> Eryu
>>
>> Signed-off-by: Wang Sheng-Hui <shhuiw@foxmail.com>
>> ---
>>  tests/generic/324 | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/324 b/tests/generic/324
>> index 5e642dc..ac2ae8b 100755
>> --- a/tests/generic/324
>> +++ b/tests/generic/324
>> @@ -61,7 +61,7 @@ _workout()
>>  	# Fill holes for half of range , as result file will contain nr*1.5 fragments
>>  	$XFS_IO_PROG -c "falloc 0 $((204800*nr))"  \
>>  	    $SCRATCH_MNT/test.$nr | _filter_xfs_io
>> -	# Data wrilte will convert extetns to inialized ones
>> +	# Data write will convert extents to initialized ones
>>  	for ((i=0;i<nr;i++))
>>  	do
>>  		patt=`printf "0x%x" $i`
>> -- 
>> 1.8.3.2
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 



