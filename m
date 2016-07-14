Received: from mail-it0-f46.google.com ([209.85.214.46]:36854 "EHLO
	mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbcGNPQk (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 14 Jul 2016 11:16:40 -0400
Received: by mail-it0-f46.google.com with SMTP id f6so49687435ith.1
        for <fstests@vger.kernel.org>; Thu, 14 Jul 2016 08:16:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160714142152.GG2432@eguan.usersys.redhat.com>
References: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
 <1468500214-6237-5-git-send-email-jtulak@redhat.com> <20160714142152.GG2432@eguan.usersys.redhat.com>
From: Jan Tulak <jtulak@redhat.com>
Date: Thu, 14 Jul 2016 17:16:19 +0200
Message-ID: <CACj3i702GbeOLc25RJVvd09xoWwRVL6JXBSK_Za61azp6p-fVg@mail.gmail.com>
Subject: Re: [PATCH 4/6] xfstests: add _require_xfs_mkfs_validation to common/rc
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 14, 2016 at 4:21 PM, Eryu Guan <eguan@redhat.com> wrote:
> On Thu, Jul 14, 2016 at 02:43:32PM +0200, Jan Tulak wrote:
>> Add a simple way to skip a test if it is (or is not) run on mkfs correctly
>> validating inputs.
>>
>> Signed-off-by: Jan Tulak <jtulak@redhat.com>
>> ---
>>  common/rc | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 0c68e4f..72f9901 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -3843,6 +3843,35 @@ _get_fs_sysfs_attr()
>>       cat /sys/fs/${FSTYP}/${dname}/${attr}
>>  }
>>
>> +# Skip if we are running an older binary without the stricter input checks.
>> +# Make multiple checks to be sure that there is no regression on the one
>> +# selected feature check, which would skew the result.
>> +_require_xfs_mkfs_validation()
>> +{
>> +     _require_scratch
>
> I don't think you need $SCRATCH_DEV and _require_scratch in this helper,
> a test file just does the work, e.g. creating an empty file somewhere
> and using the "-d name=<filename>,size=<size>" option of mkfs.xfs to do
> the test.
>

True, that works too. I'm doing some further small tinkering around
this patch, but I will send a new version soon.

>> +     $MKFS_XFS_PROG -f -N -s size=2s $SCRATCH_DEV >/dev/null 2>&1
>> +     sum=$?
>> +     $MKFS_XFS_PROG -f -N -l version=2,su=$((256 * 1024 + 4096)) $SCRATCH_DEV >/dev/null 2>&1
>> +     sum=`expr $sum + $?`
>> +
>> +     if [ "$sum" -eq 0 ]; then
>> +             _notrun "Requires newer mkfs with stricter input checks."
>
> "newer mkfs" is not specific, it's not clear which version of xfsprogs
> one should use to run this test. It'd be good to see specific version
> info in this message if possible. (Sorry I didn't make my point clear in
> previous reviews.)
>

All right. :-) How about these?
Requires older mkfs without strict input checks: the last supported
version of xfsprogs is 4.5.
Requires newer mkfs with stricter input checks: the oldest supported
version of xfsprogs is 4.7.

Thanks,
Jan

> Thanks,
> Eryu
>
>> +     fi
>> +}
>> +
>> +# The oposite of _require_xfs_mkfs_validation.
>> +_require_xfs_mkfs_without_validation()
>> +{
>> +     _require_scratch
>> +     $MKFS_XFS_PROG -f -N -s size=2s $SCRATCH_DEV >/dev/null 2>&1
>> +     sum=$?
>> +     $MKFS_XFS_PROG -f -N -l version=2,su=$((256 * 1024 + 4096)) $SCRATCH_DEV >/dev/null 2>&1
>> +     sum=`expr $sum + $?`
>> +
>> +     if [ "$sum" -eq 2 ]; then
>> +             _notrun "Requires older mkfs without stricter input checks."
>> +     fi
>> +}
>>  init_rc
>>
>>  ################################################################################
>> --
>> 2.5.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jan Tulak
jtulak@redhat.com / jan@tulak.me
