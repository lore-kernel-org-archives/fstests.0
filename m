Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3278DC05027
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Feb 2023 02:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjBICva (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Feb 2023 21:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjBICuj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Feb 2023 21:50:39 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1BC302B8
        for <fstests@vger.kernel.org>; Wed,  8 Feb 2023 18:47:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 870DDCE231C
        for <fstests@vger.kernel.org>; Thu,  9 Feb 2023 02:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98269C433D2;
        Thu,  9 Feb 2023 02:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675910850;
        bh=fyRX5WZXQkk/Gd5rLlpaRUM7CbD92rqKUg4QrgS5kx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ewF9uWwT9iShAboqZzy65QXpg1krG/KryUU1qlWsNBJ6YUHPyNc4jFBggv61xng4P
         l/lA2fdLSP2BtmA6lax9GlEwW8m5TnOqZLsqSyzxiARrJtybc6AAA/3dWz/Qw5uuAH
         /F+q/vg9XZ8HQqKXnT+5C5tAcguGerydogt/uwfLpjaKvxkG5ixlJsMWag5475eG9f
         zm3Z9xhJw13kiQE3rJlv80esJPiTb7scjQ1NdBiRXOWqH74CBhPgB2hpcZuF/eeBTf
         8hZtAf1MbAiPlszW3NLs3Xf4aKbhSfkdJbHH9RmViFVM99pQR8KaGlqxMWd/wfxlpa
         6NulTcHEXDW5Q==
Date:   Wed, 8 Feb 2023 18:47:30 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     fstests@vger.kernel.org, zlang@redhat.com
Subject: Re: [PATCH] debug: add tests for debugging testing setup
Message-ID: <Y+Rewk2CmqrWDyVu@magnolia>
References: <20230209013143.2586104-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209013143.2586104-1-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 08, 2023 at 05:31:43PM -0800, Leah Rumancik wrote:
> Many people have developed infrastructure around xfstests. In order to
> test a setup, it would be helpful to have dummy tests that have
> consistent test outcomes. Add a new test folder with the following
> debugging tests:

Ooh, we've been needing selftests for a while, thanks!

> debug/001 pass
> debug/002 fail
> debug/003 skip
> debug/004 crash
> debug/005 hang
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  doc/group-names.txt  |  1 +
>  tests/debug/001      | 14 ++++++++++++++
>  tests/debug/001.out  |  2 ++
>  tests/debug/002      | 14 ++++++++++++++
>  tests/debug/002.out  |  2 ++
>  tests/debug/003      | 16 ++++++++++++++++
>  tests/debug/003.out  |  2 ++
>  tests/debug/004      | 17 +++++++++++++++++
>  tests/debug/004.out  |  2 ++
>  tests/debug/005      | 20 ++++++++++++++++++++
>  tests/debug/005.out  |  2 ++
>  tests/debug/Makefile | 24 ++++++++++++++++++++++++
>  12 files changed, 116 insertions(+)
>  create mode 100755 tests/debug/001
>  create mode 100644 tests/debug/001.out
>  create mode 100755 tests/debug/002
>  create mode 100644 tests/debug/002.out
>  create mode 100755 tests/debug/003
>  create mode 100644 tests/debug/003.out
>  create mode 100755 tests/debug/004
>  create mode 100644 tests/debug/004.out
>  create mode 100755 tests/debug/005
>  create mode 100644 tests/debug/005.out
>  create mode 100644 tests/debug/Makefile
> 
> diff --git a/doc/group-names.txt b/doc/group-names.txt
> index 6cc9af78..212da7e7 100644
> --- a/doc/group-names.txt
> +++ b/doc/group-names.txt
> @@ -39,6 +39,7 @@ dangerous_scrub		fuzzers to evaluate xfs_scrub checking
>  data			data loss checkers
>  dax			direct access mode for persistent memory files
>  db			xfs_db functional tests
> +debug			tests with fixed results, used to validate testing setup

Bikeshed: Can we make the tag 'selftests' since debugging could refer to
just about anything in the kernel/userspace/otherstuff stacks?

Also a dangerous_selftests for tests that will crash or hang the test
appliances.  I'd really like to run this every time I start up fstests,
albeit without the dangerous ones. :)

Or <cough> fsteststests.

(No, really not that.)

>  dedupe			FIEDEDUPERANGE ioctl
>  defrag			filesystem defragmenters
>  dir			directory test functions
> diff --git a/tests/debug/001 b/tests/debug/001
> new file mode 100755
> index 00000000..9567449c
> --- /dev/null
> +++ b/tests/debug/001
> @@ -0,0 +1,14 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 001
> +#
> +# A test that should always pass
> +#
> +. ./common/preamble
> +_begin_fstest debug
> +
> +echo "Silence is golden"
> +status=0
> +exit
> +
> diff --git a/tests/debug/001.out b/tests/debug/001.out
> new file mode 100644
> index 00000000..88678b8e
> --- /dev/null
> +++ b/tests/debug/001.out
> @@ -0,0 +1,2 @@
> +QA output created by 001
> +Silence is golden
> diff --git a/tests/debug/002 b/tests/debug/002
> new file mode 100755
> index 00000000..12b45a94
> --- /dev/null
> +++ b/tests/debug/002
> @@ -0,0 +1,14 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 002
> +#
> +# A test that should always fail
> +#
> +. ./common/preamble
> +_begin_fstest debug
> +
> +echo "I am intentionally broken"

Would you mind slipping in another test to simulate tests that cannot
satisfy preconditions and hence _fail?

> +status=0
> +exit
> +
> diff --git a/tests/debug/002.out b/tests/debug/002.out
> new file mode 100644
> index 00000000..61705c7c
> --- /dev/null
> +++ b/tests/debug/002.out
> @@ -0,0 +1,2 @@
> +QA output created by 002
> +Silence is golden
> diff --git a/tests/debug/003 b/tests/debug/003
> new file mode 100755
> index 00000000..813e6ff6
> --- /dev/null
> +++ b/tests/debug/003
> @@ -0,0 +1,16 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 003
> +#
> +# A test that should always be skipped
> +#
> +. ./common/preamble
> +_begin_fstest debug
> +
> +_notrun "Always skip me"
> +
> +echo "I should be skipped"
> +status=0
> +exit
> +
> diff --git a/tests/debug/003.out b/tests/debug/003.out
> new file mode 100644
> index 00000000..6895fc80
> --- /dev/null
> +++ b/tests/debug/003.out
> @@ -0,0 +1,2 @@
> +QA output created by 003
> +Silence is golden
> diff --git a/tests/debug/004 b/tests/debug/004
> new file mode 100755
> index 00000000..2e5f1e43
> --- /dev/null
> +++ b/tests/debug/004
> @@ -0,0 +1,17 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 004
> +#
> +# A test that crashes
> +#
> +. ./common/preamble
> +_begin_fstest debug dangerous

_begin_fstest dangerous_selftest?

> +
> +echo 1 > /proc/sys/kernel/sysrq
> +echo c > /proc/sysrq-trigger
> +
> +echo "I should have crashed by now"
> +status=0
> +exit
> +
> diff --git a/tests/debug/004.out b/tests/debug/004.out
> new file mode 100644
> index 00000000..af8614ae
> --- /dev/null
> +++ b/tests/debug/004.out
> @@ -0,0 +1,2 @@
> +QA output created by 004
> +Silence is golden
> diff --git a/tests/debug/005 b/tests/debug/005
> new file mode 100755
> index 00000000..1a213926
> --- /dev/null
> +++ b/tests/debug/005
> @@ -0,0 +1,20 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 005
> +#
> +# A test that hangs
> +#
> +
> +. ./common/preamble
> +_begin_fstest debug dangerous

Here too.

> +
> +while :
> +do
> +    sleep 1d
> +done
> +
> +echo "I should still be sleeping"
> +status=0
> +exit
> +
> diff --git a/tests/debug/005.out b/tests/debug/005.out
> new file mode 100644
> index 00000000..a5027f12
> --- /dev/null
> +++ b/tests/debug/005.out
> @@ -0,0 +1,2 @@
> +QA output created by 005
> +Silence is golden
> diff --git a/tests/debug/Makefile b/tests/debug/Makefile
> new file mode 100644
> index 00000000..84556199
> --- /dev/null
> +++ b/tests/debug/Makefile
> @@ -0,0 +1,24 @@
> +#
> +# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
> +#
> +
> +TOPDIR = ../..
> +include $(TOPDIR)/include/builddefs
> +include $(TOPDIR)/include/buildgrouplist
> +
> +DEBUG_DIR = debug
> +TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(DEBUG_DIR)
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
> 2.39.1.519.gcb327c4b5f-goog
> 
