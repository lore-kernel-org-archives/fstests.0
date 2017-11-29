Received: from mail.cn.fujitsu.com ([183.91.158.132]:59249 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751713AbdK2Bmy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Nov 2017 20:42:54 -0500
Message-ID: <5A1E1096.1030906@cn.fujitsu.com>
Date: Wed, 29 Nov 2017 09:42:46 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] generic/465: just check the actual read data under
 dio read/write
References: <20171123061417.GR2749@eguan.usersys.redhat.com> <1511750067-5722-1-git-send-email-yangx.jy@cn.fujitsu.com> <20171128072028.GF2749@eguan.usersys.redhat.com>
In-Reply-To: <20171128072028.GF2749@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/11/28 15:20, Eryu Guan wrote:
> On Mon, Nov 27, 2017 at 10:34:27AM +0800, Xiao Yang wrote:
>> I got the following message when running generic/465 in ext4 data=journal mode
>> ---------------------------------------------------------------
>> QA output created by 465
>> non-aio dio test
>> encounter an error: block 0 offset 4096, content 62
>> encounter an error: block 0 offset 122880, content 62
>> encounter an error: block 0 offset 274432, content 62
>> encounter an error: block 0 offset 86016, content 62
>> aio-dio test
>> encounter an error: block 0 offset 28672, content 62
>> encounter an error: block 0 offset 12288, content 62
>> encounter an error: block 2 offset 16384, content 62
>> encounter an error: block 1 offset 565248, content 62
>> ---------------------------------------------------------------
>>
>> In ext4 data=journal mode, direct read will fall back to buffer read, and buffer
>> read doesn't take inode lock, so it doesn't need to wait for the writer to finish
>> first and sees the intermediate inode size and returns data less than 1M.
>>
>> We can just check the actual read data instead of the whole read buffer.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   src/aio-dio-regress/aio-dio-append-write-read-race.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/src/aio-dio-regress/aio-dio-append-write-read-race.c b/src/aio-dio-regress/aio-dio-append-write-read-race.c
>> index 8f94d50..eaec784 100644
>> --- a/src/aio-dio-regress/aio-dio-append-write-read-race.c
>> +++ b/src/aio-dio-regress/aio-dio-append-write-read-race.c
>> @@ -43,6 +43,7 @@ struct io_data {
>>   	off_t offset;
>>   	char *buf;
>>   	int use_aio;
>> +	size_t act_sz;
> I think this should be a signed value, as pread returns ssize_t. And
> maybe rename the variable to read_sz? Otherwise looks fine to me. And I
> can do the updates on commit, if there's no further review comments.
Hi Eryu,

Thanks for your comment, i can send v3 patch as you suggested. :-)

Thanks,
Xiao Yang
> Thanks,
> Eryu
>
>>   };
>>
>>   int reader_ready = 0;
>> @@ -57,15 +58,14 @@ static void usage(const char *prog)
>>   static void *reader(void *arg)
>>   {
>>   	struct io_data *data = (struct io_data *)arg;
>> -	int ret;
>>
>>   	memset(data->buf, 'b', data->blksize);
>>   	reader_ready = 1;
>>   	do {
>> -		ret = pread(data->fd, data->buf, data->blksize, data->offset);
>> -		if (ret<  0)
>> +		data->act_sz = pread(data->fd, data->buf, data->blksize, data->offset);
>> +		if (data->act_sz<  0)
>>   			perror("read file");
>> -	} while (ret<= 0);
>> +	} while (data->act_sz<= 0);
>>
>>   	return NULL;
>>   }
>> @@ -203,7 +203,7 @@ int main(int argc, char *argv[])
>>   			goto err;
>>   		}
>>
>> -		for (j = 0; j<  blksize; j++) {
>> +		for (j = 0; j<  rdata.act_sz; j++) {
>>   			if (rdata.buf[j] != 'a') {
>>   				fail("encounter an error: "
>>   					"block %d offset %d, content %x\n",
>> -- 
>> 1.8.3.1
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> .
>



