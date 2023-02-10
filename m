Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9E5C05027
	for <linux-fstests@archiver.kernel.org>; Fri, 10 Feb 2023 01:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjBJBC7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Feb 2023 20:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjBJBC7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Feb 2023 20:02:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3E75C8B2
        for <fstests@vger.kernel.org>; Thu,  9 Feb 2023 17:02:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 48E34CE2643
        for <fstests@vger.kernel.org>; Fri, 10 Feb 2023 01:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF54C433EF;
        Fri, 10 Feb 2023 01:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675990972;
        bh=FvqaaQfP6lO3vsEcNEzOwQiMm9lgNzxL0qoFMiNf5x0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a30YgKAi9zq88BWVyl883UHqVOPk5PU1k3jmUPUA5rkKXCmNe4sUwQ+PSsxUt1YTQ
         v4NtKfReLY6puT2BFF4wRNF34zhHuF20xe13FtLs90FH9gOBjX3zxkSIdLbF1gxegt
         REF008PsoG0P7rtbPXF9iDhZcr/9iuyNj6zlxPnRfuQ6GhNZUXlCzXmevebE/vt+1Y
         /1wweaoYhsoii5mt320jMJv1YrtH4NPjvOIDNpB+pUQ5rhCb/Xwd3eCVXLTFAStAsa
         KRgTT6yZSBg+Zc/VbyPCPQgdDiKXiUWTBsb8o1OIxaBh3geLM/PYmIGIU5WMoVlzFQ
         OS3wFJ3WTn6mA==
Date:   Thu, 9 Feb 2023 17:02:52 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     fstests@vger.kernel.org, zlang@redhat.com
Subject: Re: [PATCH] debug: add tests for debugging testing setup
Message-ID: <Y+WXvKlwBnmgTROk@magnolia>
References: <20230209013143.2586104-1-leah.rumancik@gmail.com>
 <Y+Rewk2CmqrWDyVu@magnolia>
 <Y+VnDBnBZiHo20tk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+VnDBnBZiHo20tk@google.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Feb 09, 2023 at 01:35:08PM -0800, Leah Rumancik wrote:
> On Wed, Feb 08, 2023 at 06:47:30PM -0800, Darrick J. Wong wrote:
> > On Wed, Feb 08, 2023 at 05:31:43PM -0800, Leah Rumancik wrote:
> > > Many people have developed infrastructure around xfstests. In order to
> > > test a setup, it would be helpful to have dummy tests that have
> > > consistent test outcomes. Add a new test folder with the following
> > > debugging tests:
> > 
> > Ooh, we've been needing selftests for a while, thanks!
> > 
> > > debug/001 pass
> > > debug/002 fail
> > > debug/003 skip
> > > debug/004 crash
> > > debug/005 hang
> > > 
> > > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > > 
> > > diff --git a/doc/group-names.txt b/doc/group-names.txt
> > > index 6cc9af78..212da7e7 100644
> > > --- a/doc/group-names.txt
> > > +++ b/doc/group-names.txt
> > > @@ -39,6 +39,7 @@ dangerous_scrub		fuzzers to evaluate xfs_scrub checking
> > >  data			data loss checkers
> > >  dax			direct access mode for persistent memory files
> > >  db			xfs_db functional tests
> > > +debug			tests with fixed results, used to validate testing setup
> > 
> > Bikeshed: Can we make the tag 'selftests' since debugging could refer to
> > just about anything in the kernel/userspace/otherstuff stacks?
> 
> Ah sure, agreed selftests would be better, thanks.
> 
> > 
> > Also a dangerous_selftests for tests that will crash or hang the test
> > appliances.  I'd really like to run this every time I start up fstests,
> > albeit without the dangerous ones. :)
> 
> How exactly would you plan to run it? To run just the non-dangerous tests,
> you could do -g selftests/selftests -x selftests/dangerous_selftests. You
> can't simply use -g selftests -x selftests_dangerous as right now
> selftests is not being added to SRC_GROUPS.

That's exactly what I was thinking.

> It would be nice to make it
> behave more like a normal group though... If it doesn't matter that
> these would run with -g all, I could just add it to SRC_GROUPS. If it'd be
> best to skip these during running -g all, I could also update get_all_tests
> to skip over the selftests folder. Do you think these should run with
> -g all?

Yes.


> 
> > 
> > Or <cough> fsteststests.
> 
> Ha :)
> 
> > 
> > (No, really not that.)
> > 
> > >  dedupe			FIEDEDUPERANGE ioctl
> > >  defrag			filesystem defragmenters
> > >  dir			directory test functions
> > > diff --git a/tests/debug/001 b/tests/debug/001
> > > new file mode 100755
> > > index 00000000..9567449c
> > > --- /dev/null
> > > +++ b/tests/debug/001
> > > @@ -0,0 +1,14 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# FS QA Test No. 001
> > > +#
> > > +# A test that should always pass
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest debug
> > > +
> > > +echo "Silence is golden"
> > > +status=0
> > > +exit
> > > +
> > > diff --git a/tests/debug/001.out b/tests/debug/001.out
> > > new file mode 100644
> > > index 00000000..88678b8e
> > > --- /dev/null
> > > +++ b/tests/debug/001.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 001
> > > +Silence is golden
> > > diff --git a/tests/debug/002 b/tests/debug/002
> > > new file mode 100755
> > > index 00000000..12b45a94
> > > --- /dev/null
> > > +++ b/tests/debug/002
> > > @@ -0,0 +1,14 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# FS QA Test No. 002
> > > +#
> > > +# A test that should always fail
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest debug
> > > +
> > > +echo "I am intentionally broken"
> > 
> > Would you mind slipping in another test to simulate tests that cannot
> > satisfy preconditions and hence _fail?
> 
> What exactly do you mean? Like a test that just calls _fail to
> simulate something like _scratch_mkfs || _fail "mkfs failed"?

Yes.

--D

> > 
> > > +status=0
> > > +exit
> > > +
> > > diff --git a/tests/debug/002.out b/tests/debug/002.out
> > > new file mode 100644
> > > index 00000000..61705c7c
> > > --- /dev/null
> > > +++ b/tests/debug/002.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 002
> > > +Silence is golden
> > > diff --git a/tests/debug/003 b/tests/debug/003
> > > new file mode 100755
> > > index 00000000..813e6ff6
> > > --- /dev/null
> > > +++ b/tests/debug/003
> > > @@ -0,0 +1,16 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# FS QA Test No. 003
> > > +#
> > > +# A test that should always be skipped
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest debug
> > > +
> > > +_notrun "Always skip me"
> > > +
> > > +echo "I should be skipped"
> > > +status=0
> > > +exit
> > > +
> > > diff --git a/tests/debug/003.out b/tests/debug/003.out
> > > new file mode 100644
> > > index 00000000..6895fc80
> > > --- /dev/null
> > > +++ b/tests/debug/003.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 003
> > > +Silence is golden
> > > diff --git a/tests/debug/004 b/tests/debug/004
> > > new file mode 100755
> > > index 00000000..2e5f1e43
> > > --- /dev/null
> > > +++ b/tests/debug/004
> > > @@ -0,0 +1,17 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# FS QA Test No. 004
> > > +#
> > > +# A test that crashes
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest debug dangerous
> > 
> > _begin_fstest dangerous_selftest?
> > 
> Sure, will update.
> 
> > > +
> > > +echo 1 > /proc/sys/kernel/sysrq
> > > +echo c > /proc/sysrq-trigger
> > > +
> > > +echo "I should have crashed by now"
> > > +status=0
> > > +exit
> > > +
> > > diff --git a/tests/debug/004.out b/tests/debug/004.out
> > > new file mode 100644
> > > index 00000000..af8614ae
> > > --- /dev/null
> > > +++ b/tests/debug/004.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 004
> > > +Silence is golden
> > > diff --git a/tests/debug/005 b/tests/debug/005
> > > new file mode 100755
> > > index 00000000..1a213926
> > > --- /dev/null
> > > +++ b/tests/debug/005
> > > @@ -0,0 +1,20 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +#
> > > +# FS QA Test No. 005
> > > +#
> > > +# A test that hangs
> > > +#
> > > +
> > > +. ./common/preamble
> > > +_begin_fstest debug dangerous
> > 
> > Here too.
> 
> Ack
> > 
> > > +
> > > +while :
> > > +do
> > > +    sleep 1d
> > > +done
> > > +
> > > +echo "I should still be sleeping"
> > > +status=0
> > > +exit
> > > +
> > > diff --git a/tests/debug/005.out b/tests/debug/005.out
> > > new file mode 100644
> > > index 00000000..a5027f12
> > > --- /dev/null
> > > +++ b/tests/debug/005.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 005
> > > +Silence is golden
> > > diff --git a/tests/debug/Makefile b/tests/debug/Makefile
> > > new file mode 100644
> > > index 00000000..84556199
> > > --- /dev/null
> > > +++ b/tests/debug/Makefile
> > > @@ -0,0 +1,24 @@
> > > +#
> > > +# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
> > > +#
> > > +
> > > +TOPDIR = ../..
> > > +include $(TOPDIR)/include/builddefs
> > > +include $(TOPDIR)/include/buildgrouplist
> > > +
> > > +DEBUG_DIR = debug
> > > +TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(DEBUG_DIR)
> > > +DIRT = group.list
> > > +
> > > +default: $(DIRT)
> > > +
> > > +include $(BUILDRULES)
> > > +
> > > +install:
> > > +	$(INSTALL) -m 755 -d $(TARGET_DIR)
> > > +	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
> > > +	$(INSTALL) -m 644 group.list $(TARGET_DIR)
> > > +	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
> > > +
> > > +# Nothing.
> > > +install-dev install-lib:
> > > -- 
> > > 2.39.1.519.gcb327c4b5f-goog
> > > 
