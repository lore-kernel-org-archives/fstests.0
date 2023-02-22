Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84B2C61DA4
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Feb 2023 17:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBVRpW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Feb 2023 12:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjBVRpV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Feb 2023 12:45:21 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF10E366B0
        for <fstests@vger.kernel.org>; Wed, 22 Feb 2023 09:45:19 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id e9so4630950plh.2
        for <fstests@vger.kernel.org>; Wed, 22 Feb 2023 09:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kIn2oZ0mzfIA0q9npAjySMw8oiDiSnHovGSyXJD4rJw=;
        b=H4LaJ53OYHI3n+ZBtoFTHOebcTjX1NfmE+/LislD0LNCQJdNS9JxW9L+B6lTn2Yg+9
         Kh9dTzzGHwdEOggOp6stU9VyPEhlx6Y3aLadqPvpIobQGaQG4F9H/DoLXqku5SZupI7R
         tByLIe9Ksma5fKGs0IvCQicJX+ORJyIPx4YgiKQglIaUAWH0hE6VXLnzpTYDEnvoTjfe
         dLxRPrPNVus4eunC2kOSR79ZBOdPqnyo15fGjx80Zet6bgp1V0tuBrqxLq4Bz871ykuo
         L1p+V2bTKPLxZnPMA7KMW161INrshryfMwI0RnvrZ7nu+BQn4g4gfZmXMNHCGL0x297R
         nTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIn2oZ0mzfIA0q9npAjySMw8oiDiSnHovGSyXJD4rJw=;
        b=YGVWEEYR3E1YDO+rbVxSr6jTNMsiyE6EgKFweKVh9961kwwm/SuYxEakOkLMayj/Qj
         xcstjJgXT//kzzm76rAEIjm78BisROgHFi03XfSumFIwQehKXmfSyznJmbbfBi3gZWAH
         DcXXxhe+Z2w5S0C+NIA3sZtV0wrgxuF60fl/DfUTD5ixR0b0tNHMHtYCkA5rLpbrAvp5
         WngPSmgCdTu6EoKOTdjwtxCsSHFuRhVpnHYt57edkdWA1geoT8jb1ZYkcGV4Gc5DQ0sZ
         8kjirz1H1mQFzpgrLCWPy76llVlD2vpw3FNGGZNH9OaOJcsWCKtRmsDo/67x54n3HBce
         gqfg==
X-Gm-Message-State: AO0yUKWd/bdxreAdKQkAKyVUC++2aGOWNxoJemr5eEDXIoMdYMHznH5Q
        52EQH7baqpH6NdcoYGnAp9Q=
X-Google-Smtp-Source: AK7set/98YaLLXSTD6VbphcRbLZzk9SsQ0VM3qBzBYF+20yCr3uvUA9y/haDoxjlM2EfIRbP25oN5w==
X-Received: by 2002:a05:6a20:7b11:b0:cb:7e8b:d4e4 with SMTP id s17-20020a056a207b1100b000cb7e8bd4e4mr5330277pzh.20.1677087919019;
        Wed, 22 Feb 2023 09:45:19 -0800 (PST)
Received: from google.com ([2620:15c:2c1:200:b1a3:42bb:3c69:41a])
        by smtp.gmail.com with ESMTPSA id d7-20020aa78147000000b005ad9e050518sm4454577pfn.76.2023.02.22.09.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 09:45:18 -0800 (PST)
Date:   Wed, 22 Feb 2023 09:45:16 -0800
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, djwong@kernel.org, amir73il@gmail.com
Subject: Re: [PATCH v3] selftest: add tests for debugging testing setup
Message-ID: <Y/ZUrNlwpkJQOV3e@google.com>
References: <20230221223649.3616254-1-leah.rumancik@gmail.com>
 <20230222143016.agjmng3xfpgfb3e2@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222143016.agjmng3xfpgfb3e2@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Feb 22, 2023 at 10:30:16PM +0800, Zorro Lang wrote:
> On Tue, Feb 21, 2023 at 02:36:49PM -0800, Leah Rumancik wrote:
> > diff --git a/README.selftest b/README.selftest
> > new file mode 100644
> > index 00000000..8f1d45af
> > --- /dev/null
> > +++ b/README.selftest
> > @@ -0,0 +1,22 @@
> > +Tests with consistent results are provided in the selftest folder.
> > +Since many people develop testing infrastructure around xfstests,
> > +these tests are helpful to confirm the testing setup is working as
> > +expected.
> > +
> > +The provided tests include:
> > +selftest/001 - pass
> > +selftest/002 - fail from output mismatch
> > +selftest/003 - fail via _fail
> > +selftest/004 - skip
> > +selftest/005 - crash
> > +selftest/006 - hang
> > +
> > +Two groups are used for these tests: selftest and dangerous_selftest.
> > +selftest/00[1-4] are in the selftest group and selftest/00[5-6] are
> > +in the dangerous_selftest group.
> > +
> > +The selftests will only be run if explicitly speficied. To run the
> > +selftests, you can specify individual tests, use "selftests/*", or
>                                                              ^
>                              The path name doesn't have the "s" :)
> 
> I'll change this when I merge it. Others looks good to me.

Good catch, thank you!

- Leah

> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> Thanks,
> Zorro
> 
> > +use the groups "-g selftest/selftest -g selftest/dangerous_selftest".
> > +Note, you cannot use the group names without including the folder name
> > +(ie. "-g selftest").
> > diff --git a/doc/group-names.txt b/doc/group-names.txt
> > index 771ce937..ace59e05 100644
> > --- a/doc/group-names.txt
> > +++ b/doc/group-names.txt
> > @@ -38,6 +38,7 @@ dangerous_fsstress_repair	race fsstress and xfs_scrub online repair
> >  dangerous_fsstress_scrub	race fsstress and xfs_scrub checking
> >  dangerous_repair	fuzzers to evaluate xfs_repair offline repair
> >  dangerous_scrub		fuzzers to evaluate xfs_scrub checking
> > +dangerous_selftest	selftests that crash/hang
> >  data			data loss checkers
> >  dax			direct access mode for persistent memory files
> >  db			xfs_db functional tests
> > @@ -111,6 +112,7 @@ samefs			overlayfs when all layers are on the same fs
> >  scrub			filesystem metadata scrubbers
> >  seed			btrfs seeded filesystems
> >  seek			llseek functionality
> > +selftest		tests with fixed results, used to validate testing setup
> >  send			btrfs send/receive
> >  shrinkfs		decreasing the size of a filesystem
> >  shutdown		FS_IOC_SHUTDOWN ioctl
> > diff --git a/tests/selftest/001 b/tests/selftest/001
> > new file mode 100755
> > index 00000000..f3480330
> > --- /dev/null
> > +++ b/tests/selftest/001
> > @@ -0,0 +1,13 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 001
> > +#
> > +# A test that should always pass
> > +#
> > +. ./common/preamble
> > +_begin_fstest selftest
> > +
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/selftest/001.out b/tests/selftest/001.out
> > new file mode 100644
> > index 00000000..88678b8e
> > --- /dev/null
> > +++ b/tests/selftest/001.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 001
> > +Silence is golden
> > diff --git a/tests/selftest/002 b/tests/selftest/002
> > new file mode 100755
> > index 00000000..189ae2cb
> > --- /dev/null
> > +++ b/tests/selftest/002
> > @@ -0,0 +1,13 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 002
> > +#
> > +# A test that should always fail due to output mismatch
> > +#
> > +. ./common/preamble
> > +_begin_fstest selftest
> > +
> > +echo "I am intentionally broken"
> > +status=0
> > +exit
> > diff --git a/tests/selftest/002.out b/tests/selftest/002.out
> > new file mode 100644
> > index 00000000..61705c7c
> > --- /dev/null
> > +++ b/tests/selftest/002.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 002
> > +Silence is golden
> > diff --git a/tests/selftest/003 b/tests/selftest/003
> > new file mode 100755
> > index 00000000..c7a2848c
> > --- /dev/null
> > +++ b/tests/selftest/003
> > @@ -0,0 +1,15 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 003
> > +#
> > +# A test that _fail's
> > +#
> > +
> > +. ./common/preamble
> > +_begin_fstest selftest
> > +
> > +_fail "I have _fail'ed"
> > +
> > +status=0
> > +exit
> > diff --git a/tests/selftest/003.out b/tests/selftest/003.out
> > new file mode 100644
> > index 00000000..6895fc80
> > --- /dev/null
> > +++ b/tests/selftest/003.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 003
> > +Silence is golden
> > diff --git a/tests/selftest/004 b/tests/selftest/004
> > new file mode 100755
> > index 00000000..89a3884d
> > --- /dev/null
> > +++ b/tests/selftest/004
> > @@ -0,0 +1,15 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 004
> > +#
> > +# A test that should always be skipped
> > +#
> > +. ./common/preamble
> > +_begin_fstest selftest
> > +
> > +_notrun "Always skip me"
> > +
> > +echo "I should be skipped"
> > +status=0
> > +exit
> > diff --git a/tests/selftest/004.out b/tests/selftest/004.out
> > new file mode 100644
> > index 00000000..af8614ae
> > --- /dev/null
> > +++ b/tests/selftest/004.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 004
> > +Silence is golden
> > diff --git a/tests/selftest/005 b/tests/selftest/005
> > new file mode 100755
> > index 00000000..738cf44d
> > --- /dev/null
> > +++ b/tests/selftest/005
> > @@ -0,0 +1,16 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 005
> > +#
> > +# A test that crashes
> > +#
> > +. ./common/preamble
> > +_begin_fstest dangerous_selftest
> > +
> > +echo 1 > /proc/sys/kernel/sysrq
> > +echo c > /proc/sysrq-trigger
> > +
> > +echo "I should have crashed by now"
> > +status=0
> > +exit
> > diff --git a/tests/selftest/005.out b/tests/selftest/005.out
> > new file mode 100644
> > index 00000000..a5027f12
> > --- /dev/null
> > +++ b/tests/selftest/005.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 005
> > +Silence is golden
> > diff --git a/tests/selftest/006 b/tests/selftest/006
> > new file mode 100755
> > index 00000000..150de6e8
> > --- /dev/null
> > +++ b/tests/selftest/006
> > @@ -0,0 +1,19 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# FS QA Test No. 006
> > +#
> > +# A test that hangs
> > +#
> > +
> > +. ./common/preamble
> > +_begin_fstest dangerous_selftest
> > +
> > +while :
> > +do
> > +    sleep 1d
> > +done
> > +
> > +echo "I should still be sleeping"
> > +status=0
> > +exit
> > diff --git a/tests/selftest/006.out b/tests/selftest/006.out
> > new file mode 100644
> > index 00000000..675c1b7c
> > --- /dev/null
> > +++ b/tests/selftest/006.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 006
> > +Silence is golden
> > diff --git a/tests/selftest/Makefile b/tests/selftest/Makefile
> > new file mode 100644
> > index 00000000..3ddfca37
> > --- /dev/null
> > +++ b/tests/selftest/Makefile
> > @@ -0,0 +1,24 @@
> > +#
> > +# Copyright (c) 2023 Google, Inc. All Rights Reserved.
> > +#
> > +
> > +TOPDIR = ../..
> > +include $(TOPDIR)/include/builddefs
> > +include $(TOPDIR)/include/buildgrouplist
> > +
> > +SELFTEST_DIR = selftest
> > +TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(SELFTEST_DIR)
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
> > 2.39.2.637.g21b0678d19-goog
> > 
> 
