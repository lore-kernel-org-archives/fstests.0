Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727473AbeHWGIz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 23 Aug 2018 02:08:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 18FB6401DEB8
        for <fstests@vger.kernel.org>; Thu, 23 Aug 2018 02:41:29 +0000 (UTC)
Received: from dhcp-12-108.nay.redhat.com (dhcp-12-108.nay.redhat.com [10.66.12.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7BF02026D74
        for <fstests@vger.kernel.org>; Thu, 23 Aug 2018 02:41:27 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] xfstests: filter redundant output by getfattr
Date: Thu, 23 Aug 2018 10:41:24 +0800
Message-Id: <20180823024124.5341-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When getfattr dumps values of all extended attributes (-d option),
it doesn't print empty extended attributes. e.g: user.name. But
from attr-2.4.48 this behavior is changed,  new getfattr prints
user.name="".

The {=""} will break the golden image, so filter the redundant =""
at the end if it has.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

Sorry I took long time to write this V2, due to it changed many
cases, I have to test them one by one. V1 patch refer to:
https://patchwork.kernel.org/patch/10521875/

V2 did below changes:
1) Bring in a common function named _getfattr()
2) Replace all $GETFATTR_PROG with _getfattr

Thanks,
Zorro

 common/attr       | 11 +++++++++++
 tests/ext4/022    |  2 +-
 tests/ext4/026    |  4 ++--
 tests/generic/020 |  8 ++++----
 tests/generic/037 |  2 +-
 tests/generic/062 |  4 ++--
 tests/generic/066 |  4 ++--
 tests/generic/093 |  2 +-
 tests/generic/097 |  2 +-
 tests/generic/337 |  2 +-
 tests/generic/364 |  4 ++--
 tests/generic/403 |  2 +-
 tests/generic/454 |  6 +++---
 tests/generic/489 |  2 +-
 tests/overlay/011 |  2 +-
 tests/overlay/026 |  4 ++--
 tests/overlay/038 |  4 ++--
 tests/overlay/041 |  4 ++--
 tests/overlay/046 |  6 +++---
 tests/overlay/056 |  2 +-
 tests/overlay/060 |  4 ++--
 tests/shared/002  |  2 +-
 tests/xfs/021     |  8 ++++----
 tests/xfs/187     |  2 +-
 24 files changed, 52 insertions(+), 41 deletions(-)

diff --git a/common/attr b/common/attr
index 10b98eef..7568c60a 100644
--- a/common/attr
+++ b/common/attr
@@ -224,6 +224,17 @@ _sort_getfattr_output()
     awk '{a[FNR]=$0}END{n = asort(a); for(i=1; i <= n; i++) print a[i]"\n"}' RS=''
 }
 
+# When getfattr dump values of all extended attributes, it print empty attr
+# as user.name before, but new getfattr print it as user.name="". For match
+# the golden image, filter the redundant ="" at the end.
+#
+# Note: This function returns the getfattr command result.
+_getfattr()
+{
+	$GETFATTR_PROG "$@" | sed -e 's/=\"\"//'
+	return ${PIPESTATUS[0]}
+}
+
 # set maximum total attr space based on fs type
 case "$FSTYP" in
 xfs|udf|pvfs2|9p|ceph)
diff --git a/tests/ext4/022 b/tests/ext4/022
index 7dc19e8e..1123e7a2 100755
--- a/tests/ext4/022
+++ b/tests/ext4/022
@@ -151,7 +151,7 @@ done
 
 # Dump all xattrs to see whether nothing broke
 for FILE in ${FNAMES[@]}; do
-	$GETFATTR_PROG -h -d --absolute-names $SCRATCH_MNT/$FILE 2>/dev/null | \
+	_getfattr -h -d --absolute-names $SCRATCH_MNT/$FILE 2>/dev/null | \
 		_filter_scratch | sort
 done
 
diff --git a/tests/ext4/026 b/tests/ext4/026
index f651fe6e..5e0e8879 100755
--- a/tests/ext4/026
+++ b/tests/ext4/026
@@ -51,14 +51,14 @@ attr_set()
 		$SETFATTR_PROG -n $name $file
 	fi
 
-	tmp=$($GETFATTR_PROG --absolute-names --only-values -n $name $file)
+	tmp=$(_getfattr --absolute-names --only-values -n $name $file)
 	[[ "$tmp" == "$value" ]] || echo "unexpected value returned: $tmp"
 }
 
 # List attributes on a file.
 attr_list()
 {
-	$GETFATTR_PROG --absolute-names $1 | grep -v '^#'
+	_getfattr --absolute-names $1 | grep -v '^#'
 }
 
 # Removes an extended attribute from a file.
diff --git a/tests/generic/020 b/tests/generic/020
index 8bd5fe04..936d8485 100755
--- a/tests/generic/020
+++ b/tests/generic/020
@@ -35,9 +35,9 @@ _attr()
     return $exit
 }
 
-_getfattr()
+do_getfattr()
 {
-    $GETFATTR_PROG $* 2>$tmp.err >$tmp.out
+    _getfattr $* 2>$tmp.err >$tmp.out
     exit=$?
     _filter $tmp.out
     _filter $tmp.err 1>&2
@@ -49,7 +49,7 @@ _attr_list()
     file=$1
     
     echo "   *** print attributes"
-    if ! _getfattr -d -e text --absolute-names $file
+    if ! do_getfattr -d -e text --absolute-names $file
     then
         echo "      !!! error return"
         return 1
@@ -110,7 +110,7 @@ done
 
 echo "*** check"
 # don't print it all out...
-getfattr --absolute-names $testfile \
+_getfattr --absolute-names $testfile \
     | tee -a $seqres.full \
     | $AWK_PROG '
     	/^#/ { next }
diff --git a/tests/generic/037 b/tests/generic/037
index b5edd033..d08232ae 100755
--- a/tests/generic/037
+++ b/tests/generic/037
@@ -76,7 +76,7 @@ set_xattr_loop $test_file &
 setter_pid=$!
 
 for ((i = 0; i < 1000; i++)); do
-	$GETFATTR_PROG --absolute-names -n $xattr_name \
+	_getfattr --absolute-names -n $xattr_name \
 		$SCRATCH_MNT/$test_file | value_filter
 done
 
diff --git a/tests/generic/062 b/tests/generic/062
index df67960d..b6e28e0f 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -31,7 +31,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 
 getfattr()
 {
-    $GETFATTR_PROG --absolute-names -dh $@ 2>&1 | _filter_scratch
+    _getfattr --absolute-names -dh $@ 2>&1 | _filter_scratch
 }
 
 setfattr()
@@ -166,7 +166,7 @@ _backup()
 	# we *do* sort the output by path, since it otherwise would depend on
 	# readdir order, which on some filesystems may change after re-creating
 	# the files.
-	$GETFATTR_PROG --absolute-names -dh -R -m '.' $SCRATCH_MNT | _sort_getfattr_output >$1
+	_getfattr --absolute-names -dh -R -m '.' $SCRATCH_MNT | _sort_getfattr_output >$1
 	echo BACKUP $1 >>$seqres.full
 	cat $1 >> $seqres.full
 	[ ! -s $1 ] && echo "warning: $1 (backup file) is empty"
diff --git a/tests/generic/066 b/tests/generic/066
index 7ad14218..3b3ff2bb 100755
--- a/tests/generic/066
+++ b/tests/generic/066
@@ -72,7 +72,7 @@ _flakey_drop_and_remount
 # with the 3 xattrs that we had before deleting the second one and fsyncing the
 # file.
 echo "xattr names and values after first fsync log replay:"
-$GETFATTR_PROG --absolute-names --dump $SCRATCH_MNT/foobar | _filter_scratch
+_getfattr --absolute-names --dump $SCRATCH_MNT/foobar | _filter_scratch
 
 # Now write some data to our file, fsync it, remove the first xattr, add a new
 # hard link to our file and commit the fsync log by fsyncing some other new
@@ -89,7 +89,7 @@ _flakey_drop_and_remount
 
 # Now only the xattr with name user.attr3 should be set in our file.
 echo "xattr names and values after second fsync log replay:"
-$GETFATTR_PROG --absolute-names --dump $SCRATCH_MNT/foobar | _filter_scratch
+_getfattr --absolute-names --dump $SCRATCH_MNT/foobar | _filter_scratch
 
 status=0
 exit
diff --git a/tests/generic/093 b/tests/generic/093
index fc609b06..a2467a5b 100755
--- a/tests/generic/093
+++ b/tests/generic/093
@@ -63,7 +63,7 @@ $SETCAP_PROG cap_chown+ep $file
 $SETFATTR_PROG -n trusted.name -v value $file
 echo data2 >> $file
 cat $file
-$GETFATTR_PROG -m '^trusted\.*' --absolute-names $file | filefilter
+_getfattr -m '^trusted\.*' --absolute-names $file | filefilter
 
 echo "**** Verifying that chmod doesn't affect open file descriptors ****"
 rm -f $file
diff --git a/tests/generic/097 b/tests/generic/097
index db8dc71a..679f1a24 100755
--- a/tests/generic/097
+++ b/tests/generic/097
@@ -30,7 +30,7 @@ _cleanup()
 
 getfattr()
 {
-	$GETFATTR_PROG --absolute-names "$@" |& _filter_test_dir
+	_getfattr --absolute-names "$@" |& _filter_test_dir
 }
 
 setfattr()
diff --git a/tests/generic/337 b/tests/generic/337
index a76aa612..344a3659 100755
--- a/tests/generic/337
+++ b/tests/generic/337
@@ -49,7 +49,7 @@ $SETFATTR_PROG -n user.ping -v pong $SCRATCH_MNT/testfile
 
 # Now call getfattr with --dump, which calls the listxattrs system call.
 # It should list all the xattrs we have set before.
-$GETFATTR_PROG --absolute-names --dump $SCRATCH_MNT/testfile | _filter_scratch
+_getfattr --absolute-names --dump $SCRATCH_MNT/testfile | _filter_scratch
 
 status=0
 exit
diff --git a/tests/generic/364 b/tests/generic/364
index 6bed9ca2..2d66d981 100755
--- a/tests/generic/364
+++ b/tests/generic/364
@@ -59,11 +59,11 @@ $GETRICHACL_PROG x
 mkdir sub
 $SETRICHACL_PROG --set 'everyone@:rwpxd:fd:allow' sub
 stat -c %A+ sub
-$GETFATTR_PROG -m system\.richacl sub
+_getfattr -m system\.richacl sub
 
 chmod 775 sub
 stat -c %A+ sub
-$GETFATTR_PROG -m system\.richacl sub
+_getfattr -m system\.richacl sub
 $GETRICHACL_PROG sub
 
 touch sub/f
diff --git a/tests/generic/403 b/tests/generic/403
index 9309d713..39c64061 100755
--- a/tests/generic/403
+++ b/tests/generic/403
@@ -49,7 +49,7 @@ $SETFATTR_PROG -n trusted.small -v a $SCRATCH_MNT/file
 runfile="$tmp.getfattr"
 touch $runfile
 while [ -e $runfile ]; do
-	$GETFATTR_PROG --absolute-names -n trusted.small $SCRATCH_MNT/file \
+	_getfattr --absolute-names -n trusted.small $SCRATCH_MNT/file \
 		> /dev/null || break
 done &
 getfattr_pid=$!
diff --git a/tests/generic/454 b/tests/generic/454
index d9faf366..4a0936c5 100755
--- a/tests/generic/454
+++ b/tests/generic/454
@@ -58,7 +58,7 @@ testf() {
 
 	echo "Testing ${key} ($(hexbytes "${key}")) -> ${value}" >> $seqres.full
 
-	actual_value="$($GETFATTR_PROG --absolute-names --only-values -n "user.${key}" "${testfile}")"
+	actual_value="$(_getfattr --absolute-names --only-values -n "user.${key}" "${testfile}")"
 	if [ "${actual_value}" != "${value}" ]; then
 		echo "Key ${key} has value ${actual_value}, expected ${value}."
 	fi
@@ -127,7 +127,7 @@ setf "zerojoin_moo\xe2\x80\x8ccow.txt" "zero width joiners"
 setf "combmark_\xe1\x80\x9c\xe1\x80\xad\xe1\x80\xaf.txt" "combining marks"
 setf "combmark_\xe1\x80\x9c\xe1\x80\xaf\xe1\x80\xad.txt" "combining marks"
 
-$GETFATTR_PROG --absolute-names -d "${testfile}" >> $seqres.full
+_getfattr --absolute-names -d "${testfile}" >> $seqres.full
 
 echo "Test files"
 testf "french_caf\xc3\xa9.txt" "NFC"
@@ -175,7 +175,7 @@ testf "combmark_\xe1\x80\x9c\xe1\x80\xad\xe1\x80\xaf.txt" "combining marks"
 testf "combmark_\xe1\x80\x9c\xe1\x80\xaf\xe1\x80\xad.txt" "combining marks"
 
 echo "Uniqueness of keys?"
-crazy_keys="$($GETFATTR_PROG --absolute-names -d "${testfile}" | egrep -c '(french_|chinese_|greek_|arabic_|urk)')"
+crazy_keys="$(_getfattr --absolute-names -d "${testfile}" | egrep -c '(french_|chinese_|greek_|arabic_|urk)')"
 expected_keys=11
 test "${crazy_keys}" -ne "${expected_keys}" && echo "Expected ${expected_keys} keys, saw ${crazy_keys}."
 
diff --git a/tests/generic/489 b/tests/generic/489
index 1d3a916e..b3a0972f 100755
--- a/tests/generic/489
+++ b/tests/generic/489
@@ -58,7 +58,7 @@ $XFS_IO_PROG -c "pwrite -S 0xea 0 64K" \
 # were not lost and neither was the data we wrote.
 _flakey_drop_and_remount
 echo "File xattrs after power failure:"
-$GETFATTR_PROG --absolute-names --dump $SCRATCH_MNT/foobar | _filter_scratch
+_getfattr --absolute-names --dump $SCRATCH_MNT/foobar | _filter_scratch
 echo "File data after power failure:"
 od -t x1 $SCRATCH_MNT/foobar
 
diff --git a/tests/overlay/011 b/tests/overlay/011
index e2fedc90..1d09341b 100755
--- a/tests/overlay/011
+++ b/tests/overlay/011
@@ -56,7 +56,7 @@ $SETFATTR_PROG -n "trusted.overlay.opaque" -v "y" $upperdir/testdir
 $MOUNT_PROG -t overlay -o ro -o lowerdir=$upperdir:$lowerdir $OVL_BASE_SCRATCH_MNT $SCRATCH_MNT
 
 # Dump trusted.overlay xattr, we should not see the "opaque" xattr
-$GETFATTR_PROG -d -m overlay $SCRATCH_MNT/testdir
+_getfattr -d -m overlay $SCRATCH_MNT/testdir
 echo "Silence is golden"
 
 # success, all done
diff --git a/tests/overlay/026 b/tests/overlay/026
index 08cad42f..d0d2a5bf 100755
--- a/tests/overlay/026
+++ b/tests/overlay/026
@@ -71,7 +71,7 @@ touch $SCRATCH_MNT/testf1
 $SETFATTR_PROG -n "trusted.overlayfsrz" -v "n" \
   $SCRATCH_MNT/testf0 2>&1 | _filter_scratch
 
-$GETFATTR_PROG --absolute-names -n "trusted.overlayfsrz" \
+_getfattr --absolute-names -n "trusted.overlayfsrz" \
   $SCRATCH_MNT/testf0 2>&1 | _filter_scratch
 
 # {s,g}etfattr of "trusted.overlay.xxx" should fail.
@@ -86,7 +86,7 @@ $SETFATTR_PROG -n "trusted.overlay.fsz" -v "n" \
   $SCRATCH_MNT/testf1 2>&1 | _filter_scratch | \
   sed -e 's/permitted/supported/g'
 
-$GETFATTR_PROG --absolute-names -n "trusted.overlay.fsz" \
+_getfattr --absolute-names -n "trusted.overlay.fsz" \
   $SCRATCH_MNT/testf1 2>&1 | _filter_scratch | \
   sed -e 's/permitted/supported/g'
 
diff --git a/tests/overlay/038 b/tests/overlay/038
index 716d0fca..25f9979b 100755
--- a/tests/overlay/038
+++ b/tests/overlay/038
@@ -77,7 +77,7 @@ subdir_d=$($here/src/t_dir_type $impure_dir $impure_subdir_st_ino)
 mv $SCRATCH_MNT/test_file $impure_dir
 test_file_st_ino=$(stat -c '%i' $impure_dir/test_file)
 
-impure=$($GETFATTR_PROG --absolute-names --only-values -n 'trusted.overlay.impure' \
+impure=$(_getfattr --absolute-names --only-values -n 'trusted.overlay.impure' \
 			$upperdir/test_dir/impure_dir)
 [[ $impure == "y" ]] || echo "Impure directory missing impure xattr"
 
@@ -109,7 +109,7 @@ $here/src/t_dir_type $impure_dir $test_file_st_ino
 $here/src/t_dir_type $impure_dir $impure_subdir_st_ino
 [[ $? != 0 ]] || echo "Directory's readdir cache has stale subdir entries"
 
-impure=$($GETFATTR_PROG --absolute-names --only-values -n 'trusted.overlay.impure' \
+impure=$(_getfattr --absolute-names --only-values -n 'trusted.overlay.impure' \
 			$upperdir/test_dir/impure_dir 2>/dev/null)
 [[ -z $impure ]] || echo "Pure directory has impure xattr"
 
diff --git a/tests/overlay/041 b/tests/overlay/041
index 2c4f9fd1..277fb913 100755
--- a/tests/overlay/041
+++ b/tests/overlay/041
@@ -89,7 +89,7 @@ subdir_d=$($here/src/t_dir_type $impure_dir $impure_subdir_st_ino)
 mv $SCRATCH_MNT/test_file $impure_dir
 test_file_st_ino=$(stat -c '%i' $impure_dir/test_file)
 
-impure=$($GETFATTR_PROG --absolute-names --only-values -n 'trusted.overlay.impure' \
+impure=$(_getfattr --absolute-names --only-values -n 'trusted.overlay.impure' \
 			$upperdir/test_dir/impure_dir)
 [[ $impure == "y" ]] || echo "Impure directory missing impure xattr"
 
@@ -121,7 +121,7 @@ $here/src/t_dir_type $impure_dir $test_file_st_ino
 $here/src/t_dir_type $impure_dir $impure_subdir_st_ino
 [[ $? != 0 ]] || echo "Directory's readdir cache has stale subdir entries"
 
-impure=$($GETFATTR_PROG --absolute-names --only-values -n 'trusted.overlay.impure' \
+impure=$(_getfattr --absolute-names --only-values -n 'trusted.overlay.impure' \
 			$upperdir/test_dir/impure_dir 2>/dev/null)
 [[ -z $impure ]] || echo "Pure directory has impure xattr"
 
diff --git a/tests/overlay/046 b/tests/overlay/046
index 1c09609c..6338a383 100755
--- a/tests/overlay/046
+++ b/tests/overlay/046
@@ -57,7 +57,7 @@ check_redirect()
 	local target=$1
 	local expect=$2
 
-	value=$($GETFATTR_PROG --absolute-names --only-values -n \
+	value=$(_getfattr --absolute-names --only-values -n \
 		$OVL_XATTR_REDIRECT $target)
 
 	[[ "$value" == "$expect" ]] || echo "Redirect xattr incorrect"
@@ -67,7 +67,7 @@ check_no_redirect()
 {
 	local target=$1
 
-	value=$($GETFATTR_PROG --absolute-names -d -m \
+	value=$(_getfattr --absolute-names -d -m \
 		$OVL_XATTR_REDIRECT $target)
 
 	[[ -z "$value" ]] || echo "Redirect xattr not empty"
@@ -78,7 +78,7 @@ check_opaque()
 {
 	local target=$1
 
-	value=$($GETFATTR_PROG --absolute-names --only-values -n \
+	value=$(_getfattr --absolute-names --only-values -n \
 		$OVL_XATTR_OPAQUE $target)
 
 	[[ "$value" == "$OVL_XATTR_OPAQUE_VAL" ]] || \
diff --git a/tests/overlay/056 b/tests/overlay/056
index 778e1f6a..44ffb54a 100755
--- a/tests/overlay/056
+++ b/tests/overlay/056
@@ -64,7 +64,7 @@ check_impure()
 {
 	local target=$1
 
-	value=$($GETFATTR_PROG --absolute-names --only-values -n \
+	value=$(_getfattr --absolute-names --only-values -n \
 		$OVL_XATTR_IMPURE $target)
 
 	[[ "$value" == "$OVL_XATTR_IMPURE_VAL" ]] || echo "Missing impure xattr"
diff --git a/tests/overlay/060 b/tests/overlay/060
index 68b8776e..455b2250 100755
--- a/tests/overlay/060
+++ b/tests/overlay/060
@@ -58,7 +58,7 @@ check_metacopy()
 	local out_f target_f
 	local msg
 
-        out_f=$($GETFATTR_PROG --absolute-names --only-values -n \
+        out_f=$(_getfattr --absolute-names --only-values -n \
 		$OVL_XATTR_METACOPY $target 2>&1 | _filter_scratch)
 
 	if [ "$exist" == "y" ];then
@@ -86,7 +86,7 @@ check_redirect()
 	local target=$1
 	local expect=$2
 
-	value=$($GETFATTR_PROG --absolute-names --only-values -n \
+	value=$(_getfattr --absolute-names --only-values -n \
 		$OVL_XATTR_REDIRECT $target)
 
 	[[ "$value" == "$expect" ]] || echo "Redirect xattr incorrect. Expected=\"$expect\", actual=\"$value\""
diff --git a/tests/shared/002 b/tests/shared/002
index 30ece337..305b3227 100755
--- a/tests/shared/002
+++ b/tests/shared/002
@@ -90,7 +90,7 @@ echo "File xattrs after crash and log replay:"
 for ((i = 1; i <= $num_xattrs; i++)); do
 	name="user.attr_$(printf "%04d" $i)"
 	echo -n "$name="
-	$GETFATTR_PROG --absolute-names -n $name --only-values $SCRATCH_MNT/foo
+	_getfattr --absolute-names -n $name --only-values $SCRATCH_MNT/foo
 	echo
 done
 
diff --git a/tests/xfs/021 b/tests/xfs/021
index e600b818..336b5980 100755
--- a/tests/xfs/021
+++ b/tests/xfs/021
@@ -41,9 +41,9 @@ _attr()
 	return $exit
 }
 
-_getfattr()
+do_getfattr()
 {
-	${GETFATTR_PROG} $* 2>$tmp.err >$tmp.out
+	_getfattr $* 2>$tmp.err >$tmp.out
 	exit=$?
 	sed \
 	    -e "s#$SCRATCH_MNT[^ .:]*#<TESTFILE>#g" \
@@ -79,7 +79,7 @@ echo "*** make test file 1"
 touch $testfile.1
 echo "v1" | _attr -s "a1" $testfile.1 >/dev/null
 echo "v2--" | _attr -s "a2--" $testfile.1 >/dev/null
-_getfattr --absolute-names $testfile.1
+do_getfattr --absolute-names $testfile.1
 inum_1=`ls -li $testfile.1 | $AWK_PROG '{ print $1 }'`
 
 echo "*** make test file 2"
@@ -89,7 +89,7 @@ echo "value_1" | _attr -s "a1" $testfile.2 >/dev/null
 echo "value_2" | _attr -s "a2-----" $testfile.2 >/dev/null
 ( echo start; POSIXLY_CORRECT=yes dd if=/dev/zero bs=65525 count=1; echo end )\
 	| _attr -s "a3" $testfile.2 >/dev/null
-_getfattr --absolute-names $testfile.2
+do_getfattr --absolute-names $testfile.2
 
 # print name and size from 1st line of output
 _attr -g "a3" $testfile.2 > $tmp.hahahahaplonk
diff --git a/tests/xfs/187 b/tests/xfs/187
index e705cf55..b666f94d 100755
--- a/tests/xfs/187
+++ b/tests/xfs/187
@@ -105,7 +105,7 @@ _scratch_mount -o noattr2
 cd $SCRATCH_MNT
 touch testfile
 $SETFATTR_PROG -n user.test -v 0xbabe testfile
-$GETFATTR_PROG testfile
+_getfattr testfile
 cd $here
 $UMOUNT_PROG $SCRATCH_MNT
 _scratch_xfs_db -r -c version 2>&1 | _filter_version
-- 
2.14.4
