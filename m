Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE77EC77B7D
	for <linux-fstests@archiver.kernel.org>; Thu, 18 May 2023 05:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjERFWP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 May 2023 01:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjERFWO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 May 2023 01:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F352D77
        for <fstests@vger.kernel.org>; Wed, 17 May 2023 22:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684387286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wc+27JL/yOtB8a9pG/9pB0vmWbj5yDS5LrHGaZGLLHM=;
        b=f6vWgY44dReN9eikyk7qBnmKfXjdSkYT+86Or5f0Hj5FoddbaPwQ1vF0zJXVCh445+QwIM
        MM925HlzfSS7dpBXtqm67qG/AGWLWKJRGcy7KEcBxl5fPWLbT7MxqdRzDjoFkn9+Kv10rm
        ZXaMdvXyCxMA4zlJfToaqYnkjyt0wKs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-7gPNrSApMrK5TY7K0vsStw-1; Thu, 18 May 2023 01:21:25 -0400
X-MC-Unique: 7gPNrSApMrK5TY7K0vsStw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-24de504c5fcso1777760a91.2
        for <fstests@vger.kernel.org>; Wed, 17 May 2023 22:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684387284; x=1686979284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wc+27JL/yOtB8a9pG/9pB0vmWbj5yDS5LrHGaZGLLHM=;
        b=BCxuy9oVEiVgjKMAubSZwONNQ9G2tW0OFsWmo5uCu13MwTcfBoZAF2VVS3OuyqL7Af
         B8ymJUdZE6sX2JeUTXw7dWOKDRpq9g4dCqfKvWmiq2oJgAPpx6xl5G+OkdhZsLN/aevU
         dLJEYoY4ynOIU5KjH4ZFntyumb2YBbYCc94+oeErW78pTvLmz61vq9KxPW2zqdBfmzWq
         borClM3LSlJ5C3GkqcnMspMk5zehHpuoswuiP8yn9+lyOlvOyVR/bTyk6qMYf5KcBVNq
         fdvWyloO/jeJe6U/ILxt9FWWHwko56XuJAOI47gTNzXWM5FVM+u5oR3ov69uiYRzPwNj
         Fnwg==
X-Gm-Message-State: AC+VfDyKmtFdZa8bnV8tVNBApFjGlRvIYimzdZI6cVz0IaUvS2qopMOh
        FKH3cWS3y07X0LsRdpHpCc9HVFHcKBAzvvFuH4AJFBu2S//g+e0mvYvsbIoTIbc4Ghv+l1ZS+9h
        n5kDguvIvKYLeYoRtcg==
X-Received: by 2002:a17:902:eb46:b0:1ae:89a:92 with SMTP id i6-20020a170902eb4600b001ae089a0092mr1324170pli.59.1684387284118;
        Wed, 17 May 2023 22:21:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4NuKpN7cVRM0ETD6pMBPt6iVxSpDl2D/m6w2E6HHup5ZO4MbT2ko+dhIK+4tFQ4J/XwXs+oA==
X-Received: by 2002:a17:902:eb46:b0:1ae:89a:92 with SMTP id i6-20020a170902eb4600b001ae089a0092mr1324152pli.59.1684387283704;
        Wed, 17 May 2023 22:21:23 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b001a6388ce38bsm312079plg.240.2023.05.17.22.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 22:21:23 -0700 (PDT)
Date:   Thu, 18 May 2023 13:21:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v3] generic/728: Add a test for xattr ctime updates
Message-ID: <20230518052119.n6egt7itugl7wjyb@zlang-mailbox>
References: <20230516141407.201674-1-anna@kernel.org>
 <20230516150027.GB858795@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516150027.GB858795@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 16, 2023 at 08:00:27AM -0700, Darrick J. Wong wrote:
> On Tue, May 16, 2023 at 10:14:07AM -0400, Anna Schumaker wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > The NFS client wasn't updating ctime after a setxattr request. This is a
> > test written while fixing the bug.
> > 
> > Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > ---
> > v3:
> >  - Add a 2 second sleep before changing the xattr
> > 
> > v2:
> >  - Move test to generic/
> >  - Address comments from the mailing list
> > ---
> >  tests/generic/728     | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/728.out |  2 ++
> >  2 files changed, 45 insertions(+)
> >  create mode 100755 tests/generic/728
> >  create mode 100644 tests/generic/728.out
> > 
> > diff --git a/tests/generic/728 b/tests/generic/728
> > new file mode 100755
> > index 000000000000..8e52eb4b219c
> > --- /dev/null
> > +++ b/tests/generic/728
> > @@ -0,0 +1,43 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2023 Netapp Inc., All Rights Reserved.
> > +#
> > +# FS QA Test 728
> > +#
> > +# Test a bug where the NFS client wasn't sending a post-op GETATTR to the
> > +# server after setting an xattr, resulting in `stat` reporting a stale ctime.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick attr
> > +
> > +# Import common functions
> > +. ./common/attr
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_require_test
> > +_require_attrs
> > +
> > +rm -rf $TEST_DIR/testfile
> > +touch $TEST_DIR/testfile
> > +
> > +
> > +_check_xattr_op()
> 
> nit: only common/* functions are supposed to have a leading underscore
> in the name.

I can help to remove the leading underscore when I merge this patch.

> 
> > +{
> > +  what=$1
> > +  shift 1
> > +
> > +  before_ctime=$(stat -c %z $TEST_DIR/testfile)
> > +  sleep 2
> 
> I think it would be useful to document that 2 seconds is the worst ctime
> granularity that we expect from any filesystem (fat) that might pass
> through fstests.
> 
> Just in case, you know, we /ever/ create a fsinfo call to export
> information like that, and need to refactor all these 'sleep 2'.
> 
> "sleep 2 # maximum known ctime granularity is 2s for fat"

Hi Anna, if you don't want to send a v4, you can reply this email to tell
us what comment you'd like to write. I can add it when I merge this patch.
Or you'd like to send a v4 by yourself :)

Thanks,
Zorro

> 
> With those two things fixed,
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> 
> > +  $SETFATTR_PROG $* $TEST_DIR/testfile
> > +  after_ctime=$(stat -c %z $TEST_DIR/testfile)
> > +
> > +  test "$before_ctime" != "$after_ctime" || echo "Expected ctime to change after $what."
> > +}
> > +
> > +_check_xattr_op setxattr -n user.foobar -v 123
> > +_check_xattr_op removexattr -x user.foobar
> > +
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/generic/728.out b/tests/generic/728.out
> > new file mode 100644
> > index 000000000000..ab39f45fe5da
> > --- /dev/null
> > +++ b/tests/generic/728.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 728
> > +Silence is golden
> > -- 
> > 2.40.1
> > 
> 

