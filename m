Received: from mail-ot1-f65.google.com ([209.85.210.65]:35640 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbeKEFhi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Nov 2018 00:37:38 -0500
Received: by mail-ot1-f65.google.com with SMTP id 81so6170443otj.2
        for <fstests@vger.kernel.org>; Sun, 04 Nov 2018 12:21:24 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] fstest: CrashMonkey tests ported to xfstest
From: Jayashree Mohan <jayashree2912@gmail.com>
In-Reply-To: <20181104163826.GH12788@desktop>
Date: Sun, 4 Nov 2018 14:21:21 -0600
Content-Transfer-Encoding: quoted-printable
Message-Id: <1B22AFA2-FAF3-45AA-9910-CDBE4AEBFB09@gmail.com>
References: <CA+EzBbB5t5bSZ0hB6Y1jkxTgOLOv809Jbbcx7w5eK_XS_FPG7w@mail.gmail.com>
 <20181104163826.GH12788@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, Theodore Ts'o <tytso@mit.edu>, Dave Chinner <david@fromorbit.com>, Amir Goldstein <amir73il@gmail.com>, Filipe Manana <fdmanana@gmail.com>
List-ID: <fstests@vger.kernel.org>

Hi Eryu and Filipe,

I have incorporated the coding style suggested, and renamed the cleanup =
function. However, creating a clean fs image after each sub test is =
resulting in about 10-15s of additional overhead overall. I instead =
clean up the working directory and unmount. The time for the tests =
varies between 12-15 seconds.

Please find the patch below

=E2=80=94

diff --git a/tests/generic/517-link b/tests/generic/517-link
new file mode 100755
index 0000000..ea5c5b7
--- /dev/null
+++ b/tests/generic/517-link
@@ -0,0 +1,164 @@
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
+init_start_time=3D$(date +%s.%N)
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
+init_end_time=3D$(date +%s.%N)
+init_time_elapsed=3D$(echo "$init_end_time - $init_start_time" | bc)=20
+echo "Initialization time =3D $init_time_elapsed" >> $seqres.full
+
+stat_opt=3D'-c "blocks: %b size: %s inode: %i links: %h"'
+test_num=3D0
+total_time=3D0
+
+_clean_dir()
+{
+	_mount_flakey
+	rm -rf $SCRATCH_MNT/*
+	sync
+	_unmount_flakey
+}
+
+# create a hard link $2 to file $1, and fsync $3, followed by power-cut
+test_link()
+{
+	test_num=3D$((test_num + 1))
+	local start_time=3D$(date +%s.%N)
+	local sibling=3D0
+	local before=3D""
+	local after=3D""
+	echo -ne "\n=3D=3D=3D Test $test_num :  link $1 $2 " | =
_filter_scratch
+	_mount_flakey
+=09
+	# now execute the workload
+	mkdir -p "${1%/*}" && mkdir -p "${2%/*}" && touch "$1"
+	ln $1 $2
+=09
+	if [ -z "$3" ]; then
+		echo -ne " with sync =3D=3D=3D\n"
+		sync
+		before=3D`stat "$stat_opt" $1`
+	else
+		echo " with fsync $3 =3D=3D=3D" | _filter_scratch
+	=09
+		# If the file being persisted is a sibling, create it =
first
+		if [ ! -f $3 ]; then
+			sibling=3D1
+			touch $3
+		fi
+
+		$XFS_IO_PROG -c "fsync" $3
+	=09
+		if [ $sibling -ne 1 ]; then
+			before=3D`stat "$stat_opt" $1`
+		fi
+	fi
+
+	_flakey_drop_and_remount | tee -a $seqres.full
+=09
+	if [ -f $1 ]; then
+		after=3D`stat "$stat_opt" $1`
+	fi
+
+	if [ "$before" !=3D "$after" ] && [ $sibling -ne 1 ]; then
+		echo "Before: $before" | tee -a $seqres.full
+		echo "After: $after" | tee -a $seqres.full=09
+	fi
+
+	_unmount_flakey
+	_check_scratch_fs $FLAKEY_DEV
+	[ $? -ne 0 ] && _fatal "fsck failed"
+	end_time=3D$(date +%s.%N)
+	time_elapsed=3D$(echo "$end_time - $start_time" | bc)
+	echo " Elapsed time : $time_elapsed" >> $seqres.full
+	total_time=3D$(echo "$total_time + $time_elapsed" | bc)
+	echo " Total time : $total_time" >> $seqres.full
+	_clean_dir
+}
+
+# run the link test for different combinations
+
+test_start_time=3D$(date +%s.%N)
+# Group 1: Both files within root directory
+for file_name in $SCRATCH_MNT $SCRATCH_MNT/foo $SCRATCH_MNT/bar; do
+	test_link $SCRATCH_MNT/foo $SCRATCH_MNT/bar $file_name
+done
+test_link $SCRATCH_MNT/foo $SCRATCH_MNT/bar=20
+
+# Group 2: Create hard link in a sub directory
+for file_name in $SCRATCH_MNT $SCRATCH_MNT/foo $SCRATCH_MNT/bar =
$SCRATCH_MNT/A $SCRATCH_MNT/A/bar $SCRATCH_MNT/A/foo; do
+	test_link $SCRATCH_MNT/foo $SCRATCH_MNT/A/bar $file_name
+done
+test_link $SCRATCH_MNT/foo $SCRATCH_MNT/A/bar=20
+
+# Group 3: Create hard link in parent directory
+for file_name in $SCRATCH_MNT $SCRATCH_MNT/foo $SCRATCH_MNT/bar =
$SCRATCH_MNT/A $SCRATCH_MNT/A/bar $SCRATCH_MNT/A/foo; do
+	test_link $SCRATCH_MNT/A/foo $SCRATCH_MNT/bar $file_name
+done
+test_link $SCRATCH_MNT/A/foo $SCRATCH_MNT/bar=20
+
+# Group 4: Both files within a directory other than root
+for file_name in $SCRATCH_MNT $SCRATCH_MNT/A $SCRATCH_MNT/A/bar =
$SCRATCH_MNT/A/foo; do
+	test_link $SCRATCH_MNT/A/foo $SCRATCH_MNT/A/bar $file_name
+done
+test_link $SCRATCH_MNT/A/foo $SCRATCH_MNT/A/bar=20
+
+#Group 5: Exercise name reuse : Link file in sub-directory
+for file_name in $SCRATCH_MNT $SCRATCH_MNT/foo $SCRATCH_MNT/bar =
$SCRATCH_MNT/A $SCRATCH_MNT/A/bar $SCRATCH_MNT/A/foo; do
+	test_link $SCRATCH_MNT/bar $SCRATCH_MNT/A/bar $file_name
+done
+test_link $SCRATCH_MNT/bar $SCRATCH_MNT/A/bar=20
+
+#Group 6: Exercise name reuse : Link file in parent directory
+for file_name in $SCRATCH_MNT $SCRATCH_MNT/foo $SCRATCH_MNT/bar =
$SCRATCH_MNT/A $SCRATCH_MNT/A/bar $SCRATCH_MNT/A/foo; do
+	test_link $SCRATCH_MNT/A/bar $SCRATCH_MNT/bar $file_name
+done
+test_link $SCRATCH_MNT/A/bar $SCRATCH_MNT/bar=20
+
+test_end_time=3D$(date +%s.%N)
+test_time_elapsed=3D$(echo "$test_end_time-$test_start_time" | bc)=20
+echo "Test Elapsed time : $test_time_elapsed" >> $seqres.full
+
+# success, all done
+status=3D0
+exit
diff --git a/tests/generic/517-link.out b/tests/generic/517-link.out
new file mode 100644
index 0000000..9555860
--- /dev/null
+++ b/tests/generic/517-link.out
@@ -0,0 +1,75 @@
+QA output created by 517-link
+
+=3D=3D=3D Test 1 :  link SCRATCH_MNT/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT =3D=3D=3D
+
+=3D=3D=3D Test 2 :  link SCRATCH_MNT/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/foo =3D=3D=3D
+
+=3D=3D=3D Test 3 :  link SCRATCH_MNT/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/bar =3D=3D=3D
+
+=3D=3D=3D Test 4 :  link SCRATCH_MNT/foo SCRATCH_MNT/bar  with sync =3D=3D=
=3D
+
+=3D=3D=3D Test 5 :  link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT =3D=3D=3D
+
+=3D=3D=3D Test 6 :  link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/foo =3D=3D=3D
+
+=3D=3D=3D Test 7 :  link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/bar =3D=3D=3D
+
+=3D=3D=3D Test 8 :  link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/A =3D=3D=3D
+
+=3D=3D=3D Test 9 :  link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/A/bar =3D=3D=3D
+
+=3D=3D=3D Test 10 :  link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/A/foo =3D=3D=3D
+
+=3D=3D=3D Test 11 :  link SCRATCH_MNT/foo SCRATCH_MNT/A/bar  with sync =
=3D=3D=3D
+
+=3D=3D=3D Test 12 :  link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT =3D=3D=3D
+
+=3D=3D=3D Test 13 :  link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/foo =3D=3D=3D
+
+=3D=3D=3D Test 14 :  link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/bar =3D=3D=3D
+
+=3D=3D=3D Test 15 :  link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/A =3D=3D=3D
+
+=3D=3D=3D Test 16 :  link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/A/bar =3D=3D=3D
+
+=3D=3D=3D Test 17 :  link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/A/foo =3D=3D=3D
+
+=3D=3D=3D Test 18 :  link SCRATCH_MNT/A/foo SCRATCH_MNT/bar  with sync =
=3D=3D=3D
+
+=3D=3D=3D Test 19 :  link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with =
fsync SCRATCH_MNT =3D=3D=3D
+
+=3D=3D=3D Test 20 :  link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with =
fsync SCRATCH_MNT/A =3D=3D=3D
+
+=3D=3D=3D Test 21 :  link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with =
fsync SCRATCH_MNT/A/bar =3D=3D=3D
+
+=3D=3D=3D Test 22 :  link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with =
fsync SCRATCH_MNT/A/foo =3D=3D=3D
+
+=3D=3D=3D Test 23 :  link SCRATCH_MNT/A/foo SCRATCH_MNT/A/bar  with =
sync =3D=3D=3D
+
+=3D=3D=3D Test 24 :  link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT =3D=3D=3D
+
+=3D=3D=3D Test 25 :  link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/foo =3D=3D=3D
+
+=3D=3D=3D Test 26 :  link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/bar =3D=3D=3D
+
+=3D=3D=3D Test 27 :  link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/A =3D=3D=3D
+
+=3D=3D=3D Test 28 :  link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/A/bar =3D=3D=3D
+
+=3D=3D=3D Test 29 :  link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with fsync =
SCRATCH_MNT/A/foo =3D=3D=3D
+
+=3D=3D=3D Test 30 :  link SCRATCH_MNT/bar SCRATCH_MNT/A/bar  with sync =
=3D=3D=3D
+
+=3D=3D=3D Test 31 :  link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT =3D=3D=3D
+
+=3D=3D=3D Test 32 :  link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/foo =3D=3D=3D
+
+=3D=3D=3D Test 33 :  link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/bar =3D=3D=3D
+
+=3D=3D=3D Test 34 :  link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/A =3D=3D=3D
+
+=3D=3D=3D Test 35 :  link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/A/bar =3D=3D=3D
+
+=3D=3D=3D Test 36 :  link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with fsync =
SCRATCH_MNT/A/foo =3D=3D=3D
+
+=3D=3D=3D Test 37 :  link SCRATCH_MNT/A/bar SCRATCH_MNT/bar  with sync =
=3D=3D=3D
diff --git a/tests/generic/group b/tests/generic/group
index 47de978..67e9108 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -519,3 +519,4 @@
 514 auto quick clone
 515 auto quick clone
 516 auto quick dedupe clone
+517-link quick log


> On Nov 4, 2018, at 10:38 AM, Eryu Guan <guaneryu@gmail.com> wrote:
>=20
> On Mon, Oct 29, 2018 at 11:50:39AM -0500, Jayashree Mohan wrote:
>> Hi all,
>>=20
>> As discussed previously, I have ported a few CrashMonkey tests into
>> xfstest test-case for your review. I have written a patch for testing
>> simple "hard link" behaviour. This patch batches 37 test cases
>> generated by CrashMonkey into one  xfstest test, all of them testing
>> hard-link behaviour.  These 37 tests have been grouped based on the
>> similarities; there are comments in the patch to
>> describe what each group is testing for. On a high-level, we are
>> testing the creation of hard links between files in same directory =
and
>> files across two directories, while allowing fsync of either the =
files
>> involved, their parent directories, or unrelated sibling files.
>>=20
>> We aim to convert the other CrashMonkey tests in the same way, =
batched
>> by the type of file-system operation we test. This particular test
>> took 10 seconds to run on my VM (Ubuntu 16.04, 2GB RAM, single core)
>> on 100MB scratch partition. I have added per test case timer in this
>> patch, which shows each test case takes about 0.25 seconds (to run,
>> flakey_remount, test and cleanup). This test passes clean on ext4, =
xfs
>> and F2FS. It will show three failed cases as of kernel 4.16 on btrfs
>> (I think it's not yet patched on 4.19, so you should see the failure
>> on the newest kernel as well).
>>=20
>> Thinking more about it, none of the CrashMonkey test cases check for
>> resource exhaustion and hence we don't need more than 100MB of =
scratch
>> device. If the per-test external overhead due to fsck/scrub etc
>> depends on the scratch partition size, we can speed up the =
CrashMonkey
>> tests by allowing a new device like scratch(much smaller in size -
>> about 100-200MB). Additionally, our tests also do not need fsck to be
>> run at the end. Is there a way to skip performing fsck after each =
test
>> (if its something configurable in the test file) ?
>>=20
>> If this sort of patch seems fine to you, I can go ahead and port the
>> other CrashMonkey tests in the same way. After batching, I hope there
>> would be around 10-12 test files like the one attached here.
>>=20
>> Patch below:
>> ---
>>=20
>> diff --git a/tests/generic/517-link b/tests/generic/517-link
>> new file mode 100755
>> index 0000000..791b6c0
>> --- /dev/null
>> +++ b/tests/generic/517-link
>> @@ -0,0 +1,162 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2018 The University of Texas at Austin.  All Rights =
Reserved.
>> +#
>> +# FS QA Test 517-link
>> +#
>> +# Test if we create a hard link to a file and persist either of the
>> files, all the names persist.
>=20
> Your mail agent seems to wrap the line and makes the patch unable to =
be
> applied. There're many other places in the patch. Could you please =
take
> a look?
>=20
>> +#
>> +seq=3D`basename $0`
>> +seqres=3D$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=3D`pwd`
>> +tmp=3D/tmp/$$
>> +status=3D1    # failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +    _cleanup_flakey
>=20
> Please use single tab to do indention not 4 spaces.
>=20
>> +    cd /
>> +    rm -f $tmp.*
>> +}
>> +
>> +init_start_time=3D$(date +%s.%N)
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +. ./common/filter
>> +. ./common/dmflakey
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_scratch
>> +_require_dm_target flakey
>> +
>> +# initialize scratch device
>> +_scratch_mkfs >>$seqres.full 2>&1
>> +_require_metadata_journaling $SCRATCH_DEV
>> +_init_flakey
>> +_mount_flakey
>> +init_end_time=3D$(date +%s.%N)
>> +init_time_elapsed=3D$(echo "$init_end_time-$init_start_time" | bc)
>> +echo "Initialization time =3D $init_time_elapsed" >> $seqres.full
>> +
>> +stat_opt=3D'-c "blocks: %b size: %s inode: %i links: %h"'
>> +test_num=3D0
>> +total_time=3D0
>> +
>> +cleanup()
>=20
> Hmm, this could be confusing people, as we already have a _cleanup()
> function. But I think it'd be better to re-create the fs for each test
> so every sub-test starts with a clean filesystem and there's no need =
to
> do cleanup after each sub-test. (Yeah, this may consume more test =
time.)
>=20
> Thanks,
> Eryu
>=20
>> +{
>> +    rm -rf $SCRATCH_MNT/*
>> +    sync
>> +}
>> +
>> +# create a hard link $2 to file $1, and fsync $3, followed by =
power-cu
>> +test_link()
>> +{
>> +    start_time=3D$(date +%s.%N)
>> +    test_num=3D$((test_num + 1))
>> +    sibling=3D0
>> +    before=3D""
>> +    after=3D""
>> +    echo -ne "\n=3D=3D=3D Test $test_num :  link $1 $2 " | tee -a =
$seqres.full
>> +
>> +    # now execute the workload
>> +    mkdir -p "${1%/*}" && mkdir -p "${2%/*}" && touch "$1"
>> +    ln $1 $2
>> +
>> +    if [ -z "$3" ]
>> +    then
>> +        echo -ne " with sync =3D=3D=3D\n"
>> +        sync
>> +        before=3D`stat "$stat_opt" $1`
>> +    else
>> +        echo " with fsync $3 =3D=3D=3D"
>> +
>> +        # If the file being persisted is a sibling, create it first
>> +        if [ ! -f $3 ]
>> +        then
>> +            sibling=3D1
>> +            touch $3
>> +        fi
>> +
>> +        $XFS_IO_PROG -c "fsync" $3 | _filter_xfs_io
>> +
>> +        if [ $sibling -ne 1 ]
>> +        then
>> +            before=3D`stat "$stat_opt" $1`
>> +        fi
>> +    fi
>> +
>> +    _flakey_drop_and_remount | tee -a $seqres.full
>> +
>> +    if [ -f $1 ]
>> +    then
>> +        after=3D`stat "$stat_opt" $1`
>> +    fi
>> +
>> +    if [ "$before" !=3D "$after" ] && [ $sibling -ne 1 ]
>> +    then
>> +        echo "Before: $before" | tee -a $seqres.full
>> +        echo "After: $after" | tee -a $seqres.full
>> +    fi
>> +
>> +    cleanup
>> +    end_time=3D$(date +%s.%N)
>> +    time_elapsed=3D$(echo "$end_time-$start_time" | bc)
>> +    echo " Elapsed time : $time_elapsed" >> $seqres.full
>> +    total_time=3D$(echo "$total_time+$time_elapsed" | bc)
>> +    echo " Total time : $total_time" >> $seqres.full
>> +}
>> +
>> +# run the link test for different combinations
>> +
>> +test_start_time=3D$(date +%s.%N)
>> +# Group 1: Both files within root directory
>> +for file_name in $SCRATCH_MNT $SCRATCH_MNT/foo $SCRATCH_MNT/bar; do
>> +    test_link $SCRATCH_MNT/foo $SCRATCH_MNT/bar $file_name
>> +done
>> +test_link $SCRATCH_MNT/foo $SCRATCH_MNT/bar
>> +
>> +# Group 2: Create hard link in a sub directory
>> +for file_name in $SCRATCH_MNT $SCRATCH_MNT/foo $SCRATCH_MNT/bar
>> $SCRATCH_MNT/A $SCRATCH_MNT/A/bar $SCRATCH_MNT/A/foo; do
>> +    test_link $SCRATCH_MNT/foo $SCRATCH_MNT/A/bar $file_name
>> +done
>> +test_link $SCRATCH_MNT/foo $SCRATCH_MNT/A/bar
>> +
>> +# Group 3: Create hard link in parent directory
>> +for file_name in $SCRATCH_MNT $SCRATCH_MNT/foo $SCRATCH_MNT/bar
>> $SCRATCH_MNT/A $SCRATCH_MNT/A/bar $SCRATCH_MNT/A/foo; do
>> +    test_link $SCRATCH_MNT/A/foo $SCRATCH_MNT/bar $file_name
>> +done
>> +test_link $SCRATCH_MNT/A/foo $SCRATCH_MNT/bar
>> +
>> +# Group 4: Both files within a directory other than root
>> +for file_name in $SCRATCH_MNT $SCRATCH_MNT/A $SCRATCH_MNT/A/bar
>> $SCRATCH_MNT/A/foo; do
>> +    test_link $SCRATCH_MNT/A/foo $SCRATCH_MNT/A/bar $file_name
>> +done
>> +test_link $SCRATCH_MNT/A/foo $SCRATCH_MNT/A/bar
>> +
>> +#Group 5: Exercise name reuse : Link file in sub-directory
>> +for file_name in $SCRATCH_MNT $SCRATCH_MNT/foo $SCRATCH_MNT/bar
>> $SCRATCH_MNT/A $SCRATCH_MNT/A/bar $SCRATCH_MNT/A/foo; do
>> +    test_link $SCRATCH_MNT/bar $SCRATCH_MNT/A/bar $file_name
>> +done
>> +test_link $SCRATCH_MNT/bar $SCRATCH_MNT/A/bar
>> +
>> +#Group 6: Exercise name reuse : Link file in parent directory
>> +for file_name in $SCRATCH_MNT $SCRATCH_MNT/foo $SCRATCH_MNT/bar
>> $SCRATCH_MNT/A $SCRATCH_MNT/A/bar $SCRATCH_MNT/A/foo; do
>> +    test_link $SCRATCH_MNT/A/bar $SCRATCH_MNT/bar $file_name
>> +done
>> +test_link $SCRATCH_MNT/A/bar $SCRATCH_MNT/bar
>> +
>> +test_end_time=3D$(date +%s.%N)
>> +test_time_elapsed=3D$(echo "$test_end_time-$test_start_time" | bc)
>> +echo "Test Elapsed time : $test_time_elapsed" >> $seqres.full
>> +
>> +# success, all done
>> +status=3D0
>> +exit
>> diff --git a/tests/generic/517-link.out b/tests/generic/517-link.out
>> new file mode 100644
>> index 0000000..381b644
>> --- /dev/null
>> +++ b/tests/generic/517-link.out
>> @@ -0,0 +1,75 @@
>> +QA output created by 517-link
>> +
>> +=3D=3D=3D Test 1 :  link /mnt/scratch/foo /mnt/scratch/bar  with =
fsync
>> /mnt/scratch =3D=3D=3D
>> +
>> +=3D=3D=3D Test 2 :  link /mnt/scratch/foo /mnt/scratch/bar  with =
fsync
>> /mnt/scratch/foo =3D=3D=3D
>> +
>> +=3D=3D=3D Test 3 :  link /mnt/scratch/foo /mnt/scratch/bar  with =
fsync
>> /mnt/scratch/bar =3D=3D=3D
>> +
>> +=3D=3D=3D Test 4 :  link /mnt/scratch/foo /mnt/scratch/bar  with =
sync =3D=3D=3D
>> +
>> +=3D=3D=3D Test 5 :  link /mnt/scratch/foo /mnt/scratch/A/bar  with =
fsync
>> /mnt/scratch =3D=3D=3D
>> +
>> +=3D=3D=3D Test 6 :  link /mnt/scratch/foo /mnt/scratch/A/bar  with =
fsync
>> /mnt/scratch/foo =3D=3D=3D
>> +
>> +=3D=3D=3D Test 7 :  link /mnt/scratch/foo /mnt/scratch/A/bar  with =
fsync
>> /mnt/scratch/bar =3D=3D=3D
>> +
>> +=3D=3D=3D Test 8 :  link /mnt/scratch/foo /mnt/scratch/A/bar  with =
fsync
>> /mnt/scratch/A =3D=3D=3D
>> +
>> +=3D=3D=3D Test 9 :  link /mnt/scratch/foo /mnt/scratch/A/bar  with =
fsync
>> /mnt/scratch/A/bar =3D=3D=3D
>> +
>> +=3D=3D=3D Test 10 :  link /mnt/scratch/foo /mnt/scratch/A/bar  with =
fsync
>> /mnt/scratch/A/foo =3D=3D=3D
>> +
>> +=3D=3D=3D Test 11 :  link /mnt/scratch/foo /mnt/scratch/A/bar  with =
sync =3D=3D=3D
>> +
>> +=3D=3D=3D Test 12 :  link /mnt/scratch/A/foo /mnt/scratch/bar  with =
fsync
>> /mnt/scratch =3D=3D=3D
>> +
>> +=3D=3D=3D Test 13 :  link /mnt/scratch/A/foo /mnt/scratch/bar  with =
fsync
>> /mnt/scratch/foo =3D=3D=3D
>> +
>> +=3D=3D=3D Test 14 :  link /mnt/scratch/A/foo /mnt/scratch/bar  with =
fsync
>> /mnt/scratch/bar =3D=3D=3D
>> +
>> +=3D=3D=3D Test 15 :  link /mnt/scratch/A/foo /mnt/scratch/bar  with =
fsync
>> /mnt/scratch/A =3D=3D=3D
>> +
>> +=3D=3D=3D Test 16 :  link /mnt/scratch/A/foo /mnt/scratch/bar  with =
fsync
>> /mnt/scratch/A/bar =3D=3D=3D
>> +
>> +=3D=3D=3D Test 17 :  link /mnt/scratch/A/foo /mnt/scratch/bar  with =
fsync
>> /mnt/scratch/A/foo =3D=3D=3D
>> +
>> +=3D=3D=3D Test 18 :  link /mnt/scratch/A/foo /mnt/scratch/bar  with =
sync =3D=3D=3D
>> +
>> +=3D=3D=3D Test 19 :  link /mnt/scratch/A/foo /mnt/scratch/A/bar  =
with fsync
>> /mnt/scratch =3D=3D=3D
>> +
>> +=3D=3D=3D Test 20 :  link /mnt/scratch/A/foo /mnt/scratch/A/bar  =
with fsync
>> /mnt/scratch/A =3D=3D=3D
>> +
>> +=3D=3D=3D Test 21 :  link /mnt/scratch/A/foo /mnt/scratch/A/bar  =
with fsync
>> /mnt/scratch/A/bar =3D=3D=3D
>> +
>> +=3D=3D=3D Test 22 :  link /mnt/scratch/A/foo /mnt/scratch/A/bar  =
with fsync
>> /mnt/scratch/A/foo =3D=3D=3D
>> +
>> +=3D=3D=3D Test 23 :  link /mnt/scratch/A/foo /mnt/scratch/A/bar  =
with sync =3D=3D=3D
>> +
>> +=3D=3D=3D Test 24 :  link /mnt/scratch/bar /mnt/scratch/A/bar  with =
fsync
>> /mnt/scratch =3D=3D=3D
>> +
>> +=3D=3D=3D Test 25 :  link /mnt/scratch/bar /mnt/scratch/A/bar  with =
fsync
>> /mnt/scratch/foo =3D=3D=3D
>> +
>> +=3D=3D=3D Test 26 :  link /mnt/scratch/bar /mnt/scratch/A/bar  with =
fsync
>> /mnt/scratch/bar =3D=3D=3D
>> +
>> +=3D=3D=3D Test 27 :  link /mnt/scratch/bar /mnt/scratch/A/bar  with =
fsync
>> /mnt/scratch/A =3D=3D=3D
>> +
>> +=3D=3D=3D Test 28 :  link /mnt/scratch/bar /mnt/scratch/A/bar  with =
fsync
>> /mnt/scratch/A/bar =3D=3D=3D
>> +
>> +=3D=3D=3D Test 29 :  link /mnt/scratch/bar /mnt/scratch/A/bar  with =
fsync
>> /mnt/scratch/A/foo =3D=3D=3D
>> +
>> +=3D=3D=3D Test 30 :  link /mnt/scratch/bar /mnt/scratch/A/bar  with =
sync =3D=3D=3D
>> +
>> +=3D=3D=3D Test 31 :  link /mnt/scratch/A/bar /mnt/scratch/bar  with =
fsync
>> /mnt/scratch =3D=3D=3D
>> +
>> +=3D=3D=3D Test 32 :  link /mnt/scratch/A/bar /mnt/scratch/bar  with =
fsync
>> /mnt/scratch/foo =3D=3D=3D
>> +
>> +=3D=3D=3D Test 33 :  link /mnt/scratch/A/bar /mnt/scratch/bar  with =
fsync
>> /mnt/scratch/bar =3D=3D=3D
>> +
>> +=3D=3D=3D Test 34 :  link /mnt/scratch/A/bar /mnt/scratch/bar  with =
fsync
>> /mnt/scratch/A =3D=3D=3D
>> +
>> +=3D=3D=3D Test 35 :  link /mnt/scratch/A/bar /mnt/scratch/bar  with =
fsync
>> /mnt/scratch/A/bar =3D=3D=3D
>> +
>> +=3D=3D=3D Test 36 :  link /mnt/scratch/A/bar /mnt/scratch/bar  with =
fsync
>> /mnt/scratch/A/foo =3D=3D=3D
>> +
>> +=3D=3D=3D Test 37 :  link /mnt/scratch/A/bar /mnt/scratch/bar  with =
sync =3D=3D=3D
>> diff --git a/tests/generic/group b/tests/generic/group
>> index 47de978..dc04152 100644
>> --- a/tests/generic/group
>> +++ b/tests/generic/group
>> @@ -519,3 +519,4 @@
>> 514 auto quick clone
>> 515 auto quick clone
>> 516 auto quick dedupe clone
>> +517-link crash
>>=20
>>=20
>> Thanks,
>> Jayashree Mohan
