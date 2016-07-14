Received: from mail-io0-f170.google.com ([209.85.223.170]:36533 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbcGNKZq (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 14 Jul 2016 06:25:46 -0400
Received: by mail-io0-f170.google.com with SMTP id b62so71319094iod.3
        for <fstests@vger.kernel.org>; Thu, 14 Jul 2016 03:25:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160713103805.GS2432@eguan.usersys.redhat.com>
References: <1464858659-610-1-git-send-email-jtulak@redhat.com>
 <1467389674-5341-1-git-send-email-jtulak@redhat.com> <20160713103805.GS2432@eguan.usersys.redhat.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Thu, 14 Jul 2016 12:25:25 +0200
Message-ID: <CACj3i73kS31MReyxmjjb=jrND6__WAGxZz7LaOOex35F1sgwRw@mail.gmail.com>
Subject: Re: [PATCH v3] xfstests: update xfs/096 for new behaviour
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, "Chinner, Dave" <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 13, 2016 at 12:38 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Fri, Jul 01, 2016 at 06:14:34PM +0200, Jan Tulak wrote:
>> Because we recently changed how mkfs behaves when it gets incorrect/invalid
>> values, add a feature check to run this test only on older binaries, which
>> accepts invalid sunit values.
>>
>> Signed-off-by: Jan Tulak <jtulak@redhat.com>
>> ---
>> UPDATE:
>> Change it to _notrun on newer binaries. Commit message updated respectivvely.
>> ---
>>  tests/xfs/096 | 22 ++++++++++++++++++----
>>  1 file changed, 18 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/xfs/096 b/tests/xfs/096
>> index f949e83..803b49d 100755
>> --- a/tests/xfs/096
>> +++ b/tests/xfs/096
>> @@ -39,6 +39,20 @@ _cleanup()
>>      rm -f $tmp.*
>>  }
>>
>> +# maximum log record size
>> +max_lr_size=`expr 256 \* 1024`
>> +big_su=`expr $max_lr_size + 4096`
>> +
>> +requires_mkfs_accept_invalid_log_sunit()
>> +{
>> +     accepts=`mkfs.xfs -N -l version=2,su=$big_su 2>&1 | \
>> +             grep -ci "No device name"`
>> +     if [ "$accepts" -eq 0 ];then
>> +             _notrun "Runs only on older xfsprogs accepting invalid log sunit"
>> +     fi
>
> You're counting the number of "No device name" string, which doesn't
> seem reliable to me. I'd prefer to rely on whether mkfs.xfs really
> accepts invalid log sunit, so how about:
>
> require_mkfs_accept_invalid_log_sunit()
> {
>         local fsimg=$tmp.img
>         touch $fsimg
>
>         $MKFS_XFS_PROG -N -l version=2,su=$big_su -d name=$fsimg,size=1g >/dev/null 2>&1
>         if [ $? -ne 0 ]; then
>                 _notrun "This test requires v4.5 or older xfsprogs"
>         fi
> }

This looks better, but I'm ditching this detection entirely. I will go
for the common/rc solution and use the code from xfs/400, only
inverted. That seems to me like a better way in long term, and it
makes the new common/rc _requires a bit more useful.

>
> (These mkfs argument checks went to v4.7-rc1, and v4.5 is the latest
> "older" xfsprogs, right?)

Yes, according to VERSION file and tags in the repo.


Thanks,
Jan


-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
