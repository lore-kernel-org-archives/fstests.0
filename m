Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA24C05027
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Feb 2023 05:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBIFx7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Feb 2023 00:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBIFx6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Feb 2023 00:53:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E4C59E2
        for <fstests@vger.kernel.org>; Wed,  8 Feb 2023 21:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675921990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P+1RnTqS5ecVe7WbW2/jZ3+6yQ0adcHScVxPhe1aCqY=;
        b=TsxNyX0X22pv5HxWivt3TP2bZgdIq70SBkd0rxD00WKUqbXQeaXuaLvUHzMHKGCXosRHDU
        JJc0XpLCvJod57goRIbrzUXsTuO3pWxTQ8OraeLmeB42/7R18i7v7S1/lQcQ++82BTZXbr
        L4TNP1xflAWfXWqCOQr+SdbRJv8E2us=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629-P8CVohIVPwCumwzrNiS4Aw-1; Thu, 09 Feb 2023 00:53:08 -0500
X-MC-Unique: P8CVohIVPwCumwzrNiS4Aw-1
Received: by mail-pg1-f198.google.com with SMTP id c15-20020a63ea0f000000b004fb3ed8a500so636759pgi.10
        for <fstests@vger.kernel.org>; Wed, 08 Feb 2023 21:53:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+1RnTqS5ecVe7WbW2/jZ3+6yQ0adcHScVxPhe1aCqY=;
        b=VI0PjyhjJzcVHL6jKo8Rh2GLqhYFlU1t/CXCCpEOr4r1kOK7Zhxoe4V3JOnj0jHgDk
         zIuyw0agGvBqxSAOGZz+n3C5qtJYsiYy+ngcfpMsMt3ZVtWhAu3py1dxbtuW6LbEdZeB
         krIg4qqpcv0cTYlTgS5tRAhdzrJNz0d/tNYpPUGEpl02Iqs9G/W3HijogNKfwlXKkCMZ
         sni/gtEav4GpWgXXifUuNC4WJ0KksVLDc4XXPakQ5jVcuzK6F0Cic/HmC28vf7XUK5TV
         9k32lWs6tCLhkaxkFp1luh/uNovz5BNxhhvlGqQQHbgQQWj4+NJFW0scaZdZ9sqPksl8
         XTjw==
X-Gm-Message-State: AO0yUKVoqiQwjRV4NiXsiFkCx65EFG0RylyVjtVvgvqfRiyFrcCFkQIe
        cOVvSxKBTZyh4Wr6IclUtHSGJNYq2sW3cYjv9pi0bLlzM4er1naxiN0SEBRoY27zgGollIniqig
        G1WFBy1tR1GZqTUaITZspA7sy5Kg7
X-Received: by 2002:a17:902:f24a:b0:199:547c:9138 with SMTP id j10-20020a170902f24a00b00199547c9138mr2322795plc.47.1675921987316;
        Wed, 08 Feb 2023 21:53:07 -0800 (PST)
X-Google-Smtp-Source: AK7set8Ufe/ZsZnzQrWHm9/mV+uplFNwjiL0WxKHjuZBYOrSBXHmyooSRT/EU8YKjLfFpLDctFZwaQ==
X-Received: by 2002:a17:902:f24a:b0:199:547c:9138 with SMTP id j10-20020a170902f24a00b00199547c9138mr2322783plc.47.1675921986964;
        Wed, 08 Feb 2023 21:53:06 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id w11-20020a170902ca0b00b0019926c77577sm476573pld.90.2023.02.08.21.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 21:53:06 -0800 (PST)
Date:   Thu, 9 Feb 2023 13:53:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] debug: add tests for debugging testing setup
Message-ID: <20230209055302.osegwiqx77lav4p2@zlang-mailbox>
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
> > ---
> >  doc/group-names.txt  |  1 +
> >  tests/debug/001      | 14 ++++++++++++++
> >  tests/debug/001.out  |  2 ++
> >  tests/debug/002      | 14 ++++++++++++++
> >  tests/debug/002.out  |  2 ++
> >  tests/debug/003      | 16 ++++++++++++++++
> >  tests/debug/003.out  |  2 ++
> >  tests/debug/004      | 17 +++++++++++++++++
> >  tests/debug/004.out  |  2 ++
> >  tests/debug/005      | 20 ++++++++++++++++++++
> >  tests/debug/005.out  |  2 ++
> >  tests/debug/Makefile | 24 ++++++++++++++++++++++++
> >  12 files changed, 116 insertions(+)
> >  create mode 100755 tests/debug/001
> >  create mode 100644 tests/debug/001.out
> >  create mode 100755 tests/debug/002
> >  create mode 100644 tests/debug/002.out
> >  create mode 100755 tests/debug/003
> >  create mode 100644 tests/debug/003.out
> >  create mode 100755 tests/debug/004
> >  create mode 100644 tests/debug/004.out
> >  create mode 100755 tests/debug/005
> >  create mode 100644 tests/debug/005.out
> >  create mode 100644 tests/debug/Makefile
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
> 
> Also a dangerous_selftests for tests that will crash or hang the test
> appliances.  I'd really like to run this every time I start up fstests,
> albeit without the dangerous ones. :)

I agree with this. When I saw *debug*, I thought it's about some kernel/fs
debuging test, or it need kernel debug option. So *selftest* might be a better
name, or if someone has better idea :)

With group name changing, I think better to change tests/debug/ directory to
tests/selftests/.

> 
> Or <cough> fsteststests.
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

Agree

> 
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

Do you need to change this ^^ ?

Thanks,
Zorro

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
> 

