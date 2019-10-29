Return-Path: <SRS0=gkCv=YW=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CE9CA9EAE
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Oct 2019 22:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0448C205C9
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Oct 2019 22:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q+ZD99X2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbfJ2Wbx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 29 Oct 2019 18:31:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53628 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2Wbx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 29 Oct 2019 18:31:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TMONO8162581;
        Tue, 29 Oct 2019 22:31:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=99at8NZ97RZt4BYAtaIquqfqoRKquMHFNdD9pNWtNJc=;
 b=Q+ZD99X2g8DpvLPdtiOSeLtdqApV7ixXuMj64rgBzk1BwfFEF7hc4+wTzKsE6Re1cVI+
 TGqyiTc04UoHiN+sUmrVrVkIpcH+33nK47LgrqY4Ocmx8uVCUdgWi9LpsaJGOb2TtnEK
 H1t0p8SbolgQnJFX4zAEj4UjjyB349ImeZcGITzo29asN0CyC45k+wTH13cKDDCXlSQb
 6dQ39s5o65Tc51jdkZ4u+x8Ynzjlx8WI0zP00UsxK/KOj9fvMUc6fCxZo3nMXimIq3Kt
 4hfth8NjFqwosGgqKFpxrQh6rweUW6rVWo6zQH6By/mpwdcfZovosBibp3swlbuOq0Ej og== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2vxwhfg5d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 22:31:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TMS5ve125131;
        Tue, 29 Oct 2019 22:29:50 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2vxwhut0s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 22:29:50 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9TMTnEN022013;
        Tue, 29 Oct 2019 22:29:49 GMT
Received: from localhost (/10.159.133.249)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 15:29:49 -0700
Date:   Tue, 29 Oct 2019 15:29:48 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: [PATCH] xfs: make sure the kernel and repair tools catch bad names
Message-ID: <20191029222948.GA15224@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290194
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290194
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Make sure we actually catch bad names in the kernel.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/749     |  137 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/749.out |   50 +++++++++++++++++++
 tests/xfs/group   |    1 
 3 files changed, 188 insertions(+)
 create mode 100755 tests/xfs/749
 create mode 100644 tests/xfs/749.out

diff --git a/tests/xfs/749 b/tests/xfs/749
new file mode 100755
index 00000000..a8353cc2
--- /dev/null
+++ b/tests/xfs/749
@@ -0,0 +1,137 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-newer
+# Copyright (c) 2019, Oracle and/or its affiliates.  All Rights Reserved.
+#
+# FS QA Test No. 749
+#
+# See if we catch corrupt directory names or attr names with nulls or slashes
+# in them.
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	$UMOUNT_PROG $mntpt > /dev/null 2>&1
+	test -n "$loopdev" && _destroy_loop_device $loopdev > /dev/null 2>&1
+	rm -r -f $imgfile $mntpt $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+_supported_fs xfs
+_supported_os Linux
+_require_test
+_require_attrs
+_require_xfs_mkfs_crc
+_disable_dmesg_check
+
+rm -f $seqres.full
+
+imgfile=$TEST_DIR/img-$seq
+mntpt=$TEST_DIR/mount-$seq
+testdir=$mntpt/testdir
+testfile=$mntpt/testfile
+nullstr="too_many_beans"
+slashstr="are_bad_for_you"
+test_names=("something" "$nullstr" "$slashstr" "another")
+
+# Format image file w/o crcs so we can sed the image file
+$XFS_IO_PROG -f -c 'truncate 40m' $imgfile
+loopdev=$(_create_loop_device $imgfile)
+MKFS_OPTIONS="-m crc=0" _mkfs_dev $loopdev >> $seqres.full
+
+# Mount image file
+mkdir -p $mntpt
+_mount $loopdev $mntpt
+
+echo "creating entries" >> $seqres.full
+
+# Create directory entries
+mkdir -p $testdir
+for name in "${test_names[@]}"; do
+	touch "$testdir/f_$name"
+done
+
+# Create attrs
+touch $testfile
+for name in "${test_names[@]}"; do
+	$ATTR_PROG -s "a_$name" -V heh $testfile >> $seqres.full
+done
+
+# Now put in the first part of the garbage names to make sure we can't
+# access those directly
+test_names+=("too_many" "are_bad/for_you")
+
+access_stuff() {
+	ls $testdir
+	$ATTR_PROG -l $testfile
+
+	for name in "${test_names[@]}"; do
+		ls "$testdir/f_$name"
+		$ATTR_PROG -g "a_$name" $testfile
+	done
+}
+
+# Does it work?
+echo "++ ACCESSING GOOD METADATA" | tee -a $seqres.full
+access_stuff > $tmp.log 2>&1
+cat $tmp.log >> $seqres.full
+cat $tmp.log | _filter_test_dir
+
+# Corrupt the entries
+$UMOUNT_PROG $mntpt
+_destroy_loop_device $loopdev
+cp $imgfile $imgfile.old
+sed -b \
+	-e "s/$nullstr/too_many\x00beans/g" \
+	-e "s/$slashstr/are_bad\/for_you/g" \
+	-i $imgfile
+test "$(md5sum < $imgfile)" != "$(md5sum < $imgfile.old)" ||
+	_fail "sed failed to change the image file?"
+rm -f $imgfile.old
+loopdev=$(_create_loop_device $imgfile)
+_mount $loopdev $mntpt
+
+# Try to access the corrupt metadata
+echo "++ ACCESSING BAD METADATA" | tee -a $seqres.full
+access_stuff > $tmp.log 2>&1
+cat $tmp.log >> $seqres.full
+cat $tmp.log | _filter_test_dir | sed -e '/Could not list/d'
+
+echo "does scrub complain?" >> $seqres.full
+
+# Does scrub complain about this?
+if _supports_xfs_scrub $mntpt $loopdev; then
+	$XFS_SCRUB_PROG -n $mntpt >> $seqres.full 2>&1
+	res=$?
+	test $((res & 1)) -eq 0 && \
+		echo "scrub failed to report corruption ($res)"
+fi
+
+echo "does repair complain?" >> $seqres.full
+
+# Does repair complain about this?
+$UMOUNT_PROG $mntpt
+$XFS_REPAIR_PROG -n $loopdev >> $seqres.full 2>&1
+res=$?
+test $res -eq 1 || \
+	echo "repair failed to report corruption ($res)"
+
+_destroy_loop_device $loopdev
+loopdev=
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/749.out b/tests/xfs/749.out
new file mode 100644
index 00000000..ab7b7dc6
--- /dev/null
+++ b/tests/xfs/749.out
@@ -0,0 +1,50 @@
+QA output created by 749
+++ ACCESSING GOOD METADATA
+f_another
+f_are_bad_for_you
+f_something
+f_too_many_beans
+Attribute "a_something" has a 3 byte value for TEST_DIR/mount-749/testfile
+Attribute "a_too_many_beans" has a 3 byte value for TEST_DIR/mount-749/testfile
+Attribute "a_are_bad_for_you" has a 3 byte value for TEST_DIR/mount-749/testfile
+Attribute "a_another" has a 3 byte value for TEST_DIR/mount-749/testfile
+TEST_DIR/mount-749/testdir/f_something
+Attribute "a_something" had a 3 byte value for TEST_DIR/mount-749/testfile:
+heh
+TEST_DIR/mount-749/testdir/f_too_many_beans
+Attribute "a_too_many_beans" had a 3 byte value for TEST_DIR/mount-749/testfile:
+heh
+TEST_DIR/mount-749/testdir/f_are_bad_for_you
+Attribute "a_are_bad_for_you" had a 3 byte value for TEST_DIR/mount-749/testfile:
+heh
+TEST_DIR/mount-749/testdir/f_another
+Attribute "a_another" had a 3 byte value for TEST_DIR/mount-749/testfile:
+heh
+ls: cannot access 'TEST_DIR/mount-749/testdir/f_too_many': No such file or directory
+attr_get: No data available
+Could not get "a_too_many" for TEST_DIR/mount-749/testfile
+ls: cannot access 'TEST_DIR/mount-749/testdir/f_are_bad/for_you': No such file or directory
+attr_get: No data available
+Could not get "a_are_bad/for_you" for TEST_DIR/mount-749/testfile
+++ ACCESSING BAD METADATA
+ls: reading directory 'TEST_DIR/mount-749/testdir': Structure needs cleaning
+f_something
+attr_list: Structure needs cleaning
+TEST_DIR/mount-749/testdir/f_something
+Attribute "a_something" had a 3 byte value for TEST_DIR/mount-749/testfile:
+heh
+ls: cannot access 'TEST_DIR/mount-749/testdir/f_too_many_beans': No such file or directory
+attr_get: No data available
+Could not get "a_too_many_beans" for TEST_DIR/mount-749/testfile
+ls: cannot access 'TEST_DIR/mount-749/testdir/f_are_bad_for_you': No such file or directory
+attr_get: No data available
+Could not get "a_are_bad_for_you" for TEST_DIR/mount-749/testfile
+TEST_DIR/mount-749/testdir/f_another
+Attribute "a_another" had a 3 byte value for TEST_DIR/mount-749/testfile:
+heh
+ls: cannot access 'TEST_DIR/mount-749/testdir/f_too_many': No such file or directory
+attr_get: No data available
+Could not get "a_too_many" for TEST_DIR/mount-749/testfile
+ls: cannot access 'TEST_DIR/mount-749/testdir/f_are_bad/for_you': No such file or directory
+Attribute "a_are_bad/for_you" had a 3 byte value for TEST_DIR/mount-749/testfile:
+heh
diff --git a/tests/xfs/group b/tests/xfs/group
index f4ebcd8c..9600cb4e 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -507,3 +507,4 @@
 509 auto ioctl
 510 auto ioctl quick
 511 auto quick quota
+749 auto quick fuzzers
