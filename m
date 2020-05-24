Return-Path: <SRS0=tq7v=7G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808F0C433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 24 May 2020 15:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6797620787
	for <linux-fstests@archiver.kernel.org>; Sun, 24 May 2020 15:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgEXPRA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 May 2020 11:17:00 -0400
Received: from out20-62.mail.aliyun.com ([115.124.20.62]:45982 "EHLO
        out20-62.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729776AbgEXPQ7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 May 2020 11:16:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07454326|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0176242-0.000679014-0.981697;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16368;MF=guan@eryu.me;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.HcxzAG4_1590333415;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.HcxzAG4_1590333415)
          by smtp.aliyun-inc.com(10.147.44.145);
          Sun, 24 May 2020 23:16:55 +0800
Date:   Sun, 24 May 2020 23:16:55 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 2/5] fstests: test restricted symlinks & hardlinks sysctls
Message-ID: <20200524151544.GA3363@desktop>
References: <91639515-d639-c155-7cc8-660536b75257@redhat.com>
 <8640243b-8056-a81a-9c23-d19c4e0dc426@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8640243b-8056-a81a-9c23-d19c4e0dc426@redhat.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 18, 2020 at 11:14:43AM -0500, Eric Sandeen wrote:
> This tests the fs.protected_symlinks and fs.protected_hardlinks
> sysctls which restrict links behavior in sticky world-writable
> directories as documented in the kernel at
> Documentation/admin-guide/sysctl/fs.rst
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> V2: many fixes requested by Eryu
> update copyright
> reset sysctl only if saved
> switch to _user_do
> fix test description in comments

Thanks a lot for the update, Eric!

> 
>  tests/generic/900     | 115 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/900.out |  14 +++++
>  tests/generic/group   |   1 +
>  3 files changed, 130 insertions(+)
>  create mode 100755 tests/generic/900
>  create mode 100644 tests/generic/900.out
> 
> diff --git a/tests/generic/900 b/tests/generic/900
> new file mode 100755
> index 00000000..fd54fa4e
> --- /dev/null
> +++ b/tests/generic/900
> @@ -0,0 +1,115 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 900
> +#
> +# Test protected_symlink and protected_hardlink sysctls
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
> +	[ ! -z "$SYMLINK_PROTECTION" ] \
> +		&& sysctl -qw fs.protected_symlinks=$SYMLINK_PROTECTION
> +	[ ! -z "$HARDLINK_PROTECTION" ] \
> +		&& sysctl -qw fs.protected_hardlinks=$HARDLINK_PROTECTION
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
> +_require_sysctl_variable fs.protected_symlinks
> +_require_sysctl_variable fs.protected_hardlinks
> +_require_user 123456-fsgqa

The su in _require_user prints warnings about user name starts with
digit and test fails like:

 + User or group name "123456-fsgqa" starts with a digit, accepting for compatibility.

So I discarded the output of _require_user here, also in generic/901.

_require_user 123456-fsgqa >/dev/null 2>&1

Thanks,
Eryu

> +# Do this SECOND so that qa_user is fsgqa, and _do_user uses that account
> +_require_user fsgqa
> +
> +OWNER=123456-fsgqa
> +OTHER=fsgqa
> +
> +# Save current system state to reset when done
> +SYMLINK_PROTECTION=`sysctl -n fs.protected_symlinks`
> +HARDLINK_PROTECTION=`sysctl -n fs.protected_hardlinks`
> +
> +test_symlink()
> +{
> +	ln -s $TEST_DIR/$seq/target $TEST_DIR/$seq/sticky_dir/symlink
> +	chown $OTHER.$OTHER $TEST_DIR/$seq/sticky_dir
> +	chown $OWNER.$OWNER $TEST_DIR/$seq/sticky_dir/symlink
> +	# If we can read the target, we followed the link
> +	_user_do "cat $TEST_DIR/$seq/sticky_dir/symlink" | _filter_test_dir
> +	rm -f $TEST_DIR/$seq/sticky_dir/symlink
> +}
> +
> +test_hardlink()
> +{
> +	chown $OWNER.$OWNER $TEST_DIR/$seq/target
> +	chmod go-rw $TEST_DIR/$seq/target
> +	_user_do "ln $TEST_DIR/$seq/target $TEST_DIR/$seq/sticky_dir/hardlink" \
> +		| _filter_test_dir
> +	test -f $TEST_DIR/$seq/sticky_dir/hardlink \
> +		&& echo "successfully created hardlink"
> +	rm -f $TEST_DIR/$seq/sticky_dir/hardlink
> +}
> +
> +setup_tree()
> +{
> +	# Create world-writable sticky dir
> +	mkdir -p $TEST_DIR/$seq/sticky_dir
> +	chmod 1777 $TEST_DIR/$seq/sticky_dir
> +	# And a file elsewhere that will be linked to from that sticky dir
> +	mkdir -p $TEST_DIR/$seq
> +	# If we can read it, we followed the link.
> +	echo "successfully followed symlink" > $TEST_DIR/$seq/target
> +}
> +
> +setup_tree
> +
> +# First test fs.protected_symlinks
> +# With protection on, symlink follows should fail if the
> +# link owner != the sticky directory owner, and the process
> +# is not the link owner.
> +echo "== Test symlink follow protection when"
> +echo "== process != link owner and dir owner != link owner"
> +sysctl -w fs.protected_symlinks=0
> +test_symlink
> +sysctl -w fs.protected_symlinks=1
> +test_symlink
> +
> +echo
> +
> +# Now test fs.protected_hardlinks
> +# With protection on, hardlink creation should fail if the
> +# process does not own the target file, and the process does not have
> +# read-write access to the target
> +echo "== Test hardlink create protection when"
> +echo "== process != target owner and process cannot read target"
> +sysctl -w fs.protected_hardlinks=0
> +test_hardlink
> +sysctl -w fs.protected_hardlinks=1
> +test_hardlink
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/900.out b/tests/generic/900.out
> new file mode 100644
> index 00000000..7adf97ed
> --- /dev/null
> +++ b/tests/generic/900.out
> @@ -0,0 +1,14 @@
> +QA output created by 900
> +== Test symlink follow protection when
> +== process != link owner and dir owner != link owner
> +fs.protected_symlinks = 0
> +successfully followed symlink
> +fs.protected_symlinks = 1
> +Permission denied
> +
> +== Test hardlink create protection when
> +== process != target owner and process cannot read target
> +fs.protected_hardlinks = 0
> +successfully created hardlink
> +fs.protected_hardlinks = 1
> +ln: failed to create hard link 'TEST_DIR/900/sticky_dir/hardlink' => 'TEST_DIR/900/target': Operation not permitted
> diff --git a/tests/generic/group b/tests/generic/group
> index e82004e8..fd2360ea 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -599,3 +599,4 @@
>  594 auto quick quota
>  595 auto quick encrypt
>  596 auto quick
> +900 auto quick perms
> -- 
> 2.17.0
> 
