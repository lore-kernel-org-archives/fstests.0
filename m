Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:1674 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726403AbeKGIZ4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Nov 2018 03:25:56 -0500
Date: Wed, 7 Nov 2018 09:57:45 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
Message-ID: <20181106225745.GW6311@dastard>
References: <CA+EzBbB5t5bSZ0hB6Y1jkxTgOLOv809Jbbcx7w5eK_XS_FPG7w@mail.gmail.com>
 <20181104163826.GH12788@desktop>
 <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
 <20181105052217.GT6311@dastard>
 <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Theodore Ts'o <tytso@mit.edu>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Nov 05, 2018 at 02:16:57PM -0600, Jayashree Mohan wrote:
> Hi Dave,
>=20
> Thanks for the comments.=20
>=20
> >> +init_end_time=3D$(date +%s.%N)
> >> +init_time_elapsed=3D$(echo "$init_end_time - $init_start_time" | bc=
)=20
> >> +echo "Initialization time =3D $init_time_elapsed" >> $seqres.full
> >=20
> > No timing inside the test, please. The harness times the test
> > execution.
>=20
> Sure, that was meant for the initial evaluation. I=E2=80=99ve removed i=
t now.

Thanks!

>=20
> >=20
> >> +total_time=3D0
> >> +
> >> +_clean_dir()
> >> +{
> >> +	_mount_flakey
> >> +	rm -rf $SCRATCH_MNT/*
> >> +	sync
> >> +	_unmount_flakey
> >> +}
> >=20
> > Why not just _scratch_mkfs?
>=20
> I believe that to _scratch_mkfs, I must first _cleanup dm_flakey.
> If I replace the above snippet by=20
> _cleanup
> _scratch_mkfs
> _init_flakey
>=20
> The time taken for the test goes up by around 10 seconds (due to
> mkfs maybe). So I thought it was sufficient to remove the working
> directory.

Ok. Put that in a comment (comments are for explaining why, not how
or what). :)

Overall the new version looks a lot better. More comments
below.

> diff --git a/tests/generic/517-link b/tests/generic/517-link
> new file mode 100755
> index 0000000..7108300
> --- /dev/null
> +++ b/tests/generic/517-link

Please just use "517" as the test name. At some point it was though
that descriptive names for tests might be useful, but it's turned
out that's not the case and we have just continued to number them.

> @@ -0,0 +1,176 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2018 The University of Texas at Austin.  All Rights Re=
served.
> +#
> +# FS QA Test 517-link
> +#
> +# Test case created by CrashMonkey
> +#
> +# Test if we create a hard link to a file and persist either of the fi=
les, all the names persist.
> +#
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmflakey
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch_nocheck
> +_require_dm_target flakey
> +
> +# initialize scratch device
> +_scratch_mkfs >> $seqres.full 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +
> +stat_opt=3D'-c "blocks: %b size: %s inode: %i links: %h"'
> +before=3D""
> +after=3D""
> +
> +_clean_dir()
> +{
> +	_mount_flakey
> +	rm -rf $SCRATCH_MNT/*
> +	sync
> +	_unmount_flakey
> +}
> +
> +_check_consistency()
> +{
> +	_flakey_drop_and_remount | tee -a $seqres.full
> +=09

Whitespace damage.

> +	if [ -f $1 ]; then
> +		after=3D`stat "$stat_opt" $1`
> +	fi
> +
> +	if [ "$before" !=3D "$after" ] && [ $2 -ne 1 ]; then
> +		echo "Before: $before"=20
> +		echo "After: $after"=09

Whitespace.

Add this to your .vimrc:

" highlight whitespace damage
highlight RedundantSpaces ctermbg=3Dred guibg=3Dred
match RedundantSpaces /\s\+$\| \+\ze\t/


> +	fi
> +
> +	_unmount_flakey
> +	_check_scratch_fs $FLAKEY_DEV
> +	[ $? -ne 0 ] && _fatal "fsck failed"
> +}
> +
> +# create a hard link $2 to file $1, and fsync $3, followed by power-cu=
t
> +test_link_fsync()
> +{
> +	local sibling=3D0
> +	before=3D""
> +	after=3D""
> +	src=3D$SCRATCH_MNT/$1
> +	dest=3D$SCRATCH_MNT/$2
> +=09

Whitespace

> +	if [ "$3" =3D=3D "./" ]; then
> +		fsync=3D$SCRATCH_MNT
> +	else
> +		fsync=3D$SCRATCH_MNT/$3
> +	fi

Why doesn't fsync of $SCRATCH_MNT/./ work?

> +
> +	echo -ne "\n=3D=3D=3D link $src $dest  with fsync $fsync =3D=3D=3D\n"=
 | _filter_scratch
> +	_mount_flakey
> +=09

Whitespace

> +	# now execute the workload
> +	mkdir -p "${src%/*}"

Please explain why this magic directory creation is needed - "now
execute the workload" isn't going to remind me what this does in a
couple of years time.

> +	mkdir -p "${dest%/*}"=20

Whitespace

> +	touch $src
> +	ln $src $dest || _fail "Link creation failed"

No need for _fail here. The error message will end up in the output
and the test will fail the golden output match. That way it will
still run all the other tests.

> +=09

Whitespace

> +	# If the file being persisted is a sibling, create it first
> +	if [ ! -f $fsync ]; then
> +		sibling=3D1
> +		touch $fsync
> +	fi
> +
> +	$XFS_IO_PROG -c "fsync" $fsync
> +	=09

Whitespace

> +	if [ $sibling -ne 1 ]; then
> +		before=3D`stat "$stat_opt" $src`
> +	fi
> +
> +	_check_consistency $src $sibling
> +	_clean_dir
> +}
> +
> +# create a hard link $2 to file $1, and sync, followed by power-cut
> +test_link_sync()
> +{
> +	src=3D$SCRATCH_MNT/$1
> +	dest=3D$SCRATCH_MNT/$2
> +	before=3D""
> +	after=3D""
> +	echo -ne "\n=3D=3D=3D link $src $dest  with sync =3D=3D=3D\n" | _filt=
er_scratch
> +	_mount_flakey
> +=09

Whitespace

> +	# now execute the workload
> +	mkdir -p "${src%/*}"
> +	mkdir -p "${dest%/*}"=20

Whitespace

> +	touch $src
> +	ln $src $dest || _fail "Link creation failed"=09

Whitespace

> +	sync
> +	before=3D`stat "$stat_opt" $src`
> +=09

Whitespace

> +	_check_consistency $src 0
> +	_clean_dir
> +}
> +
> +
> +# Create different combinations to run the link test
> +# Group 0: Both files within root directory
> +file_names[0]=3D"foo bar"
> +fsync_names[0]=3D"./ foo bar"
> +
> +# Group 1: Create hard link in a sub directory
> +file_names[1]=3D"foo A/bar"
> +fsync_names[1]=3D"./ foo bar A A/bar A/foo"
> +
> +# Group 2: Create hard link in parent directory
> +file_names[2]=3D"A/foo bar"
> +fsync_names[2]=3D"./ foo bar A A/bar A/foo"
> +
> +# Group 3: Both files within a directory other than root
> +file_names[3]=3D"A/foo A/bar"
> +fsync_names[3]=3D"./ A A/bar A/foo"
> +
> +#Group 4: Exercise name reuse : Link file in sub-directory
> +file_names[4]=3D"bar A/bar"
> +fsync_names[4]=3D"./ foo bar A A/bar A/foo"
> +
> +#Group 5: Exercise name reuse : Link file in parent directory
> +file_names[5]=3D"A/bar bar"
> +fsync_names[5]=3D"./ foo bar A A/bar A/foo"
> +
> +for ((test_group=3D0; test_group<6; test_group++)); do
> +	for file in ${fsync_names[$test_group]}; do
> +		test_link_fsync ${file_names[$test_group]} $file
> +	done
> +	test_link_sync ${file_names[$test_group]}
> +done=20

Whitespace

> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/generic/517-link.out b/tests/generic/517-link.out
> new file mode 100644
> index 0000000..1f80b27
> --- /dev/null
> +++ b/tests/generic/517-link.out
> @@ -0,0 +1,75 @@
> +QA output created by 517-link
> +
> +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT=
 =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT=
/foo =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT=
/bar =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/bar  with sync =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_M=
NT =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_M=
NT/foo =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_M=
NT/bar =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_M=
NT/A =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_M=
NT/A/bar =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync SCRATCH_M=
NT/A/foo =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with sync =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_M=
NT =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_M=
NT/foo =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_M=
NT/bar =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_M=
NT/A =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_M=
NT/A/bar =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync SCRATCH_M=
NT/A/foo =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with sync =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with fsync SCRATCH=
_MNT =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with fsync SCRATCH=
_MNT/A =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with fsync SCRATCH=
_MNT/A/bar =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with fsync SCRATCH=
_MNT/A/foo =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with sync =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync SCRATCH_M=
NT =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync SCRATCH_M=
NT/foo =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync SCRATCH_M=
NT/bar =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync SCRATCH_M=
NT/A =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync SCRATCH_M=
NT/A/bar =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync SCRATCH_M=
NT/A/foo =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with sync =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync SCRATCH_M=
NT =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync SCRATCH_M=
NT/foo =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync SCRATCH_M=
NT/bar =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync SCRATCH_M=
NT/A =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync SCRATCH_M=
NT/A/bar =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync SCRATCH_M=
NT/A/foo =3D=3D=3D
> +
> +=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with sync =3D=3D=3D
> diff --git a/tests/generic/group b/tests/generic/group
> index 47de978..67e9108 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -519,3 +519,4 @@
>  514 auto quick clone
>  515 auto quick clone
>  516 auto quick dedupe clone
> +517-link quick log
>=20
>=20
>=20

--=20
Dave Chinner
david@fromorbit.com
