Received: from mail-ot0-f194.google.com ([74.125.82.194]:33454 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754798AbdCINY6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Mar 2017 08:24:58 -0500
Received: by mail-ot0-f194.google.com with SMTP id 19so6980707oti.0
        for <fstests@vger.kernel.org>; Thu, 09 Mar 2017 05:24:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxhcb1UnX29nsEEvp5djaWMHXc_dO==Pibv4i2AvXmfjTA@mail.gmail.com>
References: <1488957991-18194-1-git-send-email-zlang@redhat.com>
 <CAOQ4uxhq2h_WEKz1o+_AC8qFT6n6x40eUcBUpoe2eT1pfHAo7w@mail.gmail.com>
 <20170308115136.GF14226@eguan.usersys.redhat.com> <CAOQ4uxiJKouz9c=91Odd1CsrmkiKcnFuQT1r2V1Fa+UuOm9fxw@mail.gmail.com>
 <20170309095938.GJ14226@eguan.usersys.redhat.com> <CAOQ4uxhcb1UnX29nsEEvp5djaWMHXc_dO==Pibv4i2AvXmfjTA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 Mar 2017 15:16:38 +0200
Message-ID: <CAOQ4uxijM=6AJjPCG23w6QWK8z4+a-5pRW2wZEXbVXJbGz=csQ@mail.gmail.com>
Subject: Re: [PATCH] generic/411: change sub-path name that's duplicate of TEST_DIR
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 9, 2017 at 1:28 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Thu, Mar 9, 2017 at 11:59 AM, Eryu Guan <eguan@redhat.com> wrote:
>> On Wed, Mar 08, 2017 at 04:26:22PM +0200, Amir Goldstein wrote:
>>
>> [snip]
>>
>>> From f365bd5d60d9d5b82e02db17e615380bf37a74de Mon Sep 17 00:00:00 2001
>>> From: Amir Goldstein <amir73il@gmail.com>
>>> Date: Wed, 8 Mar 2017 12:38:22 +0200
>>> Subject: [PATCH] filter: match $TEST_* $SCRATCH_* in beginning of path string
>>>
>>> For example, if $TEST_DIR=/mnt, only replace instacnes of /mnt that
>>> are in the beginning of a path string, e.g.:
>>>
>>> "/mnt/mntA/mntB:/mnt/mntC" => "TEST_DIR/mntA/mntB:TEST_DIR/mntC"
>>>
>>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>>
>> I'm testing this patch now, with the following config:
>>
>> TEST_DEV=/dev/vda5
>> TEST_DIR=/vda5
>> SCRATCH_DEV=/dev/vda6
>> SCRATCH_MNT=/vda6
>> FSTYP=xfs
>> MKFS_OPTIONS="-m crc=1,reflink=1"
>>
>> First I run this test on xfs, and everything went well. Then I ran test
>> with -overlay option, and found generic/171 generic/172 in this order
>> confused _check_mounted_on().
>>
>> ./check -overlay generic/17[1-2]
>>
>> I got this diff
>>
>> --- tests/generic/172.out       2016-12-30 14:13:24.076000000 +0800
>> +++ /root/xfstests/results//xfs_4k_reflink/generic/172.out.bad  2017-03-09 17:27:12.203000000 +0800
>> @@ -1,9 +1,4 @@
>>  QA output created by 172
>> -Format and mount
>> -Reformat with appropriate size
>> -Create a big file and reflink it
>> -Allocate the rest of the space
>> -CoW the big file
>> -pwrite: No space left on device
>> -Remount and try CoW again
>> -pwrite: No space left on device
>> +SCRATCH_DEV=/vda6 is mounted but not on SCRATCH_MNT=/vda6/ovl-mnt - aborting
>> +Already mounted result:
>> +/dev/vda6 on /vda6 type xfs (rw,relatime,context=system_u:object_r:nfs_t:s0,attr2,inode64,noquota)
>>
>> Seems the 'grep -F "$dev on ' check isn't that accurate either. This
>> also happens without this patch.
>>
>
> Oops. Good catch.
> I have this sort of setup with kvm-xfstests, but only tested it with
> old overlay config
> (because I need to change kvm-xfstests scripts to new overlay config)

So I changed kvm-xfstests over to new overlay config and got the error
you reported.
Your fix also works, but see a few minor comments below.

>
>> I'm trying a draft patch like below, this seems to fix the problem for
>> me, and it works for NFS too (both ipv4 and ipv6). I'm testing your
>> patch + my local fix now.  Will see how it goes, if everything goes well
>> I'll post it as a seperate patch.
>
> Are you planning to keep my patch as is or drop the else statement in
> the filters?
>
>>
>> diff --git a/common/rc b/common/rc
>> index 109325d..e3169d5 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1440,11 +1440,13 @@ _check_mounted_on()
>>         # IPv6 server as a regular expression.  Because of that, we cannot use
>>         # ^$dev so we use "$dev on " to avoid matching $dev to mount point field
>>         # for overlay case, where $dev is a directory.

The comment above is no longer relevant

>> -       local mount_rec=`_mount | grep -F "$dev on "`
>> +#      local mount_rec=`_mount | grep -F "$dev on "`
>> +       local mount_rec=`findmnt -rnc -S $dev -o SOURCE,TARGET`
>>         [ -n "$mount_rec" ] || return 1 # 1 = not mounted
>>
>>         # if it's mounted, make sure its on $mnt
>> -       if ! (echo $mount_rec | grep -q "$dev on $mnt")
>> +#      if ! (echo $mount_rec | grep -q "$dev on $mnt")
>> +       if ! (echo $mount_rec | grep -Fq "$dev $mnt")

Why bother with grep -F (and having to keep the comment above).
I used the following instead:
+       if [ "$mount_rec" != "$dev $mnt" ]


>>         then
>>                 echo "$devname=$dev is mounted but not on $mntname=$mnt - aborti
>>                 echo "Already mounted result:"
>>
>> I paste it here to see if you have any early comments :)
>
> Look good.
