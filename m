Return-Path: <rjevskiy@gmail.com>
Sender: Dmitry Monakhov <rjevskiy@gmail.com>
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: Re: [PATCH 1/2] xfstest: shared/298 fixup mkfs options
In-Reply-To: <53ECED1E.4070106@sandeen.net>
References: <1407944188-4099-1-git-send-email-dmonakhov@openvz.org> <53ECED1E.4070106@sandeen.net>
Date: Fri, 15 Aug 2014 14:20:44 +0400
Message-ID: <87vbpucav7.fsf@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Eric Sandeen <sandeen@sandeen.net>, fstests@vger.kernel.org
Cc: david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

On Thu, 14 Aug 2014 10:08:46 -0700, Eric Sandeen <sandeen@sandeen.net> wrote:
> On 8/13/14, 8:36 AM, Dmitry Monakhov wrote:
> > Currently mkfs faile due to incorrect options
> 
> fails how, for what fs, with what options?
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 ts105 3.16.0-rc5-00015-g15eb408
MKFS_OPTIONS  -- -b4096 /dev/mapper/vg-scratch_dev
MOUNT_OPTIONS -- -o acl,user_xattr /dev/mapper/vg-scratch_dev /mnt_scratch

shared/298 18s ... - output mismatch (see
/root/xfstests-dev.git/results//shared/298.out.bad)
    --- tests/shared/298.out    2014-08-13 18:22:08.297016412 +0400
    +++ /root/xfstests-dev.git/results//shared/298.out.bad    2014-08-15
    14:19:00.847434929 +0400
    @@ -1,4 +1,5 @@
     QA output created by 298
    +mount: you must specify the filesystem type
     Generating garbage on loop...done.
     Running fstrim...done.
     Detecting interesting holes in image...done.
    ...
    (Run 'diff -u tests/shared/298.out
    /root/xfstests-dev.git/results//shared/298.out.bad'  to see the
    entire diff)
Ran: shared/298
Failures: shared/298
Failed 1 of 1 tests
> 
> Thanks,
> -Eric
> 
> > Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
> > ---
> >  tests/shared/298 |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tests/shared/298 b/tests/shared/298
> > index 372fd02..685ba27 100755
> > --- a/tests/shared/298
> > +++ b/tests/shared/298
> > @@ -134,8 +134,8 @@ mkdir $loop_mnt
> >  
> >  [ "$FSTYP" = "xfs" ] && MKFS_OPTIONS="-f $MKFS_OPTIONS"
> >  
> > -$MKFS_PROG -t $FSTYP $MKFS_OPTIONS $loop_dev &> /dev/null
> > -$MOUNT_PROG $loop_dev $loop_mnt
> > +run_check $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $loop_dev
> > +run_check $MOUNT_PROG $loop_dev $loop_mnt
> >  
> >  echo -n "Generating garbage on loop..."
> >  # Goal is to fill it up, ignore any errors.
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
