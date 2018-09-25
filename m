Received: from mail-yw1-f65.google.com ([209.85.161.65]:42552 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIZAU6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Sep 2018 20:20:58 -0400
Received: by mail-yw1-f65.google.com with SMTP id h134-v6so6529547ywc.9
        for <fstests@vger.kernel.org>; Tue, 25 Sep 2018 11:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180924214352.7fjpxbcnxpugnoms@eaf> <CAOQ4uxibAJiKrBHV3diRoAqrqTbkNmknzbWv8VnOdGMwEogcWA@mail.gmail.com>
 <20180925175805.2sjvygawho4d75ft@eaf>
In-Reply-To: <20180925175805.2sjvygawho4d75ft@eaf>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 25 Sep 2018 21:12:03 +0300
Message-ID: <CAOQ4uxh1BnN_-rqkr613ftot6TNc6LxVZ2KY-VwXMhG+yaEHPg@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: add support for hfsplus
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: fstests-owner@vger.kernel.org
To: ernesto.mnd.fernandez@gmail.com
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, Eric Sandeen <sandeen@sandeen.net>, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 25, 2018 at 8:58 PM Ernesto A. Fern=C3=A1ndez
<ernesto.mnd.fernandez@gmail.com> wrote:
>
> On Tue, Sep 25, 2018 at 08:57:58AM +0300, Amir Goldstein wrote:
> > On Tue, Sep 25, 2018 at 12:44 AM Ernesto A. Fern=C3=A1ndez
> > <ernesto.mnd.fernandez@gmail.com> wrote:
> > >
> > > Running tests on hfsplus requires patched versions of the mkfs and fs=
ck
> > > tools [1] that support filesystems smaller than the device.
> >
> > That's not accurate, is it? Wouldn't it be more accurate to say that th=
e patched
> > tools are required to run the _scratch_mkfs_sized tests?
>
> I set this up to call _fatal early if the tools are not the patched
> versions.
>
> Using -X on mkfs.hfsplus forces the size to be a whole number of blocks,
> and using -X on fsck makes it work under that assumption.  This is briefl=
y
> explained in the patched man page for the tools.
>
> It's a workaround needed because hfsplus only stores the number of
> allocation blocks in the volume header.  If the device size is not a
> multiple of the block size, the backup header will be past the end, and
> fsck will take that as corruption.
>
> Of course I could let the patched fsck use the -X flag by default.  But
> that could be dangerous if somebody accidentally uses it to check an
> important filesystem.
>
> >
> > >
> > > [1] https://github.com/eafer/hfsprogs-linux.git
> > >
> > > Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@gmail=
.com>
> > > ---
> > >  common/config | 10 ++++++++++
> > >  common/rc     | 15 ++++++++++++++-
> > >  2 files changed, 24 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/common/config b/common/config
> > > index 1ba8d96c..315f8b1e 100644
> > > --- a/common/config
> > > +++ b/common/config
> > > @@ -229,6 +229,7 @@ case "$HOSTOS" in
> > >         export MKFS_CIFS_PROG=3D"false"
> > >         export MKFS_OVERLAY_PROG=3D"false"
> > >         export MKFS_REISER4_PROG=3D$(type -P mkfs.reiser4)
> > > +       export MKFS_HFSPLUS_PROG=3D$(type -P mkfs.hfsplus)
> > >         export E2FSCK_PROG=3D$(type -P e2fsck)
> > >         export TUNE2FS_PROG=3D$(type -P tune2fs)
> > >         export FSCK_OVERLAY_PROG=3D$(type -P fsck.overlay)
> > > @@ -313,6 +314,9 @@ _mount_opts()
> > >         ubifs)
> > >                 export MOUNT_OPTIONS=3D$UBIFS_MOUNT_OPTIONS
> > >                 ;;
> > > +       hfsplus)
> > > +               export MOUNT_OPTIONS=3D$HFSPLUS_MOUNT_OPTIONS
> > > +               ;;
> > >         *)
> > >                 ;;
> > >         esac
> > > @@ -380,6 +384,9 @@ _mkfs_opts()
> > >         f2fs)
> > >                 export MKFS_OPTIONS=3D"$F2FS_MKFS_OPTIONS"
> > >                 ;;
> > > +       hfsplus)
> > > +               export MKFS_OPTIONS=3D$HFSPLUS_MKFS_OPTIONS
> > > +               ;;
> > >         *)
> > >                 ;;
> > >         esac
> > > @@ -397,6 +404,9 @@ _fsck_opts()
> > >         f2fs)
> > >                 export FSCK_OPTIONS=3D""
> > >                 ;;
> > > +       hfsplus)
> > > +               export FSCK_OPTIONS=3D"-nX"
> > > +               ;;
> > >         *)
> > >                 export FSCK_OPTIONS=3D"-n"
> > >                 ;;
> > > diff --git a/common/rc b/common/rc
> > > index d5bb1fee..a843e9f6 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -158,6 +158,12 @@ case "$FSTYP" in
> > >      ubifs)
> > >         [ "$UBIUPDATEVOL_PROG" =3D "" ] && _fatal "ubiupdatevol not f=
ound"
> > >         ;;
> > > +    hfsplus)
> > > +       [ "$MKFS_HFSPLUS_PROG" =3D "" ] && _fatal "mkfs.hfsplus not f=
ound"
> > > +       mkfs.hfsplus -X |& grep "invalid" &&
> > > +               _fatal "A patched version of mkfs.hfsplus is required=
:" \
> > > +                      "https://github.com/eafer/hfsprogs-linux.git"
> >
> > Why fatal and not just notrun the _scratch_mkfs_sized tests if no -X su=
pport?
> > Must all tests run with mkfs -X and fsck -X??
>
> I always use -X on mkfs so the tests will complain if the size of the
> device is not a whole number of blocks.  Otherwise the tests would later
> fail on fsck.
>
> Maybe I should check for -X support when setting the FSCK_OPTIONS, and in
> _scratch_mkfs()?  Then _fatal would not be necessary.

I don't mind myself. If nobody has objections to support hfsplus only with
patched tools that is a valid option.

>
> >
> > > +       ;;
> > >  esac
> > >
> > >  if [ ! -z "$REPORT_LIST" ]; then
> > > @@ -746,6 +752,10 @@ _scratch_mkfs()
> > >                 mkfs_cmd=3D"yes | $MKFS_PROG -t $FSTYP --"
> > >                 mkfs_filter=3D"grep -v -e ^mkfs\.ocfs2"
> > >                 ;;
> > > +       hfsplus)
> > > +               mkfs_cmd=3D"yes | $MKFS_PROG -t $FSTYP -- -X"
> >
> > -X here seems like a typo?
>
> This is so the tests will complain if the device size is not a multiple
> of the block size.  I think I explained it in the patched man page for
> mkfs.hfsplus, but it may be better to put a comment here.
>

Comment is a good idea, but -X after -- ? shouldn't all options
come before --?

Thanks,
Amir.
