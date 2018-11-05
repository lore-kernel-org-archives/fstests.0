Received: from mail-ot1-f66.google.com ([209.85.210.66]:42947 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbeKFFiW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 6 Nov 2018 00:38:22 -0500
Received: by mail-ot1-f66.google.com with SMTP id n46so5026595otb.9
        for <fstests@vger.kernel.org>; Mon, 05 Nov 2018 12:17:00 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
From: Jayashree Mohan <jayashree2912@gmail.com>
In-Reply-To: <20181105052217.GT6311@dastard>
Date: Mon, 5 Nov 2018 14:16:57 -0600
Content-Transfer-Encoding: quoted-printable
Message-Id: <46630C6B-77FA-4D15-92E7-43B89AD889A0@gmail.com>
References: <CA+EzBbB5t5bSZ0hB6Y1jkxTgOLOv809Jbbcx7w5eK_XS_FPG7w@mail.gmail.com>
 <20181104163826.GH12788@desktop>
 <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
 <20181105052217.GT6311@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <guaneryu@gmail.com>, fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Theodore Ts'o <tytso@mit.edu>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

Hi Dave,

Thanks for the comments.=20

>> +init_end_time=3D$(date +%s.%N)
>> +init_time_elapsed=3D$(echo "$init_end_time - $init_start_time" | bc)=20=

>> +echo "Initialization time =3D $init_time_elapsed" >> $seqres.full
>=20
> No timing inside the test, please. The harness times the test
> execution.

Sure, that was meant for the initial evaluation. I=E2=80=99ve removed it =
now.

>=20
>> +total_time=3D0
>> +
>> +_clean_dir()
>> +{
>> +	_mount_flakey
>> +	rm -rf $SCRATCH_MNT/*
>> +	sync
>> +	_unmount_flakey
>> +}
>=20
> Why not just _scratch_mkfs?

I believe that to _scratch_mkfs, I must first _cleanup dm_flakey. If I =
replace the above snippet by=20
_cleanup
_scratch_mkfs
_init_flakey

The time taken for the test goes up by around 10 seconds (due to mkfs =
maybe). So I thought it was sufficient to remove the working directory.



>=20
> Why tee all the output to $seqres.full? Once the timing info is
> removed, it dones't contain anything extra that the normal output
> file=E2=80=A6

Yeah, it was required for my timing info. Removed it now.


>=20
>> +# Group 2: Create hard link in a sub directory
>> +for file_name in $SCRATCH_MNT $SCRATCH_MNT/foo $SCRATCH_MNT/bar =
$SCRATCH_MNT/A $SCRATCH_MNT/A/bar $SCRATCH_MNT/A/foo; do
>> +	test_link $SCRATCH_MNT/foo $SCRATCH_MNT/A/bar $file_name
>> +done
>> +test_link $SCRATCH_MNT/foo $SCRATCH_MNT/A/bar=20
>=20
> Lines too long.
>=20
> Basically, this is a two dimensional array of filenames.
> Make test_link_fsync() do:
>=20
> And all this shouty, shouty noise goes away. Much easier to read,
> much simpler to maintain.

Thanks! I think the code looks cleaner now.

=E2=80=94

diff --git a/tests/generic/517-link b/tests/generic/517-link
new file mode 100755
index 0000000..7108300
--- /dev/null
+++ b/tests/generic/517-link
@@ -0,0 +1,176 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2018 The University of Texas at Austin.  All Rights =
Reserved.
+#
+# FS QA Test 517-link
+#
+# Test case created by CrashMonkey
+#
+# Test if we create a hard link to a file and persist either of the =
files, all the names persist.
+#
+seq=3D`basename $0`
+seqres=3D$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=3D`pwd`
+tmp=3D/tmp/$$
+status=3D1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	_cleanup_flakey
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmflakey
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch_nocheck
+_require_dm_target flakey
+
+# initialize scratch device
+_scratch_mkfs >> $seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+
+stat_opt=3D'-c "blocks: %b size: %s inode: %i links: %h"'
+before=3D""
+after=3D""
+
+_clean_dir()
+{
+	_mount_flakey
+	rm -rf $SCRATCH_MNT/*
+	sync
+	_unmount_flakey
+}
+
+_check_consistency()
+{
+	_flakey_drop_and_remount | tee -a $seqres.full
+=09
+	if [ -f $1 ]; then
+		after=3D`stat "$stat_opt" $1`
+	fi
+
+	if [ "$before" !=3D "$after" ] && [ $2 -ne 1 ]; then
+		echo "Before: $before"=20
+		echo "After: $after"=09
+	fi
+
+	_unmount_flakey
+	_check_scratch_fs $FLAKEY_DEV
+	[ $? -ne 0 ] && _fatal "fsck failed"
+}
+
+# create a hard link $2 to file $1, and fsync $3, followed by power-cut
+test_link_fsync()
+{
+	local sibling=3D0
+	before=3D""
+	after=3D""
+	src=3D$SCRATCH_MNT/$1
+	dest=3D$SCRATCH_MNT/$2
+=09
+	if [ "$3" =3D=3D "./" ]; then
+		fsync=3D$SCRATCH_MNT
+	else
+		fsync=3D$SCRATCH_MNT/$3
+	fi
+
+	echo -ne "\n=3D=3D=3D link $src $dest  with fsync $fsync =3D=3D=3D=
\n" | _filter_scratch
+	_mount_flakey
+=09
+	# now execute the workload
+	mkdir -p "${src%/*}"
+	mkdir -p "${dest%/*}"=20
+	touch $src
+	ln $src $dest || _fail "Link creation failed"
+=09
+	# If the file being persisted is a sibling, create it first
+	if [ ! -f $fsync ]; then
+		sibling=3D1
+		touch $fsync
+	fi
+
+	$XFS_IO_PROG -c "fsync" $fsync
+	=09
+	if [ $sibling -ne 1 ]; then
+		before=3D`stat "$stat_opt" $src`
+	fi
+
+	_check_consistency $src $sibling
+	_clean_dir
+}
+
+# create a hard link $2 to file $1, and sync, followed by power-cut
+test_link_sync()
+{
+	src=3D$SCRATCH_MNT/$1
+	dest=3D$SCRATCH_MNT/$2
+	before=3D""
+	after=3D""
+	echo -ne "\n=3D=3D=3D link $src $dest  with sync =3D=3D=3D\n" | =
_filter_scratch
+	_mount_flakey
+=09
+	# now execute the workload
+	mkdir -p "${src%/*}"
+	mkdir -p "${dest%/*}"=20
+	touch $src
+	ln $src $dest || _fail "Link creation failed"=09
+	sync
+	before=3D`stat "$stat_opt" $src`
+=09
+	_check_consistency $src 0
+	_clean_dir
+}
+
+
+# Create different combinations to run the link test
+# Group 0: Both files within root directory
+file_names[0]=3D"foo bar"
+fsync_names[0]=3D"./ foo bar"
+
+# Group 1: Create hard link in a sub directory
+file_names[1]=3D"foo A/bar"
+fsync_names[1]=3D"./ foo bar A A/bar A/foo"
+
+# Group 2: Create hard link in parent directory
+file_names[2]=3D"A/foo bar"
+fsync_names[2]=3D"./ foo bar A A/bar A/foo"
+
+# Group 3: Both files within a directory other than root
+file_names[3]=3D"A/foo A/bar"
+fsync_names[3]=3D"./ A A/bar A/foo"
+
+#Group 4: Exercise name reuse : Link file in sub-directory
+file_names[4]=3D"bar A/bar"
+fsync_names[4]=3D"./ foo bar A A/bar A/foo"
+
+#Group 5: Exercise name reuse : Link file in parent directory
+file_names[5]=3D"A/bar bar"
+fsync_names[5]=3D"./ foo bar A A/bar A/foo"
+
+for ((test_group=3D0; test_group<6; test_group++)); do
+	for file in ${fsync_names[$test_group]}; do
+		test_link_fsync ${file_names[$test_group]} $file
+	done
+	test_link_sync ${file_names[$test_group]}
+done=20
+
+# success, all done
+status=3D0
+exit
diff --git a/tests/generic/517-link.out b/tests/generic/517-link.out
new file mode 100644
index 0000000..1f80b27
--- /dev/null
+++ b/tests/generic/517-link.out
@@ -0,0 +1,75 @@
+QA output created by 517-link
+
+=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/bar  with fsync SCRATCH_MNT =
=3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/foo =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/bar =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/bar  with sync =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/foo =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/bar =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/A =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/A/bar =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/A/foo =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with sync =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/foo =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/bar =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/A =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/A/bar =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/A/foo =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with sync =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/A =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/A/bar =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/A/foo =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with sync =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/foo =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/bar =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/A =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/A/bar =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/A/foo =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with sync =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/foo =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/bar =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/A =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/A/bar =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/A/foo =3D=3D=3D
+
+=3D=3D=3D link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with sync =3D=3D=3D
diff --git a/tests/generic/group b/tests/generic/group
index 47de978..67e9108 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -519,3 +519,4 @@
 514 auto quick clone
 515 auto quick clone
 516 auto quick dedupe clone
+517-link quick log
