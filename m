Received: from mail-ot0-f195.google.com ([74.125.82.195]:34214 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932442AbdCIO12 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Mar 2017 09:27:28 -0500
Received: by mail-ot0-f195.google.com with SMTP id x37so7146519ota.1
        for <fstests@vger.kernel.org>; Thu, 09 Mar 2017 06:26:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170309134529.GT14075@dhcp12-143.nay.redhat.com>
References: <1489045940-16196-1-git-send-email-zlang@redhat.com>
 <CAOQ4uxhW3JWMOHUrRdO=eoJvKNrpJq76VBJKMWgLUYnvNXMohw@mail.gmail.com> <20170309134529.GT14075@dhcp12-143.nay.redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 Mar 2017 16:26:57 +0200
Message-ID: <CAOQ4uxgnvf0GZ5Xtq=cDt80wivxDctiyAEo40NUnxfXeppgqaw@mail.gmail.com>
Subject: Re: [PATCH v2] xfs/078: instead file image by mkfs on loopback device
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 9, 2017 at 3:45 PM, Zorro Lang <zlang@redhat.com> wrote:
> On Thu, Mar 09, 2017 at 10:27:05AM +0200, Amir Goldstein wrote:
>> On Thu, Mar 9, 2017 at 9:52 AM, Zorro Lang <zlang@redhat.com> wrote:
>> > If test on 4k sector size device, xfs/078 will fail when it try to
>> > make a filesystem image with block size less than 4096. But if we
>> > attach the file image to a loop device, it can accept 512 block
>> > size. So this patch attach a loop device before do mkfs.xfs.
>> >
>> > Signed-off-by: Zorro Lang <zlang@redhat.com>
>> > ---
>>
>> Looks good. just one more small cleanup..
>>
>> >
>> > Hi,
>> >
>> > There's a new bug can be found after this change, if test on 4k
>> > sector size disks. I didn't change the expected behaviors of the
>> > case. It can't run on 4k sector size disk due to itself's problem,
>> > now after fix this problem, it can find that bug now. So it's not
>> > a regression bug.
>> >
>> > I've sent a patch for that problem:
>> >   [PATCH] repair: handle reading superblock from image on larger sector size filesystem
>> >
>> > Thanks for Amir helped to review last V1 patch, this case can cover
>> > above bug due to his suggestion about using "umount -d".
>> >
>> > Thanks,
>> > Zorro
>> >
>> >  tests/xfs/078     | 48 +++++++++++++++++++++++++-----------------------
>> >  tests/xfs/078.out | 16 ++++++++--------
>> >  2 files changed, 33 insertions(+), 31 deletions(-)
>> >
>> > diff --git a/tests/xfs/078 b/tests/xfs/078
>> > index 0d6eb55..3b57730 100755
>> > --- a/tests/xfs/078
>> > +++ b/tests/xfs/078
>> > @@ -34,11 +34,11 @@ trap "_cleanup; rm -f $tmp.*; exit \$status" 0 1 2 3 15
>> >
>> >  _cleanup()
>> >  {
>> > -    cd /
>> > -    rm -f $tmp.*
>> > -    umount $LOOP_MNT 2>/dev/null
>> > -    [ -n "$LOOP_DEV" ] && losetup -d $LOOP_DEV
>> > -    rmdir $LOOP_MNT
>> > +       cd /
>> > +       rm -f $tmp.*
>> > +       umount -d $LOOP_MNT 2>/dev/null
>>
>> I guess maybe my suggestion to use umount -d here was not optimal,
>> because it does not handle cleanup properly in case mount fails.
>>
>> So maybe to be on the safe side?:
>>
>> +       umount $LOOP_MNT 2>/dev/null
>> +       [ -n "$LOOP_DEV" ] && _destroy_loop_device $LOOP_DEV 2>/dev/null
>
> Hmm... make sense.
>
>>
>> > +       rm -f $LOOP_IMG
>> > +       rmdir $LOOP_MNT
>> >  }
>> >
>> >  # get standard environment, filters and checks
>> > @@ -52,6 +52,7 @@ _supported_os Linux
>> >  _require_test
>> >  # Must have loop device
>> >  _require_loop
>> > +_require_xfs_io_command "truncate"
>> >
>> >  LOOP_IMG=$TEST_DIR/$seq.fs
>> >  LOOP_MNT=$TEST_DIR/$seq.mnt
>> > @@ -77,9 +78,12 @@ _grow_loop()
>> >         check=$4
>> >         agsize=$5
>> >
>> > -       dparam="file,name=$LOOP_IMG,size=$original"
>> > +       $XFS_IO_PROG -f -c "truncate $original" $LOOP_IMG
>> > +       LOOP_DEV=`_create_loop_device $LOOP_IMG`
>> > +
>> > +       dparam=""
>> >         if [ -n "$agsize" ]; then
>> > -               dparam="$dparam,agsize=$agsize"
>> > +               dparam="-d agsize=$agsize"
>> >         fi
>> >
>> >         echo
>> > @@ -87,46 +91,44 @@ _grow_loop()
>> >         echo
>> >
>> >         echo "*** mkfs loop file (size=$original)"
>> > -       mkfs_crc_opts="-m crc=0"
>> > -       if [ -n "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
>> > -               mkfs_crc_opts=""
>> > +       mkfs_crc_opts=""
>> > +       if [ $bsize -lt 1024 -a -z "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
>> > +               mkfs_crc_opts="-m crc=0"
>> >         fi
>> > -       $MKFS_XFS_PROG $mkfs_crc_opts -b size=$bsize -d $dparam \
>> > +       $MKFS_XFS_PROG $mkfs_crc_opts -b size=$bsize $dparam $LOOP_DEV \
>> >                 | _filter_mkfs 2>/dev/null
>> >
>> >         echo "*** extend loop file"
>> > +       _destroy_loop_device $LOOP_DEV
>> >         $XFS_IO_PROG -c "pwrite $new_size $bsize" $LOOP_IMG | _filter_io
>> > +       LOOP_DEV=`_create_loop_device $LOOP_IMG`
>> >         echo "*** mount loop filesystem"
>> > -       mount -t xfs -o loop $LOOP_IMG $LOOP_MNT
>> > +       mount -t xfs $LOOP_DEV $LOOP_MNT
>> >
>> >         echo "*** grow loop filesystem"
>> > -       #xfs_growfs $LOOP_MNT 2>&1 | grep -e "^data" #| _filter_growfs 2>/dev/null
>> >         $XFS_GROWFS_PROG $LOOP_MNT 2>&1 |  _filter_growfs 2>&1
>> >
>> >         echo "*** unmount"
>> > -       umount $LOOP_MNT > /dev/null 2>&1
>> > +       umount -d $LOOP_MNT
>> >
>> >         # Large grows takes forever to check..
>> >         if [ "$check" -gt "0" ]
>> >         then
>> >                 echo "*** check"
>> > -               LOOP_DEV=`losetup -f`
>> > -               losetup $LOOP_DEV $LOOP_IMG
>> > -                _check_xfs_filesystem $LOOP_DEV none none
>> > -               losetup -d $LOOP_DEV
>> > -               LOOP_DEV=
>> > +               _check_xfs_filesystem $LOOP_IMG none none
>> >         fi
>> >
>> > +       LOOP_DEV=
>>
>> better move this line up below umount -d
>> in case _check_xfs_filesystem fails no need to cleanup LOOP_DEV
>
> There's a "LOOP_DEV=" above _check_xfs_filesystem.

Where? your patch removes the line "LOOP_DEV=" above _check_xfs_filesystem.

> If _check_xfs_filesystem fails, it'll run "exit 1" to end this case.
>

Right. and then when _cleanup() is called you want $LOOP_DEV to already
be empty, so need to unset it after umount -d and before _check_xfs_filesystem
