Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3F9C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Jul 2022 16:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiGUQnT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGUQnT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Jul 2022 12:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4269980F42
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 09:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658421796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EV8xjVe+gKzRO5oRabRnLwZ3MmJXguj/eTNP/g3jfMc=;
        b=Zo/0ir9UYfSd0MSEPsNeaLmwmW8W4zYun8JDqoGS4/Q9dTiL1OStxkMobzNxc5L288NNOq
        3Igw6lsqJ753GvCHy3duOdNqRAC9iHfJlbJm+r88A+3WISZnFa4oRvCm8VJQngG7NnJ8Do
        gLbTLSHoOaWMhKUiQaBjspnPRCaxhQA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-yu10rQygPf2hymuKuD6zIA-1; Thu, 21 Jul 2022 12:43:15 -0400
X-MC-Unique: yu10rQygPf2hymuKuD6zIA-1
Received: by mail-qk1-f198.google.com with SMTP id v13-20020a05620a0f0d00b006b5f0ec742eso1723940qkl.2
        for <fstests@vger.kernel.org>; Thu, 21 Jul 2022 09:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EV8xjVe+gKzRO5oRabRnLwZ3MmJXguj/eTNP/g3jfMc=;
        b=YTYLA1o+jOZI0p9Uadf55XCbstY8Hynx7clW0GOmtwOzChfxbFmpJDuD1xwGTs6c3k
         uzfbvSAGf52ahBDBHPFmcj5zsXSq35CX2qm8KqHDVWCFHe8msKJCCXINBLK7MKnvUJL/
         mvzA480r/9RqB5MZuzeA9Qus4yszkwUyUMBlIgbqDaYsRwGVhDZXvZzZQeGPaG0vYwZV
         O/jaeB4x7ffbYP/SbcZtXSGfNfo/Rbepg+jOPew/oxhyIW7PP+9/n5mgnsVzPJIG5CBy
         lXzapUwRIdAXz1UMcgl/tfBnajcwX1Mj8iJtpTFx5IiZvfFB7WGxQ7fysZ5P2zK+D5Fm
         kvdQ==
X-Gm-Message-State: AJIora9RK9ER1xnJreyeSZKfSf3gIGjOxNcXD/ANz5ula293PnaUoc2q
        21lFYT3Lcbk5L7yv0xt7hB2EwmSbf7mUnwl+niY/E7h8EeOPCPM1EFq8gE9YkUTLm04EvYYdcN3
        zqeMJzT3r5Ll/XK76DA==
X-Received: by 2002:a05:6214:1c4f:b0:473:7909:85e2 with SMTP id if15-20020a0562141c4f00b00473790985e2mr36288368qvb.69.1658421794296;
        Thu, 21 Jul 2022 09:43:14 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vOh9B6Bl6bqdrAmybwlgZWDETBtLnJ+W8Uh4sT5I7JPYYteaJROLd8nBIhVMHczDyaA4T2Jw==
X-Received: by 2002:a05:6214:1c4f:b0:473:7909:85e2 with SMTP id if15-20020a0562141c4f00b00473790985e2mr36288346qvb.69.1658421793978;
        Thu, 21 Jul 2022 09:43:13 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o17-20020ac841d1000000b0031bf484079esm1559355qtm.18.2022.07.21.09.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:43:13 -0700 (PDT)
Date:   Fri, 22 Jul 2022 00:43:08 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Yang Xu <xuyang2018.jy@fujitsu.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/549: test mkfs.xfs whether terminate getsubopt
 arrays properly
Message-ID: <20220721164308.p6gx2kfy6fjrbppz@zlang-mailbox>
References: <1658295937-2169-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ytg5j+So+WP0PXNP@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytg5j+So+WP0PXNP@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 20, 2022 at 10:21:19AM -0700, Darrick J. Wong wrote:
> On Wed, Jul 20, 2022 at 01:45:37PM +0800, Yang Xu wrote:
> > When I run xfs/144 manually, the step as below:
> > mkfs.xfs -f -d agcount=3200,size=6366g -d file,n
> > 
> > I accidentally pressed the Enter key, it triggers Segmentation fault.
> > Then I found Darrick has fixed this one weeks ago. So add this test.
> > 
> > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > ---
> >  tests/xfs/549     | 33 +++++++++++++++++++++++++++++++++
> >  tests/xfs/549.out |  2 ++
> >  2 files changed, 35 insertions(+)
> >  create mode 100755 tests/xfs/549
> >  create mode 100644 tests/xfs/549.out
> > 
> > diff --git a/tests/xfs/549 b/tests/xfs/549
> > new file mode 100755
> > index 00000000..31ead3c7
> > --- /dev/null
> > +++ b/tests/xfs/549
> > @@ -0,0 +1,33 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> > +#
> > +# FS QA Test 549
> > +#
> > +# Regression test for xfsprogs commit
> > +# 50dba8189b1f ("mkfs: terminate getsubopt arrays properly")
> > +#
> > +# This case test mkfs.xfs whether can terminate getsubopt arrays properly.
> > +# If not, it will trigger segmentation fault.
> > +#
> > +
> > +. ./common/preamble
> > +_begin_fstest auto quick mkfs
> > +
> > +# real QA test starts here
> > +_supported_fs xfs
> > +_fixed_by_git_commit xfsprogs 50dba8189b1f \
> > +	"mkfs: terminate getsubopt arrays properly"
> > +_require_test
> > +
> > +testfile=$TEST_DIR/a
> > +rm -rf $testfile
> > +
> > +$MKFS_XFS_PROG -f -d agcount=4 -d file,name=$testfile,nrext64=0 \
> > +	>> $seqres.full  2>&1
> 
> Heh, you don't even need $testfile --
> 
> "$MKFS_XFS_PROG -d agcount=3 -d garbagegarbagegarbage=0"
> 
> is enough to cause the crash.  But this works just as well, so

Thanks Darrick.

If it's not needed, let's remove those meaningless lines, likes

  testfile=$TEST_DIR/a
  rm -rf $testfile
  $MKFS_XFS_PROG -f -d agcount=4 -d file,name=$testfile,nrext64=0

That makes me feel this test need "EEXIST" error, to trigger this bug :)

Thanks,
Zorro


> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> > +
> > +echo "Silence is golden"
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/xfs/549.out b/tests/xfs/549.out
> > new file mode 100644
> > index 00000000..4e3acd3f
> > --- /dev/null
> > +++ b/tests/xfs/549.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 549
> > +Silence is golden
> > -- 
> > 2.23.0
> > 
> 

