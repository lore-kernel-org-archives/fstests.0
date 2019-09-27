Received: from mail.cn.fujitsu.com ([183.91.158.132]:58250 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726140AbfI0BrE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Sep 2019 21:47:04 -0400
Subject: Re: [PATCH] generic/465: fix a read bug when encounter EOF
References: <1568611466-100970-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190925094720.GS2622@desktop>
From: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Message-ID: <ecd1ae6e-295c-bc27-6c41-20c8a929f81c@cn.fujitsu.com>
Date: Fri, 27 Sep 2019 09:46:59 +0800
MIME-Version: 1.0
In-Reply-To: <20190925094720.GS2622@desktop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


=E5=9C=A8 2019/9/25 17:47, Eryu Guan =E5=86=99=E9=81=93:
> On Mon, Sep 16, 2019 at 01:24:26PM +0800, Su Yanjun wrote:
>> In nfs test, if the writer has not written enough data for reader read=
ing,
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

It's=C2=A0 only workaround of a kernel bug of nfs. In some cases nfs retu=
rns=20
wrong data to userspace, but the return value is ok.

I will send a kernel patch to nfs mailist.

Thanks a lot.

>
> Thanks,
> Eryu
>
>> ---
>>   src/aio-dio-regress/aio-dio-append-write-read-race.c | 17 ++++++++++=
+++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/aio-dio-regress/aio-dio-append-write-read-race.c b/sr=
c/aio-dio-regress/aio-dio-append-write-read-race.c
>> index 911f272..f28ef3c 100644
>> --- a/src/aio-dio-regress/aio-dio-append-write-read-race.c
>> +++ b/src/aio-dio-regress/aio-dio-append-write-read-race.c
>> @@ -44,14 +44,27 @@ static void usage(const char *prog)
>>   static void *reader(void *arg)
>>   {
>>   	struct io_data *data =3D (struct io_data *)arg;
>> +	size_t blksize =3D data->blksize;
>> +	size_t offset =3D data->offset;
>> +	char   *buf =3D data->buf;
>>  =20
>>   	memset(data->buf, 'b', data->blksize);
>>   	reader_ready =3D 1;
>>   	do {
>> -		data->read_sz =3D pread(data->fd, data->buf, data->blksize,
>> -				      data->offset);
>> +		data->read_sz =3D pread(data->fd, buf, blksize,
>> +				      offset);
>>   		if (data->read_sz < 0)
>>   			perror("read file");
>> +
>> +		if (data->read_sz > 0) {
>> +			blksize -=3D data->read_sz;
>> +			offset  +=3D data->read_sz;
>> +			buf	+=3D data->read_sz;
>> +			data->read_sz =3D 0;
>> +		}
>> +
>> +		if (blksize <=3D 0)
>> +			break;
>>   	} while (data->read_sz <=3D 0);
>>  =20
>>   	return NULL;
>> --=20
>> 2.7.4
>>
>>
>>
>
