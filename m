Received: from mail-pl1-f193.google.com ([209.85.214.193]:46544 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbeKTNgK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Nov 2018 08:36:10 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so237976ply.13
        for <fstests@vger.kernel.org>; Mon, 19 Nov 2018 19:09:15 -0800 (PST)
Date: Tue, 20 Nov 2018 11:09:08 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v2] fstest: CrashMonkey tests ported to xfstest Inbox x
Message-ID: <20181120030908.GI3889@desktop>
References: <CA+EzBbDr7rxN1ptJKd5FOLQFxLQSRnvEod6+xvR4A6pFuG07fQ@mail.gmail.com>
 <CA+EzBbDKZzW++xuzL3oefmbEAY=_65L_ux_V7a_6tYoXuMZpsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+EzBbDKZzW++xuzL3oefmbEAY=_65L_ux_V7a_6tYoXuMZpsQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Dave Chinner <david@fromorbit.com>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>, Theodore Ts'o <tytso@mit.edu>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
List-ID: <fstests@vger.kernel.org>

On Fri, Nov 16, 2018 at 01:33:02PM -0600, Jayashree Mohan wrote:
> Hi all,
>=20
> This is a gentle reminder to review the patch porting the first set of
> CrashMonkey tests to xfstest. Do let me know if this patch requires
> any correction, so that I can incorporate them and send out all
> patches as soon as possible.

Sorry for the late review again! As we talked in private mails,
hopefully I'll do full review in this week, and it'll be very helpful if
you could send a former patch without line-damages so I can apply it and
actually run the test more easily.

I attached the 'quick review' from our private email so others could see
the review comments.

Thanks,
Eryu


On Sun, Nov 18, 2018 at 09:07:42AM -0600, Vijaychidambaram Velayudhan Pil=
lai wrote:
> Hi Eryu,
>=20
> Could we please get your comments on the updated patch? We=E2=80=99d be=
 happy to change
> the patch as required.=C2=A0

Sorry for the late review! As it's a relatively big patch and needs more
time to do careful review, and recently I don't have much time on
review..  Hopefully I'll get it done in next week.

But after a very quick glance, overall it looks much better now. But I
noticed that the patch still has some un-addressed review comments, for
example, there're still some wrapped-lines (perhaps your mail client is
misconfigured?) and the indention is still spaces not tab, and it'd be
better to create fs with 256MB in size (as I suggested in my previous
review comments, because btrfs creates fs in mixed mode if fs size is
smaller than 256MB).

Some other minor issues inline.

>=20
> On Fri, Nov 16, 2018 at 1:33 PM Jayashree Mohan <jayashree2912@gmail.co=
m>
> wrote:
>=20
>     Hi all,
>=20
>     This is a gentle reminder to review the patch porting the first set=
 of
>     CrashMonkey tests to xfstest. Do let me know if this patch requires
>     any correction, so that I can incorporate them and send out all
>     patches as soon as possible.
>=20
>     > Here is the new patch porting the first set of CrashMonkey tests =
to
>     > xfstests. This patch batches 37 CrashMonkey tests, and tests them=
 on a
>     > file system of size 200MB. Each sub test is also followed by fsck=
 to
>     > check for metadata inconsistencies. This test is added to a new g=
roup
>     > - regress.
>     > Let me know if this looks good to you.

Would you please write a former patch with detailed commit log and a
Signed-off-by tag? And you could just send out the patch with "git
send-email" command, so the wrapped-line issue should be fixed.

>     >
>     > ---
>     >
>     > diff --git a/tests/generic/517 b/tests/generic/517
>     > new file mode 100755
>     > index 0000000..3e92fbb
>     > --- /dev/null
>     > +++ b/tests/generic/517
>     > @@ -0,0 +1,183 @@
>     > +#! /bin/bash
>     > +# SPDX-License-Identifier: GPL-2.0
>     > +# Copyright (c) 2018 The University of Texas at Austin.=C2=A0 Al=
l Rights
>     Reserved.

Wrapped line.

>     > +#
>     > +# FS QA Test 517-link
>     > +#
>     > +# Test case created by CrashMonkey
>     > +#
>     > +# Test if we create a hard link to a file and persist either of =
the
>     > files, all the names persist.

Same here.

>     > +#
>     > +seq=3D`basename $0`
>     > +seqres=3D$RESULT_DIR/$seq
>     > +echo "QA output created by $seq"
>     > +
>     > +here=3D`pwd`
>     > +tmp=3D/tmp/$$
>     > +status=3D1=C2=A0 =C2=A0 # failure is the default!
>     > +trap "_cleanup; exit \$status" 0 1 2 3 15
>     > +
>     > +_cleanup()
>     > +{
>     > +=C2=A0 =C2=A0 _cleanup_flakey
>     > +=C2=A0 =C2=A0 cd /
>     > +=C2=A0 =C2=A0 rm -f $tmp.*
>     > +}
>     > +
>     > +# get standard environment, filters and checks
>     > +. ./common/rc
>     > +. ./common/filter
>     > +. ./common/dmflakey
>     > +
>     > +# 200MB in byte
>     > +fssize=3D$((2**20 * 200))
>     > +
>     > +# remove previous $seqres.full before test
>     > +rm -f $seqres.full
>     > +
>     > +# real QA test starts here
>     > +_supported_fs generic
>     > +_supported_os Linux
>     > +_require_scratch_nocheck
>     > +_require_dm_target flakey
>     > +
>     > +# initialize scratch device
>     > +_scratch_mkfs_sized $fssize >> $seqres.full 2>&1
>     > +_require_metadata_journaling $SCRATCH_DEV
>     > +_init_flakey
>     > +
>     > +stat_opt=3D'-c "blocks: %b size: %s inode: %i links: %h"'
>     > +before=3D""
>     > +after=3D""
>     > +
>     > +# Using _scratch_mkfs instead of cleaning up the=C2=A0 working d=
irectory,
>     > +# adds about 10 seconds of delay in total for the 37 tests.
>     > +_clean_dir()

Name local functions without the leading underscore.

>     > +{
>     > +=C2=A0 =C2=A0 _mount_flakey
>     > +=C2=A0 =C2=A0 rm -rf $SCRATCH_MNT/*
>     > +=C2=A0 =C2=A0 sync
>     > +=C2=A0 =C2=A0 _unmount_flakey
>     > +}
>     > +
>     > +_check_consistency()
>     > +{
>     > +=C2=A0 =C2=A0 _flakey_drop_and_remount | tee -a $seqres.full
>     > +
>     > +=C2=A0 =C2=A0 if [ -f $1 ]; then
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 after=3D`stat "$stat_opt" $1`
>     > +=C2=A0 =C2=A0 fi
>     > +
>     > +=C2=A0 =C2=A0 if [ "$before" !=3D "$after" ] && [ $2 -ne 1 ]; th=
en
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "Before: $before"
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo "After: $after"
>     > +=C2=A0 =C2=A0 fi
>     > +
>     > +=C2=A0 =C2=A0 _unmount_flakey
>     > +=C2=A0 =C2=A0 _check_scratch_fs $FLAKEY_DEV
>     > +=C2=A0 =C2=A0 [ $? -ne 0 ] && _fatal "fsck failed"
>     > +}
>     > +
>     > +# create a hard link $2 to file $1, and fsync $3, followed by po=
wer-cut
>     > +test_link_fsync()
>     > +{
>     > +=C2=A0 =C2=A0 local sibling=3D0
>     > +=C2=A0 =C2=A0 before=3D""
>     > +=C2=A0 =C2=A0 after=3D""
>     > +=C2=A0 =C2=A0 src=3D$SCRATCH_MNT/$1
>     > +=C2=A0 =C2=A0 dest=3D$SCRATCH_MNT/$2

"src" and "dest" should be declared as "local" as well?

>     > +
>     > +=C2=A0 =C2=A0 if [ "$3" =3D=3D "./" ]; then
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fsync=3D$SCRATCH_MNT
>     > +=C2=A0 =C2=A0 else
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fsync=3D$SCRATCH_MNT/$3
>     > +=C2=A0 =C2=A0 fi
>     > +
>     > +=C2=A0 =C2=A0 echo -ne "\n=3D=3D=3D link $src $dest=C2=A0 with f=
sync $fsync =3D=3D=3D\n" |
>     _filter_scratch

Wrapped line.

>     > +=C2=A0 =C2=A0 _mount_flakey
>     > +
>     > +=C2=A0 =C2=A0 # Now execute the workload
>     > +=C2=A0 =C2=A0 # Create the directory in which the source and des=
tination files
>     > +=C2=A0 =C2=A0 # will be created
>     > +=C2=A0 =C2=A0 mkdir -p "${src%/*}"
>     > +=C2=A0 =C2=A0 mkdir -p "${dest%/*}"
>     > +=C2=A0 =C2=A0 touch $src
>     > +=C2=A0 =C2=A0 ln $src $dest
>     > +
>     > +=C2=A0 =C2=A0 # If the file being persisted is a sibling, create=
 it first
>     > +=C2=A0 =C2=A0 if [ ! -f $fsync ]; then
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sibling=3D1
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 touch $fsync
>     > +=C2=A0 =C2=A0 fi
>     > +
>     > +=C2=A0 =C2=A0 $XFS_IO_PROG -c "fsync" $fsync
>     > +
>     > +=C2=A0 =C2=A0 if [ $sibling -ne 1 ]; then
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 before=3D`stat "$stat_opt" $src`
>     > +=C2=A0 =C2=A0 fi
>     > +
>     > +=C2=A0 =C2=A0 _check_consistency $src $sibling
>     > +=C2=A0 =C2=A0 _clean_dir
>     > +}
>     > +
>     > +# create a hard link $2 to file $1, and sync, followed by power-=
cut
>     > +test_link_sync()
>     > +{
>     > +=C2=A0 =C2=A0 src=3D$SCRATCH_MNT/$1
>     > +=C2=A0 =C2=A0 dest=3D$SCRATCH_MNT/$2
>     > +=C2=A0 =C2=A0 before=3D""
>     > +=C2=A0 =C2=A0 after=3D""
>     > +=C2=A0 =C2=A0 echo -ne "\n=3D=3D=3D link $src $dest=C2=A0 with s=
ync =3D=3D=3D\n" | _filter_scratch
>     > +=C2=A0 =C2=A0 _mount_flakey
>     > +
>     > +=C2=A0 =C2=A0 # now execute the workload
>     > +=C2=A0 =C2=A0 # Create the directory in which the source and des=
tination files
>     > +=C2=A0 =C2=A0 # will be created
>     > +=C2=A0 =C2=A0 mkdir -p "${src%/*}"
>     > +=C2=A0 =C2=A0 mkdir -p "${dest%/*}"
>     > +=C2=A0 =C2=A0 touch $src
>     > +=C2=A0 =C2=A0 ln $src $dest
>     > +=C2=A0 =C2=A0 sync
>     > +=C2=A0 =C2=A0 before=3D`stat "$stat_opt" $src`
>     > +
>     > +=C2=A0 =C2=A0 _check_consistency $src 0
>     > +=C2=A0 =C2=A0 _clean_dir
>     > +}
>     > +
>     > +# Create different combinations to run the link test
>     > +# Group 0: Both files within root directory
>     > +file_names[0]=3D"foo bar"
>     > +fsync_names[0]=3D"./ foo bar"
>     > +
>     > +# Group 1: Create hard link in a sub directory
>     > +file_names[1]=3D"foo A/bar"
>     > +fsync_names[1]=3D"./ foo bar A A/bar A/foo"
>     > +
>     > +# Group 2: Create hard link in parent directory
>     > +file_names[2]=3D"A/foo bar"
>     > +fsync_names[2]=3D"./ foo bar A A/bar A/foo"
>     > +
>     > +# Group 3: Both files within a directory other than root
>     > +file_names[3]=3D"A/foo A/bar"
>     > +fsync_names[3]=3D"./ A A/bar A/foo"
>     > +
>     > +#Group 4: Exercise name reuse : Link file in sub-directory
>     > +file_names[4]=3D"bar A/bar"
>     > +fsync_names[4]=3D"./ foo bar A A/bar A/foo"
>     > +
>     > +#Group 5: Exercise name reuse : Link file in parent directory
>     > +file_names[5]=3D"A/bar bar"
>     > +fsync_names[5]=3D"./ foo bar A A/bar A/foo"
>     > +
>     > +for ((test_group=3D0; test_group<6; test_group++)); do
>     > +=C2=A0 =C2=A0 for file in ${fsync_names[$test_group]}; do
>     > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_link_fsync ${file_names[$test_g=
roup]} $file
>     > +=C2=A0 =C2=A0 done
>     > +=C2=A0 =C2=A0 test_link_sync ${file_names[$test_group]}
>     > +done
>     > +
>     > +# success, all done
>     > +status=3D0
>     > +exit
>     > diff --git a/tests/generic/517.out b/tests/generic/517.out
>     > new file mode 100644
>     > index 0000000..b0d75a1
>     > --- /dev/null
>     > +++ b/tests/generic/517.out
>     > @@ -0,0 +1,75 @@
>     > +QA output created by 517
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/bar=C2=A0 with fsync =
SCRATCH_MNT =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/bar=C2=A0 with fsync =
SCRATCH_MNT/foo =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/bar=C2=A0 with fsync =
SCRATCH_MNT/bar =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/bar=C2=A0 with sync =3D=
=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar=C2=A0 with fsyn=
c SCRATCH_MNT =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar=C2=A0 with fsyn=
c SCRATCH_MNT/foo =3D
>     =3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar=C2=A0 with fsyn=
c SCRATCH_MNT/bar =3D
>     =3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar=C2=A0 with fsyn=
c SCRATCH_MNT/A =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar=C2=A0 with fsyn=
c SCRATCH_MNT/A/bar
>     =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar=C2=A0 with fsyn=
c SCRATCH_MNT/A/foo
>     =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar=C2=A0 with sync=
 =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar=C2=A0 with fsyn=
c SCRATCH_MNT =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar=C2=A0 with fsyn=
c SCRATCH_MNT/foo =3D
>     =3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar=C2=A0 with fsyn=
c SCRATCH_MNT/bar =3D
>     =3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar=C2=A0 with fsyn=
c SCRATCH_MNT/A =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar=C2=A0 with fsyn=
c SCRATCH_MNT/A/bar
>     =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar=C2=A0 with fsyn=
c SCRATCH_MNT/A/foo
>     =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar=C2=A0 with sync=
 =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar=C2=A0 with fs=
ync SCRATCH_MNT =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar=C2=A0 with fs=
ync SCRATCH_MNT/A =3D
>     =3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar=C2=A0 with fs=
ync SCRATCH_MNT/A/
>     bar =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar=C2=A0 with fs=
ync SCRATCH_MNT/A/
>     foo =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar=C2=A0 with sy=
nc =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar=C2=A0 with fsyn=
c SCRATCH_MNT =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar=C2=A0 with fsyn=
c SCRATCH_MNT/foo =3D
>     =3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar=C2=A0 with fsyn=
c SCRATCH_MNT/bar =3D
>     =3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar=C2=A0 with fsyn=
c SCRATCH_MNT/A =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar=C2=A0 with fsyn=
c SCRATCH_MNT/A/bar
>     =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar=C2=A0 with fsyn=
c SCRATCH_MNT/A/foo
>     =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar=C2=A0 with sync=
 =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar=C2=A0 with fsyn=
c SCRATCH_MNT =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar=C2=A0 with fsyn=
c SCRATCH_MNT/foo =3D
>     =3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar=C2=A0 with fsyn=
c SCRATCH_MNT/bar =3D
>     =3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar=C2=A0 with fsyn=
c SCRATCH_MNT/A =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar=C2=A0 with fsyn=
c SCRATCH_MNT/A/bar
>     =3D=3D=3D
>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar=C2=A0 with fsyn=
c SCRATCH_MNT/A/foo
>     =3D=3D=3D

More warpped lines in .out file.

>     > +
>     > +=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar=C2=A0 with sync=
 =3D=3D=3D
>     > diff --git a/tests/generic/group b/tests/generic/group
>     > index 47de978..3e81ae8 100644
>     > --- a/tests/generic/group
>     > +++ b/tests/generic/group
>     > @@ -519,3 +519,4 @@
>     >=C2=A0 514 auto quick clone
>     >=C2=A0 515 auto quick clone
>     >=C2=A0 516 auto quick dedupe clone
>     > +517 regress

I think we could just add it to 'auto' group for now. The 'regress'
group is still under discussion, and we could do the conversion in a
separate patchset when the decision is made.

Thanks!

Eryu
>=20
> --
> Thanks,
> Vijay Chidambaram
> http://www.cs.utexas.edu/~vijay/
