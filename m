Received: from mail-qk1-f194.google.com ([209.85.222.194]:43969 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeIZAoX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Sep 2018 20:44:23 -0400
Received: by mail-qk1-f194.google.com with SMTP id v18-v6so4551117qka.10
        for <fstests@vger.kernel.org>; Tue, 25 Sep 2018 11:35:33 -0700 (PDT)
Date: Tue, 25 Sep 2018 15:35:28 -0300
From: Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?=
        <ernesto.mnd.fernandez@gmail.com>
Subject: Re: [PATCH v2] fstests: add support for hfsplus
Message-ID: <20180925183528.wgsw6muqd24ul6es@eaf>
References: <20180924214352.7fjpxbcnxpugnoms@eaf>
 <CAOQ4uxibAJiKrBHV3diRoAqrqTbkNmknzbWv8VnOdGMwEogcWA@mail.gmail.com>
 <20180925175805.2sjvygawho4d75ft@eaf>
 <CAOQ4uxh1BnN_-rqkr613ftot6TNc6LxVZ2KY-VwXMhG+yaEHPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh1BnN_-rqkr613ftot6TNc6LxVZ2KY-VwXMhG+yaEHPg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Eryu Guan <guaneryu@gmail.com>, Eric Sandeen <sandeen@sandeen.net>, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 25, 2018 at 09:12:03PM +0300, Amir Goldstein wrote:
> On Tue, Sep 25, 2018 at 8:58 PM Ernesto A. Fern=C3=A1ndez
> <ernesto.mnd.fernandez@gmail.com> wrote:
> >
> > On Tue, Sep 25, 2018 at 08:57:58AM +0300, Amir Goldstein wrote:
> > > On Tue, Sep 25, 2018 at 12:44 AM Ernesto A. Fern=C3=A1ndez
> > > <ernesto.mnd.fernandez@gmail.com> wrote:
> > > >
> > > > Running tests on hfsplus requires patched versions of the mkfs an=
d fsck
> > > > tools [1] that support filesystems smaller than the device.
> > >
> > > That's not accurate, is it? Wouldn't it be more accurate to say tha=
t the patched
> > > tools are required to run the _scratch_mkfs_sized tests?
> >
> > I set this up to call _fatal early if the tools are not the patched
> > versions.
> >
> > Using -X on mkfs.hfsplus forces the size to be a whole number of bloc=
ks,
> > and using -X on fsck makes it work under that assumption.  This is br=
iefly
> > explained in the patched man page for the tools.
> >
> > It's a workaround needed because hfsplus only stores the number of
> > allocation blocks in the volume header.  If the device size is not a
> > multiple of the block size, the backup header will be past the end, a=
nd
> > fsck will take that as corruption.
> >
> > Of course I could let the patched fsck use the -X flag by default.  B=
ut
> > that could be dangerous if somebody accidentally uses it to check an
> > important filesystem.
> >
> > >
> > > >
> > > > [1] https://github.com/eafer/hfsprogs-linux.git
> > > >
> > > > Signed-off-by: Ernesto A. Fern=C3=A1ndez <ernesto.mnd.fernandez@g=
mail.com>
> > > > ---
> > > >  common/config | 10 ++++++++++
> > > >  common/rc     | 15 ++++++++++++++-
> > > >  2 files changed, 24 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/common/config b/common/config
> > > > index 1ba8d96c..315f8b1e 100644
> > > > --- a/common/config
> > > > +++ b/common/config
> > > > @@ -229,6 +229,7 @@ case "$HOSTOS" in
> > > >         export MKFS_CIFS_PROG=3D"false"
> > > >         export MKFS_OVERLAY_PROG=3D"false"
> > > >         export MKFS_REISER4_PROG=3D$(type -P mkfs.reiser4)
> > > > +       export MKFS_HFSPLUS_PROG=3D$(type -P mkfs.hfsplus)
> > > >         export E2FSCK_PROG=3D$(type -P e2fsck)
> > > >         export TUNE2FS_PROG=3D$(type -P tune2fs)
> > > >         export FSCK_OVERLAY_PROG=3D$(type -P fsck.overlay)
> > > > @@ -313,6 +314,9 @@ _mount_opts()
> > > >         ubifs)
> > > >                 export MOUNT_OPTIONS=3D$UBIFS_MOUNT_OPTIONS
> > > >                 ;;
> > > > +       hfsplus)
> > > > +               export MOUNT_OPTIONS=3D$HFSPLUS_MOUNT_OPTIONS
> > > > +               ;;
> > > >         *)
> > > >                 ;;
> > > >         esac
> > > > @@ -380,6 +384,9 @@ _mkfs_opts()
> > > >         f2fs)
> > > >                 export MKFS_OPTIONS=3D"$F2FS_MKFS_OPTIONS"
> > > >                 ;;
> > > > +       hfsplus)
> > > > +               export MKFS_OPTIONS=3D$HFSPLUS_MKFS_OPTIONS
> > > > +               ;;
> > > >         *)
> > > >                 ;;
> > > >         esac
> > > > @@ -397,6 +404,9 @@ _fsck_opts()
> > > >         f2fs)
> > > >                 export FSCK_OPTIONS=3D""
> > > >                 ;;
> > > > +       hfsplus)
> > > > +               export FSCK_OPTIONS=3D"-nX"
> > > > +               ;;
> > > >         *)
> > > >                 export FSCK_OPTIONS=3D"-n"
> > > >                 ;;
> > > > diff --git a/common/rc b/common/rc
> > > > index d5bb1fee..a843e9f6 100644
> > > > --- a/common/rc
> > > > +++ b/common/rc
> > > > @@ -158,6 +158,12 @@ case "$FSTYP" in
> > > >      ubifs)
> > > >         [ "$UBIUPDATEVOL_PROG" =3D "" ] && _fatal "ubiupdatevol n=
ot found"
> > > >         ;;
> > > > +    hfsplus)
> > > > +       [ "$MKFS_HFSPLUS_PROG" =3D "" ] && _fatal "mkfs.hfsplus n=
ot found"
> > > > +       mkfs.hfsplus -X |& grep "invalid" &&
> > > > +               _fatal "A patched version of mkfs.hfsplus is requ=
ired:" \
> > > > +                      "https://github.com/eafer/hfsprogs-linux.g=
it"
> > >
> > > Why fatal and not just notrun the _scratch_mkfs_sized tests if no -=
X support?
> > > Must all tests run with mkfs -X and fsck -X??
> >
> > I always use -X on mkfs so the tests will complain if the size of the
> > device is not a whole number of blocks.  Otherwise the tests would la=
ter
> > fail on fsck.
> >
> > Maybe I should check for -X support when setting the FSCK_OPTIONS, an=
d in
> > _scratch_mkfs()?  Then _fatal would not be necessary.
>=20
> I don't mind myself. If nobody has objections to support hfsplus only w=
ith
> patched tools that is a valid option.
>=20
> >
> > >
> > > > +       ;;
> > > >  esac
> > > >
> > > >  if [ ! -z "$REPORT_LIST" ]; then
> > > > @@ -746,6 +752,10 @@ _scratch_mkfs()
> > > >                 mkfs_cmd=3D"yes | $MKFS_PROG -t $FSTYP --"
> > > >                 mkfs_filter=3D"grep -v -e ^mkfs\.ocfs2"
> > > >                 ;;
> > > > +       hfsplus)
> > > > +               mkfs_cmd=3D"yes | $MKFS_PROG -t $FSTYP -- -X"
> > >
> > > -X here seems like a typo?
> >
> > This is so the tests will complain if the device size is not a multip=
le
> > of the block size.  I think I explained it in the patched man page fo=
r
> > mkfs.hfsplus, but it may be better to put a comment here.
> >
>=20
> Comment is a good idea, but -X after -- ? shouldn't all options
> come before --?

I think the generic mkfs program passes everything after -- to
mkfs.fstype.  I was following what ext2 does above.

>=20
> Thanks,
> Amir.
