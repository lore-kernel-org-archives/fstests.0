Received: from mail.cn.fujitsu.com ([183.91.158.132]:50123 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726029AbfI0Bif (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Sep 2019 21:38:35 -0400
Subject: Re: [PATCH] fsx: add more check for copy_file_range
References: <1569395815-4657-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190925130809.GT2622@desktop>
From: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Message-ID: <5307926c-1fdb-5283-5053-b6f4f7d23a41@cn.fujitsu.com>
Date: Fri, 27 Sep 2019 09:38:27 +0800
MIME-Version: 1.0
In-Reply-To: <20190925130809.GT2622@desktop>
Content-Type: text/plain; charset="gbk"; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


=D4=DA 2019/9/25 21:08, Eryu Guan =D0=B4=B5=C0:
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
>> @@ -1602,6 +1602,7 @@ do_copy_range(unsigned offset, unsigned length, =
unsigned dest)
>>   	size_t olen;
>>   	ssize_t nr;
>>   	int tries =3D 0;
>> +	int ret =3D 0;
>>  =20
>>   	if (length =3D=3D 0) {
>>   		if (!quiet && testcalls > simulatedopcount)
>> @@ -1665,6 +1666,37 @@ do_copy_range(unsigned offset, unsigned length,=
 unsigned dest)
>>   		memset(good_buf + file_size, '\0', dest - file_size);
>>   	if (dest + length > file_size)
>>   		file_size =3D dest + length;
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
> Above comments seem like not necessary, the content check is inspired b=
y
> Rthis HEL7 issue, but not the main purpose.
>
>> +	ret =3D lseek(fd, (off_t)dest, SEEK_SET);
>> +	if (ret =3D=3D (off_t)-1) {
>> +		prterr("doread: lseek");
>                          ^^^^^^^ not doread
>
>> +		report_failure(140);
> Use a different failure number than that in doread, i.e. don't copy the
> code from doread.
>
>> +	}
>> +	ret =3D fsxread(fd, temp_buf, length, dest);
>> +	if (ret !=3D length) {
>> +		if (ret =3D=3D -1)
>> +				prterr("doread: read");
>> +		else
>> +				prt("short read: 0x%x bytes instead of 0x%x\n",
>> +					ret, length);
> Same here, not doread, and weired indention above.
>
>> +		report_failure(141);
>> +	}
>> +	if (memcmp(good_buf+dest, temp_buf, length) !=3D 0) {
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
>>  =20
>>   #else
>> --=20
>> 2.7.4
>>
>>
>>
>
