Received: from mail-pl1-f180.google.com ([209.85.214.180]:32975 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfDICFa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 8 Apr 2019 22:05:30 -0400
Received: by mail-pl1-f180.google.com with SMTP id t16so8425624plo.0
        for <fstests@vger.kernel.org>; Mon, 08 Apr 2019 19:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190408023029.13135-1-xifeng@redhat.com> <20190409015011.GK2824@desktop>
 <CAH2r5mtbjLomReukHw8xO_mm8R0MgVBo7GzZWFxC8i+6X-JeeA@mail.gmail.com>
In-Reply-To: <CAH2r5mtbjLomReukHw8xO_mm8R0MgVBo7GzZWFxC8i+6X-JeeA@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 8 Apr 2019 21:05:18 -0500
Message-ID: <CAH2r5msp=VWjFFgOGmayaAzc-YZe6myh12LBgxCTJK4QfkLG=Q@mail.gmail.com>
Subject: Fwd: [PATCH v3] common/rc: use _try_scratch_mount for scratch_remount
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

---------- Forwarded message ---------
From: Steve French <smfrench@gmail.com>
Date: Mon, Apr 8, 2019 at 8:59 PM
Subject: Re: [PATCH v3] common/rc: use _try_scratch_mount for scratch_remount
To: Eryu Guan <guaneryu@gmail.com>
Cc: Xiaoli Feng <xifeng@redhat.com>, <fstests@vger.kernel.org>





On Mon, Apr 8, 2019, 20:50 Eryu Guan <guaneryu@gmail.com> wrote:
>
> On Mon, Apr 08, 2019 at 10:30:29AM +0800, Xiaoli Feng wrote:
> > From: Xiaoli Feng <xifeng@redhat.com>
> >
> > When call _scratch_remount for cifs , it always requires to input
> > password. This will make generic/306 generic/452 failed because
> > cifs remount failed.
>
> You're missing Signed-off-by tag, would you please resend?
>
> And many thanks to Steve French for helping test the patch! May I add
> your Tested-by tag?
>

Yes - no problem

Reviewed-and-tested-by: Steve French <stfrench@microsoft.com>

I am very excited about the improved automation of various xfstests
for build verification testing for cifs.ko with various SMB3 server
targets (Various Samba/Linux, Azure (cloud), Windows etc.) and using
various common mount options - so any additional tests we can add is
of significant benefit (we have found dozens of bugs and missing
features as a result of these testing improvements in the last five
months).

> Thanks,
> Eryu
>
> > ---
> >  common/rc         | 2 +-
> >  tests/overlay/035 | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/common/rc b/common/rc
> > index 1c42515f..6c262e32 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -357,7 +357,7 @@ _scratch_remount()
> >      local opts="$1"
> >
> >      if test -n "$opts"; then
> > -     mount -o "remount,$opts" $SCRATCH_MNT
> > +     _try_scratch_mount "-o remount,$opts"
> >      fi
> >  }
> >
> > diff --git a/tests/overlay/035 b/tests/overlay/035
> > index f36c1e10..c0aae935 100755
> > --- a/tests/overlay/035
> > +++ b/tests/overlay/035
> > @@ -55,7 +55,7 @@ mkdir -p $lowerdir1 $lowerdir2 $upperdir $workdir
> >  $MOUNT_PROG -t overlay -o"lowerdir=$lowerdir2:$lowerdir1" \
> >                       $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT
> >  touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
> > -_scratch_remount rw 2>&1 | _filter_ro_mount
> > +$MOUNT_PROG -o remount,rw $SCRATCH_MNT 2>&1 | _filter_ro_mount
> >  $UMOUNT_PROG $SCRATCH_MNT
> >
> >  # Make workdir immutable to prevent workdir re-create on mount
> > --
> > 2.18.1
> >



-- 
Thanks,

Steve
