Return-Path: <SRS0=31Kr=XW=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CE5C4360C
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Sep 2019 01:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF82B206B7
	for <linux-fstests@archiver.kernel.org>; Fri, 27 Sep 2019 01:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfI0BrE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 26 Sep 2019 21:47:04 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:58250 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726140AbfI0BrE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Sep 2019 21:47:04 -0400
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; 
   d="scan'208";a="76088491"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Sep 2019 09:47:02 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 76B574CE14F7;
        Fri, 27 Sep 2019 09:47:05 +0800 (CST)
Received: from [10.167.226.33] (10.167.226.33) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 27 Sep 2019 09:47:05 +0800
Subject: Re: [PATCH] generic/465: fix a read bug when encounter EOF
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>
References: <1568611466-100970-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190925094720.GS2622@desktop>
From:   Su Yanjun <suyj.fnst@cn.fujitsu.com>
Message-ID: <ecd1ae6e-295c-bc27-6c41-20c8a929f81c@cn.fujitsu.com>
Date:   Fri, 27 Sep 2019 09:46:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190925094720.GS2622@desktop>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.33]
X-yoursite-MailScanner-ID: 76B574CE14F7.AC15E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org
Message-ID: <20190927014659.VHl9T8QwVn6F3-V26BopSEovhRNfPmElg-766ZUC4y8@z>


在 2019/9/25 17:47, Eryu Guan 写道:
> On Mon, Sep 16, 2019 at 01:24:26PM +0800, Su Yanjun wrote:
>> In nfs test, if the writer has not written enough data for reader reading,
>> then reader only get partial data and test fails.
>>
>> We can continue reading until read enough data.
>>
>> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> Would you please provide more info on the actual failure you've seen? I
> think the partial read issue should have been addressed by commit
> 2428c08a6025 ("generic/465: just check the actual read data under dio
> read/write")

I rechecked my patch and my patch is not needed at all.

It's  only workaround of a kernel bug of nfs. In some cases nfs returns 
wrong data to userspace, but the return value is ok.

I will send a kernel patch to nfs mailist.

Thanks a lot.

>
> Thanks,
> Eryu
>
>> ---
>>   src/aio-dio-regress/aio-dio-append-write-read-race.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/aio-dio-regress/aio-dio-append-write-read-race.c b/src/aio-dio-regress/aio-dio-append-write-read-race.c
>> index 911f272..f28ef3c 100644
>> --- a/src/aio-dio-regress/aio-dio-append-write-read-race.c
>> +++ b/src/aio-dio-regress/aio-dio-append-write-read-race.c
>> @@ -44,14 +44,27 @@ static void usage(const char *prog)
>>   static void *reader(void *arg)
>>   {
>>   	struct io_data *data = (struct io_data *)arg;
>> +	size_t blksize = data->blksize;
>> +	size_t offset = data->offset;
>> +	char   *buf = data->buf;
>>   
>>   	memset(data->buf, 'b', data->blksize);
>>   	reader_ready = 1;
>>   	do {
>> -		data->read_sz = pread(data->fd, data->buf, data->blksize,
>> -				      data->offset);
>> +		data->read_sz = pread(data->fd, buf, blksize,
>> +				      offset);
>>   		if (data->read_sz < 0)
>>   			perror("read file");
>> +
>> +		if (data->read_sz > 0) {
>> +			blksize -= data->read_sz;
>> +			offset  += data->read_sz;
>> +			buf	+= data->read_sz;
>> +			data->read_sz = 0;
>> +		}
>> +
>> +		if (blksize <= 0)
>> +			break;
>>   	} while (data->read_sz <= 0);
>>   
>>   	return NULL;
>> -- 
>> 2.7.4
>>
>>
>>
>


