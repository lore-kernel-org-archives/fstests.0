Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDC1C636D4
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Feb 2023 04:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjBOEux (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Feb 2023 23:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjBOEuh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Feb 2023 23:50:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D13C2D156
        for <fstests@vger.kernel.org>; Tue, 14 Feb 2023 20:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676436589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e+GEQq4TALXXw29Xj5428WXSy3CiVElh8ggiQCuP678=;
        b=CZ2Xi/NHF9jsr7vGzsZdM+Dm48V/8Rg7tQj1NsuaUA90Eoej1NKcgzcLJLgv/e7m8x8nmS
        QLY/8dfrUhpfdkoH1GP1OcSZYd5fqllYS5plr5T2JwTKBbXUeFJ1vInW3EMFGdUK7YEvwV
        OFnIj2R7jlgycOJ9uNSRGu6wQDMusZQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-402-v2lFXiC0PlWtb0KS_2b4PQ-1; Tue, 14 Feb 2023 23:49:46 -0500
X-MC-Unique: v2lFXiC0PlWtb0KS_2b4PQ-1
Received: by mail-pg1-f199.google.com with SMTP id f19-20020a631013000000b004e8c27fa528so6701040pgl.17
        for <fstests@vger.kernel.org>; Tue, 14 Feb 2023 20:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+GEQq4TALXXw29Xj5428WXSy3CiVElh8ggiQCuP678=;
        b=oSC16QDNfCwCJ5AV7Rg9UegQ7yTtyk6F5svM2Ls5LZ0DofyVh0RyKNaBPFyPSk+70Z
         6HgOVlCivOlP3tUtFetK3VEy6C2aCJQzaWFzbAEp6y0PcUeyBn7fUhUNFFDYEFZXP+RM
         e5gE/e9FlQHPtEkolcN4HD+/elWX6rl57Mv8pdB0Ehi++/2yvs1xLzzfu8T8DVcLeXsY
         6AExmYyovYbvSfXIYJFoPQvY1bU8ShdZZ3ZBewQ9a7JIYc6f1gh2vBne1tMSyN78Bhh7
         qzQijQXB9jPXB0t7BketqKRMT1mXlpYInxGSd7xR7GFqvbx+wU1O8pkz+zKE8Eaq+qzY
         fI2w==
X-Gm-Message-State: AO0yUKX3rClZL/6Q8ft5eGS4Fo761dQK3X4ccDJb74vsEPcJMNLj51RW
        byqJI05R7YWYV7Y8h1eZ5u7VYCzMYheu2wgSni2hAWxKPhRTZK50bx+b/v7b07Miswgdt52u9ut
        otlllfsGwi7sop2bZGA==
X-Received: by 2002:a17:903:2843:b0:199:11aa:50d8 with SMTP id kq3-20020a170903284300b0019911aa50d8mr822023plb.33.1676436585605;
        Tue, 14 Feb 2023 20:49:45 -0800 (PST)
X-Google-Smtp-Source: AK7set/cA+d/q5iTjg9Qh3aWtOW46evo7OXgf8zozXgH2t/2p2KMaB6XlN6J8GknBe0y54IrwoJl4w==
X-Received: by 2002:a17:903:2843:b0:199:11aa:50d8 with SMTP id kq3-20020a170903284300b0019911aa50d8mr822007plb.33.1676436585079;
        Tue, 14 Feb 2023 20:49:45 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c25500b0019a8468cbedsm7199846plg.226.2023.02.14.20.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 20:49:44 -0800 (PST)
Date:   Wed, 15 Feb 2023 12:49:41 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] selftest: add tests for debugging testing setup
Message-ID: <20230215044941.xgk3crhvv2jlahx6@zlang-mailbox>
References: <20230214215431.1425107-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214215431.1425107-1-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Feb 14, 2023 at 01:54:31PM -0800, Leah Rumancik wrote:
> Many people have developed infrastructure around xfstests. In order to
> test a setup, it would be helpful to have dummy tests that have
> consistent test outcomes. Add a new test folder with the following
> tests:
> 
> selftest/001 pass
> selftest/002 fail from output mismatch
> selftest/003 fail via _fail
> selftest/004 skip
> selftest/005 crash
> selftest/006 hang
> 
> Also, create two new groups: 'selftest' which includes tests 001-004 and
> 'dangerous_selftest' which includes tests 005-006. The selftests will
> run when running all tests but they are not part of the auto group.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
> v1 -> v2:
> 
> - change name of folder from 'debug' to 'selftest'
> - update tags to 'selftest' and 'dangerous_selftest'
> - add selftest folder to SRC_GROUPS
> - update copyright tag
> - add test which _fails

Thanks, this version looks good to me, just each case has a blank line at EOF.
I'll help to remove those blank lines when I merge this patch.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro


> 
> v1: https://lore.kernel.org/fstests/20230209013143.2586104-1-leah.rumancik@gmail.com/
> 
>  check                   |  2 +-
>  doc/group-names.txt     |  2 ++
>  tests/selftest/001      | 14 ++++++++++++++
>  tests/selftest/001.out  |  2 ++
>  tests/selftest/002      | 14 ++++++++++++++
>  tests/selftest/002.out  |  2 ++
>  tests/selftest/003      | 16 ++++++++++++++++
>  tests/selftest/003.out  |  2 ++
>  tests/selftest/004      | 16 ++++++++++++++++
>  tests/selftest/004.out  |  2 ++
>  tests/selftest/005      | 17 +++++++++++++++++
>  tests/selftest/005.out  |  2 ++
>  tests/selftest/006      | 20 ++++++++++++++++++++
>  tests/selftest/006.out  |  2 ++
>  tests/selftest/Makefile | 24 ++++++++++++++++++++++++
>  15 files changed, 136 insertions(+), 1 deletion(-)
>  create mode 100755 tests/selftest/001
>  create mode 100644 tests/selftest/001.out
>  create mode 100755 tests/selftest/002
>  create mode 100644 tests/selftest/002.out
>  create mode 100755 tests/selftest/003
>  create mode 100644 tests/selftest/003.out
>  create mode 100755 tests/selftest/004
>  create mode 100644 tests/selftest/004.out
>  create mode 100755 tests/selftest/005
>  create mode 100644 tests/selftest/005.out
>  create mode 100755 tests/selftest/006
>  create mode 100644 tests/selftest/006.out
>  create mode 100644 tests/selftest/Makefile
> 
> diff --git a/check b/check
> index 4827532e..c2065cdc 100755
> --- a/check
> +++ b/check
> @@ -48,7 +48,7 @@ timestamp=${TIMESTAMP:=false}
>  
>  rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist
>  
> -SRC_GROUPS="generic shared"
> +SRC_GROUPS="generic shared selftest"
>  export SRC_DIR="tests"
>  
>  usage()
> diff --git a/doc/group-names.txt b/doc/group-names.txt
> index 771ce937..ace59e05 100644
> --- a/doc/group-names.txt
> +++ b/doc/group-names.txt
> @@ -38,6 +38,7 @@ dangerous_fsstress_repair	race fsstress and xfs_scrub online repair
>  dangerous_fsstress_scrub	race fsstress and xfs_scrub checking
>  dangerous_repair	fuzzers to evaluate xfs_repair offline repair
>  dangerous_scrub		fuzzers to evaluate xfs_scrub checking
> +dangerous_selftest	selftests that crash/hang
>  data			data loss checkers
>  dax			direct access mode for persistent memory files
>  db			xfs_db functional tests
> @@ -111,6 +112,7 @@ samefs			overlayfs when all layers are on the same fs
>  scrub			filesystem metadata scrubbers
>  seed			btrfs seeded filesystems
>  seek			llseek functionality
> +selftest		tests with fixed results, used to validate testing setup
>  send			btrfs send/receive
>  shrinkfs		decreasing the size of a filesystem
>  shutdown		FS_IOC_SHUTDOWN ioctl
> diff --git a/tests/selftest/001 b/tests/selftest/001
> new file mode 100755
> index 00000000..f326fc83
> --- /dev/null
> +++ b/tests/selftest/001
> @@ -0,0 +1,14 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 001
> +#
> +# A test that should always pass
> +#
> +. ./common/preamble
> +_begin_fstest selftest
> +
> +echo "Silence is golden"
> +status=0
> +exit
> +
> diff --git a/tests/selftest/001.out b/tests/selftest/001.out
> new file mode 100644
> index 00000000..88678b8e
> --- /dev/null
> +++ b/tests/selftest/001.out
> @@ -0,0 +1,2 @@
> +QA output created by 001
> +Silence is golden
> diff --git a/tests/selftest/002 b/tests/selftest/002
> new file mode 100755
> index 00000000..a3e463b8
> --- /dev/null
> +++ b/tests/selftest/002
> @@ -0,0 +1,14 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 002
> +#
> +# A test that should always fail due to output mismatch
> +#
> +. ./common/preamble
> +_begin_fstest selftest
> +
> +echo "I am intentionally broken"
> +status=0
> +exit
> +
> diff --git a/tests/selftest/002.out b/tests/selftest/002.out
> new file mode 100644
> index 00000000..61705c7c
> --- /dev/null
> +++ b/tests/selftest/002.out
> @@ -0,0 +1,2 @@
> +QA output created by 002
> +Silence is golden
> diff --git a/tests/selftest/003 b/tests/selftest/003
> new file mode 100755
> index 00000000..80d9ea90
> --- /dev/null
> +++ b/tests/selftest/003
> @@ -0,0 +1,16 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 003
> +#
> +# A test that _fail's
> +#
> +
> +. ./common/preamble
> +_begin_fstest selftest
> +
> +_fail "I have _fail'ed"
> +
> +status=0
> +exit
> +
> diff --git a/tests/selftest/003.out b/tests/selftest/003.out
> new file mode 100644
> index 00000000..6895fc80
> --- /dev/null
> +++ b/tests/selftest/003.out
> @@ -0,0 +1,2 @@
> +QA output created by 003
> +Silence is golden
> diff --git a/tests/selftest/004 b/tests/selftest/004
> new file mode 100755
> index 00000000..eddf49af
> --- /dev/null
> +++ b/tests/selftest/004
> @@ -0,0 +1,16 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 004
> +#
> +# A test that should always be skipped
> +#
> +. ./common/preamble
> +_begin_fstest selftest
> +
> +_notrun "Always skip me"
> +
> +echo "I should be skipped"
> +status=0
> +exit
> +
> diff --git a/tests/selftest/004.out b/tests/selftest/004.out
> new file mode 100644
> index 00000000..af8614ae
> --- /dev/null
> +++ b/tests/selftest/004.out
> @@ -0,0 +1,2 @@
> +QA output created by 004
> +Silence is golden
> diff --git a/tests/selftest/005 b/tests/selftest/005
> new file mode 100755
> index 00000000..e8844d30
> --- /dev/null
> +++ b/tests/selftest/005
> @@ -0,0 +1,17 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 005
> +#
> +# A test that crashes
> +#
> +. ./common/preamble
> +_begin_fstest dangerous_selftest
> +
> +echo 1 > /proc/sys/kernel/sysrq
> +echo c > /proc/sysrq-trigger
> +
> +echo "I should have crashed by now"
> +status=0
> +exit
> +
> diff --git a/tests/selftest/005.out b/tests/selftest/005.out
> new file mode 100644
> index 00000000..a5027f12
> --- /dev/null
> +++ b/tests/selftest/005.out
> @@ -0,0 +1,2 @@
> +QA output created by 005
> +Silence is golden
> diff --git a/tests/selftest/006 b/tests/selftest/006
> new file mode 100755
> index 00000000..c6fa0dc4
> --- /dev/null
> +++ b/tests/selftest/006
> @@ -0,0 +1,20 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test No. 006
> +#
> +# A test that hangs
> +#
> +
> +. ./common/preamble
> +_begin_fstest dangerous_selftest
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
> diff --git a/tests/selftest/006.out b/tests/selftest/006.out
> new file mode 100644
> index 00000000..675c1b7c
> --- /dev/null
> +++ b/tests/selftest/006.out
> @@ -0,0 +1,2 @@
> +QA output created by 006
> +Silence is golden
> diff --git a/tests/selftest/Makefile b/tests/selftest/Makefile
> new file mode 100644
> index 00000000..3ddfca37
> --- /dev/null
> +++ b/tests/selftest/Makefile
> @@ -0,0 +1,24 @@
> +#
> +# Copyright (c) 2023 Google, Inc. All Rights Reserved.
> +#
> +
> +TOPDIR = ../..
> +include $(TOPDIR)/include/builddefs
> +include $(TOPDIR)/include/buildgrouplist
> +
> +SELFTEST_DIR = selftest
> +TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(SELFTEST_DIR)
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
> 2.39.1.581.gbfd45094c4-goog
> 

