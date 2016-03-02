Received: from cn.fujitsu.com ([59.151.112.132]:65259 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750738AbcCBFqS (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 2 Mar 2016 00:46:18 -0500
Message-ID: <56D67E0C.2080301@cn.fujitsu.com>
Date: Wed, 2 Mar 2016 13:45:48 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] generic/135: fix standard error output from _scratch_mkfs
References: <1456191325-1217-1-git-send-email-yangx.jy@cn.fujitsu.com> <20160223032652.GC11419@eguan.usersys.redhat.com>
In-Reply-To: <20160223032652.GC11419@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

=E4=BA=8E 2016/02/23 11:26, Eryu Guan =E5=86=99=E9=81=93:
> On Tue, Feb 23, 2016 at 09:35:25AM +0800, Xiao Yang wrote:
>> 'mke2fs 1.42.9 (28-Dec-2013)' produces as standard error when
>> we run generic/135 in ext4 file system. This is a regression
>> bug which bring in by commit:
>> 4a5cda8 xfstests: do not unmount tmpfs during remount
>> That patch remove '2>&1', so i bring that back.
> Thanks for the revision! But I noticed that Ted's patch fixed it too,
>
> "common: filter warning messages from mkfs.ext4"
>
> which filters the warnings in _scratch_mkfs_ext4, so that other mkfs
> errors can be noticed in the test. So I think it's a better fix :)
>
> Thanks,
> Eryu
>
Hi
After applying Ted's pacth, 'mke2fs 1.42.9 (28-Dec-2013)' still produces=20
when we run
generic/135 in ext4 file system. I think that this is standard error=20
instead of warning .
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   tests/generic/135 |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/tests/generic/135 b/tests/generic/135
>> index 52418f6..5aa880d 100755
>> --- a/tests/generic/135
>> +++ b/tests/generic/135
>> @@ -41,7 +41,7 @@ _supported_os Linux IRIX
>>
>>   _require_odirect
>>   _require_scratch
>> -_scratch_mkfs>/dev/null
>> +_scratch_mkfs&>/dev/null
>>   _scratch_mount
>>
>>   cd $SCRATCH_MNT
>> --=20
>> 1.7.1
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>



