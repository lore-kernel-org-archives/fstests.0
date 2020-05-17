Return-Path: <SRS0=PZom=67=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888D5C433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 17 May 2020 15:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E59F207D4
	for <linux-fstests@archiver.kernel.org>; Sun, 17 May 2020 15:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEQP5q (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 17 May 2020 11:57:46 -0400
Received: from out20-98.mail.aliyun.com ([115.124.20.98]:35291 "EHLO
        out20-98.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgEQP5p (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 May 2020 11:57:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436283|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0573199-0.000526368-0.942154;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03267;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.HZsYq3C_1589731049;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.HZsYq3C_1589731049)
          by smtp.aliyun-inc.com(10.147.43.230);
          Sun, 17 May 2020 23:57:29 +0800
Date:   Sun, 17 May 2020 23:57:29 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Bill O'Donnell <billodo@redhat.com>
Subject: Re: [PATCH 3/3 V2] fstests: test restricted file access sysctls
Message-ID: <20200517155729.GE2704@desktop>
References: <99a3164b-ee00-113c-e0aa-41eab9633364@redhat.com>
 <8e007b9f-9fdb-c9dd-c2b0-dd273d24a517@redhat.com>
 <646dee70-4758-99cc-6164-36c640126616@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <646dee70-4758-99cc-6164-36c640126616@redhat.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 06, 2020 at 02:29:42PM -0500, Eric Sandeen wrote:
> This tests the fs.protected_regular and fs.protected_fifos
> sysctls which restrict access behavior in sticky world-writable
> directories as documented in the kernel at 
> Documentation/admin-guide/sysctl/fs.rst
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> V2: Don't count on nonzero exit from xfs_io since that is almost
> always broken and was only recently fixed and may end up broken
> again... collect & check any emitted error messages instead.
> 
> diff --git a/tests/generic/901 b/tests/generic/901
> new file mode 100755
> index 00000000..9bb658e0
> --- /dev/null
> +++ b/tests/generic/901
> @@ -0,0 +1,133 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 YOUR NAME HERE.  All Rights Reserved.

Copyright info is not correct :)

> +#
> +# FS QA Test 900
> +#
> +# Test protected_symlink and protected_hardlink ioctls

Stale test description?

> +#
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	rm -rf $TEST_DIR/$seq
> +	sysctl -qw fs.protected_regular=$REGULAR_PROTECTION
> +	sysctl -qw fs.protected_fifos=$FIFO_PROTECTION

Only restore them only if the variables are set.

Thanks,
Eryu

> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +_require_sysctl fs.protected_regular
> +_require_sysctl fs.protected_fifos
> +_require_user fsgqa
> +_require_user fsgqa2
> +
> +USER1=fsgqa
> +USER2=fsgqa2
> +
> +# Save current system state to reset when done
> +REGULAR_PROTECTION=`sysctl -n fs.protected_regular`
> +FIFO_PROTECTION=`sysctl -n fs.protected_fifos`
> +
> +test_access()
> +{
> +	FILENAME=$1
> +
> +	# sticky dir is world & group writable:
> +	echo "= group & world writable dir"
> +	chmod og+w $TEST_DIR/$seq/sticky_dir
> +	# "open -f" opens O_CREAT
> +	result=`sudo -u $USER2 $XFS_IO_PROG -c "open -f $TEST_DIR/$seq/sticky_dir/$FILENAME" 2>&1`
> +	if [ -z "$result" ]; then
> +		echo "successfully opened $FILENAME"
> +	else
> +		echo $result | _filter_test_dir
> +	fi
> +	# sticky dir is only group writable:
> +	echo "= only group writable dir"
> +	chmod o-w $TEST_DIR/$seq/sticky_dir
> +	result=`sudo -u $USER2 $XFS_IO_PROG -c "open -f $TEST_DIR/$seq/sticky_dir/$FILENAME" 2>&1`
> +	if [ -z "$result" ]; then
> +		echo "successfully opened $FILENAME"
> +	else
> +		echo $result | _filter_test_dir
> +	fi
> +}
> +
> +setup_tree()
> +{
> +	# Create sticky dir owned by $USER2
> +	mkdir -p $TEST_DIR/$seq
> +	mkdir -p $TEST_DIR/$seq/sticky_dir
> +	chmod 1777 $TEST_DIR/$seq/sticky_dir
> +	chown $USER2.$USER2 $TEST_DIR/$seq/sticky_dir
> +
> +	# Create file & fifo in that dir owned by $USER1, and open
> +	# normal read/write privs for world & group
> +	$XFS_IO_PROG -c "open -f $TEST_DIR/$seq/sticky_dir/file"
> +	chown $USER1.$USER1 $TEST_DIR/$seq/sticky_dir/file
> +	chmod o+rw $TEST_DIR/$seq/sticky_dir/file
> +
> +	mkfifo $TEST_DIR/$seq/sticky_dir/fifo
> +	chown $USER1.$USER1 $TEST_DIR/$seq/sticky_dir/fifo
> +	chmod o+rw $TEST_DIR/$seq/sticky_dir/fifo
> +}
> +
> +setup_tree
> +
> +# First test fs.protected_regular
> +# With protection set to 1, O_CREAT opens in a world-writable sticky
> +# directory should fail if the file exists, is owned by another, and
> +# file owner != dir owner
> +#
> +# With protection set to 2, the same goes for group-writable
> +# sticky directories
> +
> +echo "== Test file open when owned by another and file owner != dir owner"
> +sysctl -w fs.protected_regular=0
> +test_access file
> +sysctl -w fs.protected_regular=1
> +test_access file
> +sysctl -w fs.protected_regular=2
> +test_access file
> +
> +echo
> +
> +# Now test fs.protected_fifos
> +# With protection set to 1, O_CREAT opens in a world-writable sticky
> +# directory should fail if the fifo exists, is owned by another, and
> +# file owner != dir owner
> +#
> +# With protection set to 2, the same goes for group-writable
> +# sticky directories
> +echo "== Test fifo open when owned by another and fifo owner != dir owner"
> +sysctl -w fs.protected_fifos=0
> +test_access fifo
> +sysctl -w fs.protected_fifos=1
> +test_access fifo
> +sysctl -w fs.protected_fifos=2
> +test_access fifo
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/901.out b/tests/generic/901.out
> new file mode 100644
> index 00000000..af774ca5
> --- /dev/null
> +++ b/tests/generic/901.out
> @@ -0,0 +1,34 @@
> +QA output created by 901
> +== Test file open when owned by another and file owner != dir owner
> +fs.protected_regular = 0
> += group & world writable dir
> +successfully opened file
> += only group writable dir
> +successfully opened file
> +fs.protected_regular = 1
> += group & world writable dir
> +TEST_DIR/901/sticky_dir/file: Permission denied
> += only group writable dir
> +successfully opened file
> +fs.protected_regular = 2
> += group & world writable dir
> +TEST_DIR/901/sticky_dir/file: Permission denied
> += only group writable dir
> +TEST_DIR/901/sticky_dir/file: Permission denied
> +
> +== Test fifo open when owned by another and fifo owner != dir owner
> +fs.protected_fifos = 0
> += group & world writable dir
> +successfully opened fifo
> += only group writable dir
> +successfully opened fifo
> +fs.protected_fifos = 1
> += group & world writable dir
> +TEST_DIR/901/sticky_dir/fifo: Permission denied
> += only group writable dir
> +successfully opened fifo
> +fs.protected_fifos = 2
> += group & world writable dir
> +TEST_DIR/901/sticky_dir/fifo: Permission denied
> += only group writable dir
> +TEST_DIR/901/sticky_dir/fifo: Permission denied
> diff --git a/tests/generic/group b/tests/generic/group
> index 782b0cc3..d1e529d5 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -599,3 +599,4 @@
>  595 auto quick encrypt
>  596 auto quick
>  900 auto quick perms
> +901 auto quick perms
