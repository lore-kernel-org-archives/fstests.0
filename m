Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AEBC61DA4
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Feb 2023 21:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjBIVfO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Feb 2023 16:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBIVfN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Feb 2023 16:35:13 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220A09EC4
        for <fstests@vger.kernel.org>; Thu,  9 Feb 2023 13:35:12 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id nn4-20020a17090b38c400b00233a6f118d0so687793pjb.2
        for <fstests@vger.kernel.org>; Thu, 09 Feb 2023 13:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6uOrPieAUJUj7GHgDrjElm/QCbeAGZnnLoC1eE+XgI=;
        b=nV7X7DOFVHnnst4yhFU4gg83CDVKWFvfyDZI2BpKe37+djCDE25u9TAPadDYP2CCIP
         L8xylpjmuiqIg73o92WBjRc4YHOgLcvJDp0x08gFEJehJ0RomP4VUxM8P12paORQveL3
         bN8I2SOak8qmp5pwa10h89jye/JpaE9rVN8S3se5dXXoiWa45zPnJoEOygxjzozURXZU
         sXh4eOsyxCCGqdX5HtKc7GkZkh0+sWdTnScdApzk0//UBdkDgi450GxGhDjr3mu7VgvQ
         eETvudGOZcsNhfynHHg7ptY4eEVnr6lV5uSNAPfhKHYwzo2ohMLXfNn2Kjiq8+Yi8ZIu
         nG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6uOrPieAUJUj7GHgDrjElm/QCbeAGZnnLoC1eE+XgI=;
        b=A3ZECxnsn2QzXDmmUZkZ4idpypP3gvmKvz6DtwVC1XA8QRJOJrQE0A9lMLNWctpTH/
         W4C9AoZtlH2VdVEpJI/yLGGoOmbsKCFzrBSyJdcTdtpwUPU3AA0mwncqgGurPK2jBb4U
         JATk8NwEhbuWB7OFr2bXlxwnX1hwj3wqeLkEN9GeZNe6pV9uiYFCH9HFCwCMkno18HhI
         OsY062KCvwwCeKJUTvbjg0yRkZZcEf+w+wK4QiRAsqszyx/sNhaZF60SNxb6kTUDucjr
         oD2XSBBpM+hwn0dIuX55sg39+y4q9+tOsH/fd9uS2mOcfB2Vv+Oa4Qt/Zr63bDwRGXs+
         FiaA==
X-Gm-Message-State: AO0yUKXr+uif0L3FrJUyowctINGI+nCvzShEE1jUB1mImVQOAkt2IxcB
        HmAlQabqwLQSV8+GvRQmn8Y=
X-Google-Smtp-Source: AK7set9Bf6fExEeIq/A8owZU7DNvV/lF0vRyH73ckYJWugnxkituQG9fU+8Pct7IH0KkL9/+EuL/pA==
X-Received: by 2002:a17:903:2284:b0:19a:5939:51dd with SMTP id b4-20020a170903228400b0019a593951ddmr4123497plh.20.1675978511311;
        Thu, 09 Feb 2023 13:35:11 -0800 (PST)
Received: from google.com ([2620:15c:2c1:200:67b8:d62f:3d52:62f])
        by smtp.gmail.com with ESMTPSA id jb1-20020a170903258100b001990c6c16ebsm1998998plb.37.2023.02.09.13.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 13:35:10 -0800 (PST)
Date:   Thu, 9 Feb 2023 13:35:08 -0800
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, zlang@redhat.com
Subject: Re: [PATCH] debug: add tests for debugging testing setup
Message-ID: <Y+VnDBnBZiHo20tk@google.com>
References: <20230209013143.2586104-1-leah.rumancik@gmail.com>
 <Y+Rewk2CmqrWDyVu@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+Rewk2CmqrWDyVu@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 08, 2023 at 06:47:30PM -0800, Darrick J. Wong wrote:
> On Wed, Feb 08, 2023 at 05:31:43PM -0800, Leah Rumancik wrote:
> > Many people have developed infrastructure around xfstests. In order to
> > test a setup, it would be helpful to have dummy tests that have
> > consistent test outcomes. Add a new test folder with the following
> > debugging tests:
> 
> Ooh, we've been needing selftests for a while, thanks!
> 
> > debug/001 pass
> > debug/002 fail
> > debug/003 skip
> > debug/004 crash
> > debug/005 hang
> > 
> > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > 
> > diff --git a/doc/group-names.txt b/doc/group-names.txt
> > index 6cc9af78..212da7e7 100644
> > --- a/doc/group-names.txt
> > +++ b/doc/group-names.txt
> > @@ -39,6 +39,7 @@ dangerous_scrub		fuzzers to evaluate xfs_scrub checking
> >  data			data loss checkers
> >  dax			direct access mode for persistent memory files
> >  db			xfs_db functional tests
> > +debug			tests with fixed results, used to validate testing setup
> 
> Bikeshed: Can we make the tag 'selftests' since debugging could refer to
> just about anything in the kernel/userspace/otherstuff stacks?

Ah sure, agreed selftests would be better, thanks.

> 
> Also a dangerous_selftests for tests that will crash or hang the test
> appliances.  I'd really like to run this every time I start up fstests,
> albeit without the dangerous ones. :)

How exactly would you plan to run it? To run just the non-dangerous tests,
you could do -g selftests/selftests -x selftests/dangerous_selftests. You
can't simply use -g selftests -x selftests_dangerous as right now
selftests is not being added to SRC_GROUPS. It would be nice to make it
behave more like a normal group though... If it doesn't matter that
these would run with -g all, I could just add it to SRC_GROUPS. If it'd be
best to skip these during running -g all, I could also update get_all_tests
to skip over the selftests folder. Do you think these should run with
-g all?

> 
> Or <cough> fsteststests.

Ha :)

> 
> (No, really not that.)
> 
> >  dedupe			FIEDEDUPERANGE ioctl
> >  defrag			filesystem defragmenters
> >  dir			directory test functions
> > diff --git a/tests/debug/001 b/tests/debug/001
> > new file mode 100755
> > index 00000000..9567449c
> > --- /dev/null
> > +++ b/tests/debug/001
> > @@ -0,0 +1,14 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 001
> > +#
> > +# A test that should always pass
> > +#
> > +. ./common/preamble
> > +_begin_fstest debug
> > +
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > +
> > diff --git a/tests/debug/001.out b/tests/debug/001.out
> > new file mode 100644
> > index 00000000..88678b8e
> > --- /dev/null
> > +++ b/tests/debug/001.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 001
> > +Silence is golden
> > diff --git a/tests/debug/002 b/tests/debug/002
> > new file mode 100755
> > index 00000000..12b45a94
> > --- /dev/null
> > +++ b/tests/debug/002
> > @@ -0,0 +1,14 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 002
> > +#
> > +# A test that should always fail
> > +#
> > +. ./common/preamble
> > +_begin_fstest debug
> > +
> > +echo "I am intentionally broken"
> 
> Would you mind slipping in another test to simulate tests that cannot
> satisfy preconditions and hence _fail?

What exactly do you mean? Like a test that just calls _fail to
simulate something like _scratch_mkfs || _fail "mkfs failed"?

> 
> > +status=0
> > +exit
> > +
> > diff --git a/tests/debug/002.out b/tests/debug/002.out
> > new file mode 100644
> > index 00000000..61705c7c
> > --- /dev/null
> > +++ b/tests/debug/002.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 002
> > +Silence is golden
> > diff --git a/tests/debug/003 b/tests/debug/003
> > new file mode 100755
> > index 00000000..813e6ff6
> > --- /dev/null
> > +++ b/tests/debug/003
> > @@ -0,0 +1,16 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 003
> > +#
> > +# A test that should always be skipped
> > +#
> > +. ./common/preamble
> > +_begin_fstest debug
> > +
> > +_notrun "Always skip me"
> > +
> > +echo "I should be skipped"
> > +status=0
> > +exit
> > +
> > diff --git a/tests/debug/003.out b/tests/debug/003.out
> > new file mode 100644
> > index 00000000..6895fc80
> > --- /dev/null
> > +++ b/tests/debug/003.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 003
> > +Silence is golden
> > diff --git a/tests/debug/004 b/tests/debug/004
> > new file mode 100755
> > index 00000000..2e5f1e43
> > --- /dev/null
> > +++ b/tests/debug/004
> > @@ -0,0 +1,17 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 004
> > +#
> > +# A test that crashes
> > +#
> > +. ./common/preamble
> > +_begin_fstest debug dangerous
> 
> _begin_fstest dangerous_selftest?
> 
Sure, will update.

> > +
> > +echo 1 > /proc/sys/kernel/sysrq
> > +echo c > /proc/sysrq-trigger
> > +
> > +echo "I should have crashed by now"
> > +status=0
> > +exit
> > +
> > diff --git a/tests/debug/004.out b/tests/debug/004.out
> > new file mode 100644
> > index 00000000..af8614ae
> > --- /dev/null
> > +++ b/tests/debug/004.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 004
> > +Silence is golden
> > diff --git a/tests/debug/005 b/tests/debug/005
> > new file mode 100755
> > index 00000000..1a213926
> > --- /dev/null
> > +++ b/tests/debug/005
> > @@ -0,0 +1,20 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 005
> > +#
> > +# A test that hangs
> > +#
> > +
> > +. ./common/preamble
> > +_begin_fstest debug dangerous
> 
> Here too.

Ack
> 
> > +
> > +while :
> > +do
> > +    sleep 1d
> > +done
> > +
> > +echo "I should still be sleeping"
> > +status=0
> > +exit
> > +
> > diff --git a/tests/debug/005.out b/tests/debug/005.out
> > new file mode 100644
> > index 00000000..a5027f12
> > --- /dev/null
> > +++ b/tests/debug/005.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 005
> > +Silence is golden
> > diff --git a/tests/debug/Makefile b/tests/debug/Makefile
> > new file mode 100644
> > index 00000000..84556199
> > --- /dev/null
> > +++ b/tests/debug/Makefile
> > @@ -0,0 +1,24 @@
> > +#
> > +# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
> > +#
> > +
> > +TOPDIR = ../..
> > +include $(TOPDIR)/include/builddefs
> > +include $(TOPDIR)/include/buildgrouplist
> > +
> > +DEBUG_DIR = debug
> > +TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(DEBUG_DIR)
> > +DIRT = group.list
> > +
> > +default: $(DIRT)
> > +
> > +include $(BUILDRULES)
> > +
> > +install:
> > +	$(INSTALL) -m 755 -d $(TARGET_DIR)
> > +	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
> > +	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> > +	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
> > +
> > +# Nothing.
> > +install-dev install-lib:
> > -- 
> > 2.39.1.519.gcb327c4b5f-goog
> > 
