Received: from mail-oi0-f67.google.com ([209.85.218.67]:35982 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbcAKFUO (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 11 Jan 2016 00:20:14 -0500
Received: by mail-oi0-f67.google.com with SMTP id a202so3309431oib.3
        for <fstests@vger.kernel.org>; Sun, 10 Jan 2016 21:20:14 -0800 (PST)
Subject: Re: [PATCH 2/2] fstests: give user friendly prompts for already
 mounted dir
References: <1452148649-22451-1-git-send-email-hejianet@gmail.com>
 <1452148649-22451-3-git-send-email-hejianet@gmail.com>
 <20160110232938.GF10456@dastard>
From: hejianet <hejianet@gmail.com>
Message-ID: <56933B88.5080608@gmail.com>
Date: Mon, 11 Jan 2016 13:20:08 +0800
MIME-Version: 1.0
In-Reply-To: <20160110232938.GF10456@dastard>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



=E5=9C=A8 1/11/16 7:29 AM, Dave Chinner =E5=86=99=E9=81=93:
> On Thu, Jan 07, 2016 at 02:37:29PM +0800, Jia He wrote:
>> This adds user friendly prompts to output the already mounted line fro=
m _mount.
>> xfstests will do the cleanup (ie. umount) and user can not get the mou=
nt directory
>> information.
>>
>> Signed-off-by: Jia He <hejianet@gmail.com>
>> ---
>>   common/rc | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/common/rc b/common/rc
>> index d33e3fb..5b40fb4 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1271,7 +1271,9 @@ _require_scratch_nocheck()
>>           # if it's mounted, make sure its on $SCRATCH_MNT
>>           if ! _mount | grep -F $SCRATCH_DEV | grep -q $SCRATCH_MNT
>>           then
>> -            echo "\$SCRATCH_DEV is mounted but not on \$SCRATCH_MNT -=
 aborting"
>> +            echo "\$SCRATCH_DEV=3D$SCRATCH_DEV is mounted but not on =
\$SCRATCH_MNT=3D$SCRATCH_MNT - aborting"
>> +            echo "Already mounted result:"
>> +            _mount | grep -F $SCRATCH_DEV
>>               exit 1
>>           fi
> Should use a temporary local variable rather than looking at the
> mount table twice. e.g.
>
> 	mount_rec=3D`_mount | grep -F $SCRATCH_DEV`
> 	echo $mount_rec | grep -q $SCRATCH_MNT
> 	if [ $? -ne 0 ]; then
> 		# new error message
> 		echo $mount_rec
> 	fi
Thanks=EF=BC=8C Dave
v3 is sending.

B.R.
Justin
>
> Cheers,
>
> Dave.

