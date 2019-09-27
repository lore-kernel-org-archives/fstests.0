Return-Path: <SRS0=31Kr=XW=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342AAC4360C
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Sep 2019 01:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B544207FF
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Sep 2019 01:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfI0Bif (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 26 Sep 2019 21:38:35 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:50123 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726029AbfI0Bif (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Sep 2019 21:38:35 -0400
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; 
   d="scan'208";a="76088066"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Sep 2019 09:38:33 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id EDF8C4CE14E1;
        Fri, 27 Sep 2019 09:38:33 +0800 (CST)
Received: from [10.167.226.33] (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 27 Sep 2019 09:38:35 +0800
Subject: Re: [PATCH] fsx: add more check for copy_file_range
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>
References: <1569395815-4657-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190925130809.GT2622@desktop>
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
Message-ID: <5307926c-1fdb-5283-5053-b6f4f7d23a41@cn.fujitsu.com>
Date:   Fri, 27 Sep 2019 09:38:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925130809.GT2622@desktop>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: EDF8C4CE14E1.ADC93
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org
Message-ID: <20190927013827.hlhNRHtsdsU2hSyVRGKuFUnn5Uw1ir_PunRxgZw6mg0@z>


ÔÚ 2019/9/25 21:08, Eryu Guan Ð´µÀ:
> On Wed, Sep 25, 2019 at 03:16:55PM +0800, Su Yanjun wrote:
>> On some linux distros(RHEL7, centos 7) copy_file_range uses
>> general implementation (splice interface). splice interace
>> uses pipe_to_file. pipe_to_file only work for different page.
>> The userspace cant's be  aware of such error because copy_file_range
>> returns ok too.
> This looks like a kernel bug to me.
Yes, it's RHEL kernel 3.10's bug. The new kernel is ok.
>> So for such case when copy_file_range return we read back data
>> then check it.
> Yeah, I think we should make sure the data copied is correct.
>
>> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
>> ---
>>   ltp/fsx.c | 32 ++++++++++++++++++++++++++++++++
>>   1 file changed, 32 insertions(+)
>>
>> diff --git a/ltp/fsx.c b/ltp/fsx.c
>> index 06d08e4..0439430 100644
>> --- a/ltp/fsx.c
>> +++ b/ltp/fsx.c
>> @@ -1602,6 +1602,7 @@ do_copy_range(unsigned offset, unsigned length, unsigned dest)
>>   	size_t olen;
>>   	ssize_t nr;
>>   	int tries = 0;
>> +	int ret = 0;
>>   
>>   	if (length == 0) {
>>   		if (!quiet && testcalls > simulatedopcount)
>> @@ -1665,6 +1666,37 @@ do_copy_range(unsigned offset, unsigned length, unsigned dest)
>>   		memset(good_buf + file_size, '\0', dest - file_size);
>>   	if (dest + length > file_size)
>>   		file_size = dest + length;
>> +	/*
>> +	 * Although copy_file_range returns ok
>> +	 * for some linux distros that use general implementation
>> +	 * (splice interface) such as RHEL 7, centos 7 that use
>> +	 * pipe_to_file will cause test fail.
>> +	 *
>> +	 * Here we add a little more check here for copy_file_range
>> +	 * We read copied data then check it. If check fail here
>> +	 * then report it.
>> +	 */
> Above comments seem like not necessary, the content check is inspired by
> Rthis HEL7 issue, but not the main purpose.
>
>> +	ret = lseek(fd, (off_t)dest, SEEK_SET);
>> +	if (ret == (off_t)-1) {
>> +		prterr("doread: lseek");
>                          ^^^^^^^ not doread
>
>> +		report_failure(140);
> Use a different failure number than that in doread, i.e. don't copy the
> code from doread.
>
>> +	}
>> +	ret = fsxread(fd, temp_buf, length, dest);
>> +	if (ret != length) {
>> +		if (ret == -1)
>> +				prterr("doread: read");
>> +		else
>> +				prt("short read: 0x%x bytes instead of 0x%x\n",
>> +					ret, length);
> Same here, not doread, and weired indention above.
>
>> +		report_failure(141);
>> +	}
>> +	if (memcmp(good_buf+dest, temp_buf, length) != 0) {
>> +		prt("copy range: 0x%x to 0x%x at 0x%x\n", offset,
>> +				offset + length, dest);
>> +		prterr("do_copy_range:");
>> +		report_failure(161);
> I think we could take use of check_buffers().
>
> And similar check could be added to do_clone_range as well, I think.

Ok, i'll send patch v2 later.

Thanks

>
> Thanks,
> Eryu
>
>> +
>> +	}
>>   }
>>   
>>   #else
>> -- 
>> 2.7.4
>>
>>
>>
>


