Received: from mail-pf1-f194.google.com ([209.85.210.194]:37628 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfDFMCO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 6 Apr 2019 08:02:14 -0400
Date: Sat, 6 Apr 2019 20:02:07 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/048: amend property validation cases
Message-ID: <20190406120207.GG2824@desktop>
References: <20190403165419.12666-1-anand.jain@oracle.com>
 <20190403170437.14448-1-anand.jain@oracle.com>
 <7de2d0fd-e777-2bec-5731-15ba2f2af4f2@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7de2d0fd-e777-2bec-5731-15ba2f2af4f2@suse.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Nikolay Borisov <nborisov@suse.com>, Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 05, 2019 at 04:21:10PM +0300, Nikolay Borisov wrote:
>=20
>=20
> On 3.04.19 =D0=B3. 20:04 =D1=87., Anand Jain wrote:
> > Add more property validation cases which are fixed by the patches [1]
> >  [1]
> >   btrfs: fix vanished compression property after failed set
> >   btrfs: fix zstd compression parameter
> >=20
> > Signed-off-by: Anand Jain <anand.jain@oracle.com>
>=20
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Thanks for the test and the review!

But this looks like a targeted regression test that may fail an existing
test. It's better to write a new test for this.

Thanks,
Eryu

>=20
> > ---
> > v2: correct kernel patch titles in the test header and change log
> >=20
> >  tests/btrfs/048     | 23 +++++++++++++++++++++++
> >  tests/btrfs/048.out | 16 ++++++++++++++++
> >  2 files changed, 39 insertions(+)
> >=20
> > diff --git a/tests/btrfs/048 b/tests/btrfs/048
> > index 588219579cc6..f6de0b8ca8b1 100755
> > --- a/tests/btrfs/048
> > +++ b/tests/btrfs/048
> > @@ -6,6 +6,9 @@
> >  #
> >  # Btrfs properties test. The btrfs properties feature was introduced=
 in the
> >  # linux kernel 3.14.
> > +# Fails without the kernel patches:
> > +#  btrfs: fix vanished compression property after failed set
> > +#  btrfs: fix zstd compression parameter
> >  #
> >  seq=3D`basename $0`
> >  seqres=3D$RESULT_DIR/$seq
> > @@ -34,6 +37,7 @@ _supported_os Linux
> >  _require_test
> >  _require_scratch
> >  _require_btrfs_command "property"
> > +_require_btrfs_command inspect-internal dump-super
> > =20
> >  send_files_dir=3D$TEST_DIR/btrfs-test-$seq
> > =20
> > @@ -203,5 +207,24 @@ $BTRFS_UTIL_PROG property get $SCRATCH_MNT/sv1 c=
ompression
> >  touch $SCRATCH_MNT/sv1/file2
> >  $BTRFS_UTIL_PROG property get $SCRATCH_MNT/sv1/file2 compression
> > =20
> > +echo -e "\nTesting argument validation, should fail"
> > +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz' | _filte=
r_scratch
> > +echo "***"
> > +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli' | _filt=
er_scratch
> > +echo "***"
> > +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zst' | _filt=
er_scratch
> > +
> > +echo -e "\nTesting if property is persistent across failed validatio=
n"
> > +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lzo'
> > +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'zli' | _filt=
er_scratch
> > +$BTRFS_UTIL_PROG property get $SCRATCH_MNT compression
> > +
> > +echo -e "\nTesting generation is unchanged after failed validation"
> > +$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> > +$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep '^g=
eneration'
> > +$BTRFS_UTIL_PROG property set $SCRATCH_MNT compression 'lz' | _filte=
r_scratch
> > +$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> > +$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep '^g=
eneration'
> > +
> >  status=3D0
> >  exit
> > diff --git a/tests/btrfs/048.out b/tests/btrfs/048.out
> > index 3e4e3d28950a..00f39bc01227 100644
> > --- a/tests/btrfs/048.out
> > +++ b/tests/btrfs/048.out
> > @@ -76,3 +76,19 @@ compression=3Dzlib
> >  Testing subvolume property inheritance
> >  compression=3Dlzo
> >  compression=3Dlzo
> > +
> > +Testing argument validation, should fail
> > +ERROR: failed to set compression for /mnt/scratch: Invalid argument
> > +***
> > +ERROR: failed to set compression for /mnt/scratch: Invalid argument
> > +***
> > +ERROR: failed to set compression for /mnt/scratch: Invalid argument
> > +
> > +Testing if property is persistent across failed validation
> > +ERROR: failed to set compression for /mnt/scratch: Invalid argument
> > +compression=3Dlzo
> > +
> > +Testing generation is unchanged after failed validation
> > +generation		7
> > +ERROR: failed to set compression for /mnt/scratch: Invalid argument
> > +generation		7
> >=20
