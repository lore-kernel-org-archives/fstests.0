Received: from mail.cn.fujitsu.com ([183.91.158.132]:25259 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733188AbfIZDFX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 Sep 2019 23:05:23 -0400
Subject: Re: [PATCH] generic/442: add sync before dmsetup remove
References: <1569400158-5297-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190925130824.GU2622@desktop>
From: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Message-ID: <7f33fe1f-fe48-6a21-a92a-ca922265cdea@cn.fujitsu.com>
Date: Thu, 26 Sep 2019 11:05:13 +0800
MIME-Version: 1.0
In-Reply-To: <20190925130824.GU2622@desktop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


=E5=9C=A8 2019/9/25 21:08, Eryu Guan =E5=86=99=E9=81=93:
> On Wed, Sep 25, 2019 at 04:29:18PM +0800, Su Yanjun wrote:
>> This test case sometime fails. Because "dmsetup remove error-test" may
>> fail when some writeback is going on.
>>
>> This patch adds sync before dmsetup remove operation.
>>
>> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
>> ---
>>   tests/generic/442 | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/generic/442 b/tests/generic/442
>> index fe6d460..d48ca36 100755
>> --- a/tests/generic/442
>> +++ b/tests/generic/442
>> @@ -43,6 +43,7 @@ $here/src/fsync-err -d $here/src/dmerror $DMERROR_DE=
V
> fsync-err should have flipped $DMERROR_DEV to working mode and fsync
> each open fd before exit if fsync-err didn't report any failure. So
> there should be no on-going writeback.
>>  =20
>>   # success, all done
>>   _dmerror_load_working_table
>> +sync
>>   _dmerror_cleanup
> And _dmerror_cleanup umount $DMERROR_DEV first, then tear down the dm
> device. Could you check if fsync-err returns successfully and umount
> succeeds as well?

I cant find any mount info for $DMERROR_DEV in this test. fsync-err=C2=A0=
=20
just does write or sync test with the raw logical dm device.

Am i missing something?

mkfs.xfs: cannot open /dev/sda11: Device or resource busy
device-mapper: remove ioctl on error-test=C2=A0 failed: Device or resourc=
e busy
Command failed.
_check_xfs_filesystem: filesystem on /dev/sda11 has dirty log
*** xfs_logprint -t output ***
xfs_logprint: logprint.c:230: main: Assertion `x.logBBsize <=3D=20
0x7fffffff' failed.
*** end xfs_logprint output

 From above log, dmsetup remove failed with "Device or resource busy".

> Thanks,
> Eryu
>
>>   _scratch_mkfs > $seqres.full 2>&1
>>   status=3D0
>> --=20
>> 2.7.4
>>
>>
>>
>
