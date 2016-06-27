Received: from mx1.redhat.com ([209.132.183.28]:53679 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbcF0Wka (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 27 Jun 2016 18:40:30 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7294063E0E
	for <fstests@vger.kernel.org>; Mon, 27 Jun 2016 22:40:30 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v7 2/3] generic/093,099,237 shared/051: Add / use _require_runas and _runas
Date: Tue, 28 Jun 2016 00:40:21 +0200
Message-Id: <1467067222-18286-3-git-send-email-agruenba@redhat.com>
In-Reply-To: <1467067222-18286-1-git-send-email-agruenba@redhat.com>
References: <1467067222-18286-1-git-send-email-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

Add _require_runas and _runas functions instead of open-coding it in
test cases.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 common/rc         | 10 ++++++++++
 tests/generic/093 | 14 ++++++--------
 tests/generic/099 | 45 +++++++++++++++++++++------------------------
 tests/generic/237 |  6 ++----
 tests/shared/051  | 48 +++++++++++++++++++++++-------------------------
 5 files changed, 62 insertions(+), 61 deletions(-)

diff --git a/common/rc b/common/rc
index 3a9c4d1..4b6ebe5 100644
--- a/common/rc
+++ b/common/rc
@@ -1990,6 +1990,16 @@ _require_seek_data_hole()
         _notrun "File system does not support llseek(2) SEEK_DATA/HOLE"
 }
 
+_require_runas()
+{
+	_require_test_program "runas"
+}
+
+_runas()
+{
+	"$here/src/runas" "$@"
+}
+
 # check that a FS on a device is mounted
 # if so, return mount point
 #
diff --git a/tests/generic/093 b/tests/generic/093
index af58888..824e9b2 100755
--- a/tests/generic/093
+++ b/tests/generic/093
@@ -30,7 +30,6 @@ seqres=$RESULT_DIR/$seq
 
 here=`pwd`
 tmp=/tmp/$$
-runas=$here/src/runas
 status=1	# FAILure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -60,8 +59,7 @@ _supported_os IRIX
 
 _require_test
 _require_attrs
-
-[ -x $runas ] || _notrun "$runas executable not found"
+_require_runas
 
 rm -f $seqres.full
 
@@ -101,7 +99,7 @@ echo "----"
 
 echo "append to file as user without caps"
 # in particular user doesn't have FSETID or SETFCAP
-$runas -u $uid $tmp.append
+_runas -u $uid $tmp.append
 
 echo "cat file"
 echo "----"
@@ -113,7 +111,7 @@ ls -P $file | _testfilter
 
 # try again when it doesn't have the EA
 echo "append to file as user without caps a 2nd time"
-$runas -u $uid $tmp.append
+_runas -u $uid $tmp.append
 
 echo "ls -P on file"
 ls -P $file | _testfilter
@@ -128,7 +126,7 @@ chmod 700 $file
 chown root $file 
 
 echo "as non-root try to append to file"
-$runas -u $uid $tmp.append 2>&1 | _filefilter
+_runas -u $uid $tmp.append 2>&1 | _filefilter
 
 echo "restore perms on file"
 chmod 777 $file
@@ -140,7 +138,7 @@ echo "list EA on file"
 ${ATTR_PROG} -R -l $file | _filefilter
 
 echo "as non-root try to append to file"
-$runas -u $uid $tmp.append 2>&1 | _filefilter
+_runas -u $uid $tmp.append 2>&1 | _filefilter
 
 echo "list EA on file"
 ${ATTR_PROG} -R -l $file | _filefilter
@@ -148,7 +146,7 @@ ${ATTR_PROG} -R -l $file | _filefilter
 chown $uid $file
 chmod ugo+w $TEST_DIR
 echo "as non-root call writemod"
-$runas -u $uid src/writemod $file 2>&1 | _filefilter
+_runas -u $uid src/writemod $file 2>&1 | _filefilter
 
 echo "cat file"
 echo "----"
diff --git a/tests/generic/099 b/tests/generic/099
index b544fe2..4af588c 100755
--- a/tests/generic/099
+++ b/tests/generic/099
@@ -37,8 +37,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 . ./common/filter
 . ./common/attr
 
-runas=$here/src/runas
-
 TARGET_DIR=$SCRATCH_MNT
 [ "$FSTYP" == "xfs" ] && TARGET_DIR=$TEST_DIR
 
@@ -83,8 +81,7 @@ _supported_os IRIX
 _require_test
 _acl_setup_ids
 _require_acls
-
-[ -x $runas ] || _notrun "$runas executable not found"
+_require_runas
 
 # get dir
 #export FILE_SYS=xfs
@@ -137,35 +134,35 @@ chacl u::r-x,g::---,o::--- file1 2>&1
 _acl_list file1
 # change to owner
 echo "Expect to PASS" 
-$runas -u $acl1 -g $acl1 ./file1 2>&1
+_runas -u $acl1 -g $acl1 ./file1 2>&1
 echo "Expect to FAIL" 
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 
 echo ""
 echo "--- Test group permissions ---"
 chacl u::---,g::r-x,o::--- file1 2>&1
 _acl_list file1
 echo "Expect to FAIL - acl1 is owner" 
-$runas -u $acl1 -g $acl1 ./file1 2>&1
+_runas -u $acl1 -g $acl1 ./file1 2>&1
 echo "Expect to PASS - acl2 matches group" 
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 echo "Expect to PASS - acl2 matches sup group" 
-$runas -u $acl2 -g $acl3 -s $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl3 -s $acl2 ./file1 2>&1
 echo "Expect to FAIL - acl3 is not in group" 
-$runas -u $acl3 -g $acl3 ./file1 2>&1
+_runas -u $acl3 -g $acl3 ./file1 2>&1
 
 echo ""
 echo "--- Test other permissions ---"
 chacl u::---,g::---,o::r-x file1 2>&1
 _acl_list file1
 echo "Expect to FAIL - acl1 is owner" 
-$runas -u $acl1 -g $acl1 ./file1 2>&1
+_runas -u $acl1 -g $acl1 ./file1 2>&1
 echo "Expect to FAIL - acl2 is in group" 
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 echo "Expect to FAIL - acl2 is in sup. group" 
-$runas -u $acl2 -g $acl3 -s $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl3 -s $acl2 ./file1 2>&1
 echo "Expect to PASS - acl3 is not owner or in group" 
-$runas -u $acl3 -g $acl3 ./file1 2>&1
+_runas -u $acl3 -g $acl3 ./file1 2>&1
 
 #-------------------------------------------------------
 
@@ -181,9 +178,9 @@ _acl_list file1
 echo "Expect to PASS - USER ACE matches user"
 chacl u::---,g::---,o::---,u:$acl2:r-x,m::rwx file1 2>&1
 _acl_list file1
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 echo "Expect to FAIL - USER ACE does not match user"
-$runas -u $acl3 -g $acl3 ./file1 2>&1
+_runas -u $acl3 -g $acl3 ./file1 2>&1
 
 echo ""
 echo "--- Test adding a GROUP ACE ---"
@@ -194,11 +191,11 @@ _acl_list file1
 chacl u::---,g::---,o::---,g:$acl2:r-x,m::rwx file1 2>&1
 _acl_list file1 | _acl_filter_id
 echo "Expect to PASS - GROUP ACE matches group"
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 echo "Expect to PASS - GROUP ACE matches sup group"
-$runas -u $acl2 -g $acl1 -s $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl1 -s $acl2 ./file1 2>&1
 echo "Expect to FAIL - GROUP ACE does not match group"
-$runas -u $acl3 -g $acl3 ./file1 2>&1
+_runas -u $acl3 -g $acl3 ./file1 2>&1
 
 #-------------------------------------------------------
 
@@ -209,17 +206,17 @@ echo "--- Test MASK ---"
 chacl u::---,g::---,o::---,g:$acl2:r-x,m::-w- file1 2>&1
 _acl_list file1
 echo "Expect to FAIL as MASK prohibits execution"
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 
 # user
 chacl u::---,g::---,o::---,u:$acl2:r-x,m::-w- file1 2>&1
 echo "Expect to FAIL as MASK prohibits execution"
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 
 # user
 chacl u::---,g::---,o::---,u:$acl2:r-x,m::r-x file1 2>&1
 echo "Expect to PASS as MASK allows execution"
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 
 #-------------------------------------------------------
 
@@ -228,11 +225,11 @@ echo "--- Test ACE priority ---"
 
 chacl o::rwx,g::rwx,u:$acl1:rwx,u::---,m::rwx file1 2>&1
 echo "Expect to FAIL as should match on owner"
-$runas -u $acl1 -g $acl2 ./file1 2>&1
+_runas -u $acl1 -g $acl2 ./file1 2>&1
 
 chacl o::---,g::---,u:$acl2:rwx,u::---,m::rwx file1 2>&1
 echo "Expect to PASS as should match on user"
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 
 #-------------------------------------------------------
 
diff --git a/tests/generic/237 b/tests/generic/237
index 75b1b55..23c07b0 100755
--- a/tests/generic/237
+++ b/tests/generic/237
@@ -29,7 +29,6 @@ echo "QA output created by $seq"
 
 here=`pwd`
 tmp=/tmp/$$
-runas=$here/src/runas
 status=1        # FAILure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -50,8 +49,7 @@ _supported_fs generic
 # only Linux supports fallocate
 _supported_os Linux
 _require_test
-
-[ -x $runas ] || _notrun "$runas executable not found"
+_require_runas
 
 rm -f $seqres.full
 
@@ -68,7 +66,7 @@ touch file1
 chown $acl1.$acl1 file1
 
 echo "Expect to FAIL"
-$runas -u $acl2 -g $acl2 -- setfacl -m u::rwx file1 2>&1 | sed 's/^setfacl: \/.*file1: Operation not permitted$/setfacl: file1: Operation not permitted/'
+_runas -u $acl2 -g $acl2 -- setfacl -m u::rwx file1 2>&1 | sed 's/^setfacl: \/.*file1: Operation not permitted$/setfacl: file1: Operation not permitted/'
 
 echo "Test over."
 # success, all done
diff --git a/tests/shared/051 b/tests/shared/051
index 1b2d2cf..298838e 100755
--- a/tests/shared/051
+++ b/tests/shared/051
@@ -27,7 +27,6 @@ seqres=$RESULT_DIR/$seq
 
 here=`pwd`
 tmp=/tmp/$$
-runas=$here/src/runas
 status=1	# FAILure is the default!
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -71,8 +70,7 @@ _cleanup()
 _supported_fs xfs udf
 _supported_os Linux
 _require_test
-
-[ -x $runas ] || _notrun "$runas executable not found"
+_require_runas
 
 rm -f $seqres.full
 
@@ -128,35 +126,35 @@ chacl u::r-x,g::---,o::--- file1 2>&1
 chacl -l file1 | _acl_filter_id
 # change to owner
 echo "Expect to PASS" 
-$runas -u $acl1 -g $acl1 ./file1 2>&1
+_runas -u $acl1 -g $acl1 ./file1 2>&1
 echo "Expect to FAIL" 
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 
 echo ""
 echo "--- Test group permissions ---"
 chacl u::---,g::r-x,o::--- file1 2>&1
 chacl -l file1 | _acl_filter_id
 echo "Expect to FAIL - acl1 is owner" 
-$runas -u $acl1 -g $acl1 ./file1 2>&1
+_runas -u $acl1 -g $acl1 ./file1 2>&1
 echo "Expect to PASS - acl2 matches group" 
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 echo "Expect to PASS - acl2 matches sup group" 
-$runas -u $acl2 -g $acl3 -s $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl3 -s $acl2 ./file1 2>&1
 echo "Expect to FAIL - acl3 is not in group" 
-$runas -u $acl3 -g $acl3 ./file1 2>&1
+_runas -u $acl3 -g $acl3 ./file1 2>&1
 
 echo ""
 echo "--- Test other permissions ---"
 chacl u::---,g::---,o::r-x file1 2>&1
 chacl -l file1 | _acl_filter_id
 echo "Expect to FAIL - acl1 is owner" 
-$runas -u $acl1 -g $acl1 ./file1 2>&1
+_runas -u $acl1 -g $acl1 ./file1 2>&1
 echo "Expect to FAIL - acl2 is in group" 
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 echo "Expect to FAIL - acl2 is in sup. group" 
-$runas -u $acl2 -g $acl3 -s $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl3 -s $acl2 ./file1 2>&1
 echo "Expect to PASS - acl3 is not owner or in group" 
-$runas -u $acl3 -g $acl3 ./file1 2>&1
+_runas -u $acl3 -g $acl3 ./file1 2>&1
 
 #-------------------------------------------------------
 
@@ -172,9 +170,9 @@ chacl -l file1 | _acl_filter_id
 echo "Expect to PASS - USER ACE matches user"
 chacl u::---,g::---,o::---,u:$acl2:r-x,m::rwx file1 2>&1
 chacl -l file1 | _acl_filter_id
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 echo "Expect to FAIL - USER ACE does not match user"
-$runas -u $acl3 -g $acl3 ./file1 2>&1
+_runas -u $acl3 -g $acl3 ./file1 2>&1
 
 echo ""
 echo "--- Test adding a GROUP ACE ---"
@@ -185,11 +183,11 @@ chacl -l file1 | _acl_filter_id
 chacl u::---,g::---,o::---,g:$acl2:r-x,m::rwx file1 2>&1
 chacl -l file1 | _acl_filter_id
 echo "Expect to PASS - GROUP ACE matches group"
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 echo "Expect to PASS - GROUP ACE matches sup group"
-$runas -u $acl2 -g $acl1 -s $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl1 -s $acl2 ./file1 2>&1
 echo "Expect to FAIL - GROUP ACE does not match group"
-$runas -u $acl3 -g $acl3 ./file1 2>&1
+_runas -u $acl3 -g $acl3 ./file1 2>&1
 
 #-------------------------------------------------------
 
@@ -200,17 +198,17 @@ echo "--- Test MASK ---"
 chacl u::---,g::---,o::---,g:$acl2:r-x,m::-w- file1 2>&1
 chacl -l file1 | _acl_filter_id
 echo "Expect to FAIL as MASK prohibits execution"
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 
 # user
 chacl u::---,g::---,o::---,u:$acl2:r-x,m::-w- file1 2>&1
 echo "Expect to FAIL as MASK prohibits execution"
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 
 # user
 chacl u::---,g::---,o::---,u:$acl2:r-x,m::r-x file1 2>&1
 echo "Expect to PASS as MASK allows execution"
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 
 #-------------------------------------------------------
 
@@ -219,11 +217,11 @@ echo "--- Test ACE priority ---"
 
 chacl o::rwx,g::rwx,u:$acl1:rwx,u::---,m::rwx file1 2>&1
 echo "Expect to FAIL as should match on owner"
-$runas -u $acl1 -g $acl2 ./file1 2>&1
+_runas -u $acl1 -g $acl2 ./file1 2>&1
 
 chacl o::---,g::---,u:$acl2:rwx,u::---,m::rwx file1 2>&1
 echo "Expect to PASS as should match on user"
-$runas -u $acl2 -g $acl2 ./file1 2>&1
+_runas -u $acl2 -g $acl2 ./file1 2>&1
 
 #-------------------------------------------------------
 
@@ -293,10 +291,10 @@ done
 popd >/dev/null
 chown -R 12345.54321 root
 echo "Change #1..."
-$runas -u 12345 -g 54321 -- chacl -r u::rwx,g::-w-,o::--x root
+_runas -u 12345 -g 54321 -- chacl -r u::rwx,g::-w-,o::--x root
 find root -print | xargs chacl -l
 echo "Change #2..."
-$runas -u 12345 -g 54321 -- chacl -r u::---,g::---,o::--- root
+_runas -u 12345 -g 54321 -- chacl -r u::---,g::---,o::--- root
 find root -print | xargs chacl -l
 
 #-------------------------------------------------------
-- 
2.5.5

