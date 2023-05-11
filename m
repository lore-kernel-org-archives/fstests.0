Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B20CC7EE22
	for <linux-fstests@archiver.kernel.org>; Thu, 11 May 2023 13:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbjEKNm4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 May 2023 09:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbjEKNmh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 May 2023 09:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937BA3ABA
        for <fstests@vger.kernel.org>; Thu, 11 May 2023 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683812460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7IYQ59sXtL6/QE+YMFwgOzbGIJ8ZnCValvpgH5SCqLw=;
        b=Ib8VOeaB100sOI8AHNklXlvqbhovhaWK5DyXr4gdJ4pYOQa6O34SE509+tscRosLul/VZ7
        X5jb0OQNDpeZ7rhr/hhrdeFrJVHx69UnXrXDyQp9/vYlUXSbT1CfdufFCLw2c2UhdrDOoz
        xmzxO+EmTSSVEmDU2P5ds8cPaf2vtKw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-Zbg-_e-5MEe5OS3YkXnOKg-1; Thu, 11 May 2023 09:40:59 -0400
X-MC-Unique: Zbg-_e-5MEe5OS3YkXnOKg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-24e0d569a01so4712561a91.2
        for <fstests@vger.kernel.org>; Thu, 11 May 2023 06:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683812458; x=1686404458;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7IYQ59sXtL6/QE+YMFwgOzbGIJ8ZnCValvpgH5SCqLw=;
        b=UsdK+jcReZlp1nlATdEAeQK77/Q4D5kQDX9WZy/By/k6NYEQR0EpZsrgqQkDxX4e2s
         Q4GqYcqP468WujJsfsYZ4HhmVdhniQHFne8rm3oBW5K6/g8X7TY9lgE0ZqONyZYS6KNW
         wGEu99SqipkHlynmh8/3AQH4NXbpK1GEFXOGeGIBA5EViCUCmkx+g3i2AKCZEMIwm5uA
         6ZH/wJoVWlQ9LbQsQfbpDr42Zma4JaW7W8NEDn9UsiiegDNtQ6CjI7ml3YEo7ryrg++8
         iQEVC5L0jZHNrl2dSYSxUYcA8q8pjD7MFeO56q45rSzLkHgCh1a+TJOGFfPW8E0KBGfu
         Lj3A==
X-Gm-Message-State: AC+VfDyT7feuPI7b7VWWoz2++3yrKOHmdEXlT8Lkkt2rO0lPk+nw9jZi
        iBg6WUgIgUnLnChGcWJ07Hl3UBjs1sl5oSuy+8eB4TfmN5OspRDRQ7ifGqodfmRPcKuSSmlH4x2
        2jxY3Wqr3iNbr7RXqFXf7R4LL3jMY
X-Received: by 2002:a17:90b:fc7:b0:24e:3316:157d with SMTP id gd7-20020a17090b0fc700b0024e3316157dmr21170681pjb.26.1683812458244;
        Thu, 11 May 2023 06:40:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4c8ZXKfYYzAn1JbSDJ/NH02fuKG6kxGdvjjxH6wvwQdDK/KcAsjYqgM08S4ynLX6KChM+nsw==
X-Received: by 2002:a17:90b:fc7:b0:24e:3316:157d with SMTP id gd7-20020a17090b0fc700b0024e3316157dmr21170637pjb.26.1683812457337;
        Thu, 11 May 2023 06:40:57 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h23-20020a632117000000b00528da88275bsm4994563pgh.47.2023.05.11.06.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 06:40:56 -0700 (PDT)
Date:   Thu, 11 May 2023 21:40:53 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/728: Add a test for xattr ctime updates
Message-ID: <20230511134053.pbz46ny6de7rqb6p@zlang-mailbox>
References: <20230505172427.94963-1-anna@kernel.org>
 <20230510124511.wcgy63menqywvt34@zlang-mailbox>
 <CAFX2Jf=ma0cFAST9_Bfbekxa_2M8JC2TgwLLEDw-1QDK9SbZ1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFX2Jf=ma0cFAST9_Bfbekxa_2M8JC2TgwLLEDw-1QDK9SbZ1w@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 10, 2023 at 12:13:59PM -0400, Anna Schumaker wrote:
> On Wed, May 10, 2023 at 8:45 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Fri, May 05, 2023 at 01:24:27PM -0400, Anna Schumaker wrote:
> > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > >
> > > The NFS client wasn't updating ctime after a setxattr request. This is a
> > > test written while fixing the bug.
> > >
> > > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > >
> > > ---
> > > v2:
> > >  - Move test to generic/
> > >  - Address comments from the mailing list
> > > ---
> > >  tests/generic/728     | 42 ++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/728.out |  2 ++
> > >  2 files changed, 44 insertions(+)
> > >  create mode 100755 tests/generic/728
> > >  create mode 100644 tests/generic/728.out
> > >
> > > diff --git a/tests/generic/728 b/tests/generic/728
> > > new file mode 100755
> > > index 000000000000..ab2414c151db
> > > --- /dev/null
> > > +++ b/tests/generic/728
> > > @@ -0,0 +1,42 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2023 Netapp Inc., All Rights Reserved.
> > > +#
> > > +# FS QA Test 728
> > > +#
> > > +# Test a bug where the NFS client wasn't sending a post-op GETATTR to the
> > > +# server after setting an xattr, resulting in `stat` reporting a stale ctime.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick attr
> > > +
> > > +# Import common functions
> > > +. ./common/attr
> > > +
> > > +# real QA test starts here
> > > +_supported_fs generic
> > > +_require_test
> > > +_require_attrs
> > > +
> > > +rm -rf $TEST_DIR/testfile
> > > +touch $TEST_DIR/testfile
> > > +
> > > +
> > > +_check_xattr_op()
> > > +{
> > > +  what=$1
> > > +  shift 1
> > > +
> > > +  before_ctime=$(stat -c %z $TEST_DIR/testfile)
> > > +  $SETFATTR_PROG $* $TEST_DIR/testfile
> >
> > Hi Anna,
> >
> > If there's not objection from you, I'll add below codes at here, and merge
> > this case in next fstests release:
> 
> Yeah, no objection from me. Sorry I haven't had a chance to get around
> to the change this week, I've been doing LSF.

Oh, no push, hope you enjoy that!

> 
> >
> > +       # There might be filesystem's timestamp granularity, so sleep 2 seconds
> > +       # for most filesystems can capture a different timestamp across a
> > +       # setxattr operation
> > +       sleep 2s
> >
> > BTW, is there a known git commit which fix the issue of this case trying to
> > test?
> 
> Not yet, but there will be soon. Those patches are still in review and
> might need minor fixups. Can the git commit be added once they're
> ready?

Sure. Someone would like to add that later (don't forget:), someone else would
like to write the commit id as "xxxxxxxxx", then replace it after the patch get
merged. Both ways are good to me.

If you prefer the former, I can merge this V2 with above change. Or I can wait
the V3 from you.

Thanks,
Zorro

> 
> Anna
> 
> >
> > Thanks,
> > Zorro
> >
> > > +  after_ctime=$(stat -c %z $TEST_DIR/testfile)
> > > +
> > > +  test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change after $what."
> > > +}
> > > +
> > > +_check_xattr_op setxattr -n user.foobar -v 123
> > > +_check_xattr_op removexattr -x user.foobar
> > > +
> > > +echo "Silence is golden"
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/728.out b/tests/generic/728.out
> > > new file mode 100644
> > > index 000000000000..ab39f45fe5da
> > > --- /dev/null
> > > +++ b/tests/generic/728.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 728
> > > +Silence is golden
> > > --
> > > 2.40.1
> > >
> >
> 

