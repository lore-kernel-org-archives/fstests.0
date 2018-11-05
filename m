Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:20922 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728918AbeKEOkO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Nov 2018 09:40:14 -0500
Date: Mon, 5 Nov 2018 16:22:17 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
Message-ID: <20181105052217.GT6311@dastard>
References: <CA+EzBbB5t5bSZ0hB6Y1jkxTgOLOv809Jbbcx7w5eK_XS_FPG7w@mail.gmail.com>
 <20181104163826.GH12788@desktop>
 <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Jayashree Mohan <jayashree2912@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Theodore Ts'o <tytso@mit.edu>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Sun, Nov 04, 2018 at 02:21:21PM -0600, Jayashree Mohan wrote:
> Hi Eryu and Filipe,
>=20
> I have incorporated the coding style suggested, and renamed the cleanup=
 function. However, creating a clean fs image after each sub test is resu=
lting in about 10-15s of additional overhead overall. I instead clean up =
the working directory and unmount. The time for the tests varies between =
12-15 seconds.
>=20
> Please find the patch below
>=20
> =E2=80=94
>=20
> diff --git a/tests/generic/517-link b/tests/generic/517-link
> new file mode 100755
> index 0000000..ea5c5b7
> --- /dev/null
> +++ b/tests/generic/517-link
> @@ -0,0 +1,164 @@
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
> +init_start_time=3D$(date +%s.%N)
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
> +init_end_time=3D$(date +%s.%N)
> +init_time_elapsed=3D$(echo "$init_end_time - $init_start_time" | bc)=20
> +echo "Initialization time =3D $init_time_elapsed" >> $seqres.full

No timing inside the test, please. The harness times the test
execution.

> +stat_opt=3D'-c "blocks: %b size: %s inode: %i links: %h"'
> +test_num=3D0

Don't number tests. If we add an extra test, it will completely
break the golden output.

> +total_time=3D0
> +
> +_clean_dir()
> +{
> +	_mount_flakey
> +	rm -rf $SCRATCH_MNT/*
> +	sync
> +	_unmount_flakey
> +}

Why not just _scratch_mkfs?

> +
> +# create a hard link $2 to file $1, and fsync $3, followed by power-cu=
t
> +test_link()
> +{
> +	test_num=3D$((test_num + 1))
> +	local start_time=3D$(date +%s.%N)
> +	local sibling=3D0
> +	local before=3D""
> +	local after=3D""
> +	echo -ne "\n=3D=3D=3D Test $test_num :  link $1 $2 " | _filter_scratc=
h
> +	_mount_flakey
> +=09

Still whitespace damaged.

> +	# now execute the workload
> +	mkdir -p "${1%/*}" && mkdir -p "${2%/*}" && touch "$1"

One line each.=20

> +	ln $1 $2

No checks for failure?

> +=09
> +	if [ -z "$3" ]; then
> +		echo -ne " with sync =3D=3D=3D\n"
> +		sync
> +		before=3D`stat "$stat_opt" $1`
> +	else
> +		echo " with fsync $3 =3D=3D=3D" | _filter_scratch
> +	=09
> +		# If the file being persisted is a sibling, create it first
> +		if [ ! -f $3 ]; then
> +			sibling=3D1
> +			touch $3
> +		fi
> +
> +		$XFS_IO_PROG -c "fsync" $3
> +	=09
> +		if [ $sibling -ne 1 ]; then
> +			before=3D`stat "$stat_opt" $1`
> +		fi
> +	fi

To tell the truth, I'd consider these two separate functions -
test_link_sync() and test_link_fsync(). More below.


> +
> +	_flakey_drop_and_remount | tee -a $seqres.full
> +=09
> +	if [ -f $1 ]; then
> +		after=3D`stat "$stat_opt" $1`
> +	fi
> +
> +	if [ "$before" !=3D "$after" ] && [ $sibling -ne 1 ]; then
> +		echo "Before: $before" | tee -a $seqres.full
> +		echo "After: $after" | tee -a $seqres.full=09
> +	fi

Why tee all the output to $seqres.full? Once the timing info is
removed, it dones't contain anything extra that the normal output
file...

> +
> +	_unmount_flakey
> +	_check_scratch_fs $FLAKEY_DEV
> +	[ $? -ne 0 ] && _fatal "fsck failed"
> +	end_time=3D$(date +%s.%N)
> +	time_elapsed=3D$(echo "$end_time - $start_time" | bc)
> +	echo " Elapsed time : $time_elapsed" >> $seqres.full
> +	total_time=3D$(echo "$total_time + $time_elapsed" | bc)
> +	echo " Total time : $total_time" >> $seqres.full
> +	_clean_dir
> +}
> +
> +# run the link test for different combinations
> +
> +test_start_time=3D$(date +%s.%N)
> +# Group 1: Both files within root directory
> +for file_name in $SCRATCH_MNT $SCRATCH_MNT/foo $SCRATCH_MNT/bar; do
> +	test_link $SCRATCH_MNT/foo $SCRATCH_MNT/bar $file_name
> +done
> +test_link $SCRATCH_MNT/foo $SCRATCH_MNT/bar=20
> +
> +# Group 2: Create hard link in a sub directory
> +for file_name in $SCRATCH_MNT $SCRATCH_MNT/foo $SCRATCH_MNT/bar $SCRAT=
CH_MNT/A $SCRATCH_MNT/A/bar $SCRATCH_MNT/A/foo; do
> +	test_link $SCRATCH_MNT/foo $SCRATCH_MNT/A/bar $file_name
> +done
> +test_link $SCRATCH_MNT/foo $SCRATCH_MNT/A/bar=20

Lines too long.

Basically, this is a two dimensional array of filenames.
Make test_link_fsync() do:

	src=3D$SCRATCH_MNT/$1
	dst=3D$SCRATCH_MNT/$2
	fsync=3D$SCRATCH_MNT/$3

And define your fsync filenames and link destinations names like so
(can't remember bash array notation, so paraphrasing):

# group 1: Both files within root directory
fnames[1]=3D"./ foo bar"
dnames[1]=3D"foo bar"

# group 2: Create hard link in a sub directory
fnames[2]=3D"./ foo bar A A/bar A/foo"
dnames[2]=3D"foo A/bar"

#g3
fnames[3]=3D"./ foo bar A A/bar A/foo"
dnames[3]=3D"A/foo bar"

#g4
fnames[4]=3D"./ A A/bar A/foo"
dnames[4]=3D"A/foo A/bar"

#g5
fnames[5]=3D"./ foo bar A A/bar A/foo"
dnames[5]=3D"bar A/bar"

#g6
fnames[6]=3D"./ foo bar A A/bar A/foo"
dnames[6]=3D"A/bar bar"

for ((i=3D1; i<=3D6; i++)); do
	for f in $fnames[$i]; do
		test_link_fsync $dnames[$i] $f
	done
	test_link_sync $dnames[1]
done

And all this shouty, shouty noise goes away. Much easier to read,
much simpler to maintain.

Cheers,

Dave.
--=20
Dave Chinner
david@fromorbit.com
