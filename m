Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5528AC433EF
	for <linux-fstests@archiver.kernel.org>; Sun,  9 Jan 2022 12:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiAIMnY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 9 Jan 2022 07:43:24 -0500
Received: from out20-37.mail.aliyun.com ([115.124.20.37]:50103 "EHLO
        out20-37.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiAIMnX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Jan 2022 07:43:23 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07440847|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0702499-0.030879-0.898871;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.MYuCmTY_1641732200;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.MYuCmTY_1641732200)
          by smtp.aliyun-inc.com(10.147.41.187);
          Sun, 09 Jan 2022 20:43:21 +0800
Date:   Sun, 9 Jan 2022 20:43:20 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Chen Long <chenlongcl.chen@huawei.com>
Cc:     fstests@vger.kernel.org, richard@nod.at
Subject: Re: [PATCH] ubifs: add test for race between listxattr and setxatr
Message-ID: <YdrYaH7PImqW1WVB@desktop>
References: <20220108022431.71751-1-chenlongcl.chen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220108022431.71751-1-chenlongcl.chen@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Jan 08, 2022 at 10:24:31AM +0800, Chen Long wrote:
> Add reproducer for a bug on ubifs where listxattr() copies
> the newly created xattr names regardless of the remaining
> buffer size, fails the assertion of used buffer size, and
> may corrupt buffer memory.
> 
> This is a regression test for three kernel commit:
> 1. f4e3634a3b642 (ubifs: Fix races between xattr_{set|get} and
> 	listxattr operations)
> 2. 819f9ab430a44 (ubifs: Remove ui_mutex in ubifs_xattr_get and
> 	change_xattr)

Only two commits listed above, but description mentioned 'three' kernel
commits. Missed one commit or should s/three/the/ ?

And I don't see any ubifs-specific setups or tests, I think it's
possible to make it a generic test.

> 
> Signed-off-by: Chen Long <chenlongcl.chen@huawei.com>
> ---
>  tests/ubifs/001      | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/ubifs/001.out  |  2 ++
>  tests/ubifs/Makefile | 24 ++++++++++++++++++++
>  3 files changed, 80 insertions(+)
>  create mode 100755 tests/ubifs/001
>  create mode 100644 tests/ubifs/001.out
>  create mode 100644 tests/ubifs/Makefile
> 
> diff --git a/tests/ubifs/001 b/tests/ubifs/001
> new file mode 100755
> index 00000000..1e9a4de2
> --- /dev/null
> +++ b/tests/ubifs/001
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Huawei.  All Rights Reserved.
> +#
> +# FS QA Test 001
> +#
> +# Regression test for kernel commit:
> +# 1. f4e3634a3b642 (ubifs: Fix races between xattr_{set|get} and
> +#	listxattr operations)
> +# 2. 819f9ab430a44 (ubifs: Remove ui_mutex in ubifs_xattr_get and
> +#	change_xattr)
> +#
> +. ./common/preamble
> +_begin_fstest auto quick attr
> +
> +_cleanup()
> +{
> +    cd /
> +    rm -r -f $tmp.*
> +}

Use tab for indention, not spaces.

And this _cleanup() function is the same as the default one, so you
don't need to override it.

> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_fs ubifs
> +_require_test
> +_require_attrs
> +
> +target=$TEST_DIR/$seq
> +touch $target
> +
> +# start a background listxattr
> +runfile="$tmp.listxattr"
> +touch $runfile
> +while [ -e $runfile ]; do
> +    ${GETFATTR_PROG} $target >/dev/null 2>&1
> +done &
> +
> +# add new xattr continuously
> +largename=`for i in $(seq 0 128); do echo -n a; done`

Don't have to loop for 129 times, perl could do it as

largename=`$PERL_PROG -e 'print "a"x129;'`

> +for i in $(seq 0 99); do

for i in {0..99}; do

which could avoid forking a new process :)

> +    ${SETFATTR_PROG} -n user.${largename}.$i -v $i $target
> +done

Thanks,
Eryu

> +
> +rm -f $runfile
> +wait > /dev/null 2>&1
> +rm -f $target
> +
> +echo "Silence is golden"
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ubifs/001.out b/tests/ubifs/001.out
> new file mode 100644
> index 00000000..88678b8e
> --- /dev/null
> +++ b/tests/ubifs/001.out
> @@ -0,0 +1,2 @@
> +QA output created by 001
> +Silence is golden
> diff --git a/tests/ubifs/Makefile b/tests/ubifs/Makefile
> new file mode 100644
> index 00000000..b464b22b
> --- /dev/null
> +++ b/tests/ubifs/Makefile
> @@ -0,0 +1,24 @@
> +#
> +# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
> +#
> +
> +TOPDIR = ../..
> +include $(TOPDIR)/include/builddefs
> +include $(TOPDIR)/include/buildgrouplist
> +
> +GENERIC_DIR = generic
> +TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GENERIC_DIR)
> +DIRT = group.list
> +
> +default: $(DIRT)
> +
> +include $(BUILDRULES)
> +
> +install:
> +	$(INSTALL) -m 755 -d $(TARGET_DIR)
> +	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
> +	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> +	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
> +
> +# Nothing.
> +install-dev install-lib:
> -- 
> 2.17.1
