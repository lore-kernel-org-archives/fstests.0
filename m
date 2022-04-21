Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91CEC433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 21 Apr 2022 07:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348639AbiDUHIJ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 21 Apr 2022 03:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385559AbiDUHII (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 21 Apr 2022 03:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B512BCC
        for <fstests@vger.kernel.org>; Thu, 21 Apr 2022 00:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B40DA61993
        for <fstests@vger.kernel.org>; Thu, 21 Apr 2022 07:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49304C385A1;
        Thu, 21 Apr 2022 07:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650524718;
        bh=DxuvkS9YjOKcv15iyqATkOJqK0ItOh6OAB9xBiQUpKY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=fHvUSxVnEzTrRdz93Oomg3TJUk4SWcwQdpqKTwWatftLO+WAu5lBX7jtu33aM7CEN
         R2pjc9O21yTmuvXFKe6T5ETyp2E7O1+gTQnQ3oAyU6MCEEI7T6ZrgWjlMNBS0uJ2NZ
         WvQR8iez5gKcPGzh44skuMQK5zWVMsMHs6IH/QXA4iyb+GKyfpDtjlrxBkx49gp/Mx
         fENA1aW3pmlfqWAtCRC6+NPPn6o7e2c9jmkcdDUZhynIhovNuJ3E/vdWlVOdufOJtA
         KrE4PNgeFN5Thgm6JplhiEmGZ28F7bGtHz+m1VN/6eaDJyjATSrBafWjaeqZXglJx2
         YqazhkOexUqPQ==
Date:   Thu, 21 Apr 2022 09:05:13 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>, Peter Jin <peter@peterjin.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] generic: add test for tmpfs POSIX ACLs
Message-ID: <20220421070513.wcqz7kzmcm3u5uok@wittgenstein>
References: <20220419131423.2367795-1-brauner@kernel.org>
 <20220420175221.2502964-1-brauner@kernel.org>
 <20220421054120.suxfy3y7za3mgkkg@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220421054120.suxfy3y7za3mgkkg@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 21, 2022 at 01:41:20PM +0800, Zorro Lang wrote:
> On Wed, Apr 20, 2022 at 07:52:22PM +0200, Christian Brauner wrote:
> > Add a regression test for commit 705191b03d50 ("fs: fix acl translation").
> > This tests whether setting POSIX ACLs on a tmpfs mounted in a
> > non-initial user and mount namespace works as expected.
> > 
> > Note, once again the idmapped mount testsuite is grossly misnamed at
> > this point. It has morphed into a full-blown generic vfs feature
> > testsuite.
> 
> Hi,
> 
> Good to know that, the idmapped-mounts things already been extended to 15k+
> lines[1] code, it's even much more than the unionmount-testsuite[2]. So I
> think it's time to think about shifting it from fstests/src to be an independent
> testsuit, we can learn what 35c7a37928fd ("overlay: run unionmount testsuite test
> cases") did, maintain idmapped-mounts testsuite outside, then let fstests to be a
> wrapper to run it.

I'd like to avoid that. The testsuite tests a lot of core vfs
functionality - completely indepenent of idmapped mounts which is why I
should rename it - that isn't covered anwywhere else in xfstests.
It also contains various regressions tests for core vfs work.
Let's keep it in a single repo which will guarantee us that it will be
run as part of xfstests.

Christian

> 
> 
> [1]
> $ wc -l src/idmapped-mounts/*.[ch]
>  14113 src/idmapped-mounts/idmapped-mounts.c
>    151 src/idmapped-mounts/missing.h
>    201 src/idmapped-mounts/mount-idmapped.c
>    425 src/idmapped-mounts/utils.c
>    130 src/idmapped-mounts/utils.h
>  15020 total
> 
> [2]
> https://github.com/amir73il/unionmount-testsuite
> 
> > 
> > Cc: Eryu Guan <guaneryu@gmail.com>
> > Cc: Seth Forshee <sforshee@digitalocean.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Zorro Lang <zlang@redhat.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> > Hey,
> > 
> > As promised yesterday in
> > https://lore.kernel.org/linux-fsdevel/20220419131423.2367795-1-brauner@kernel.org
> > this adds a regression test to xfstests.
> > 
> > Thanks!
> > Christian
> > ---
> >  src/idmapped-mounts/idmapped-mounts.c | 140 +++++++++++++++++++++++++-
> >  tests/generic/683                     |  32 ++++++
> >  tests/generic/683.out                 |   2 +
> >  3 files changed, 173 insertions(+), 1 deletion(-)
> >  create mode 100755 tests/generic/683
> >  create mode 100644 tests/generic/683.out
> > 
> 
> [snip]
> 
> > diff --git a/tests/generic/683 b/tests/generic/683
> > new file mode 100755
> > index 00000000..397548ed
> > --- /dev/null
> > +++ b/tests/generic/683
> > @@ -0,0 +1,32 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 Christian Brauner (Microsoft).  All Rights Reserved.
> > +#
> > +# FS QA Test No. 683
> > +#
> > +# Test that setting POSIX ACLs in userns-mountable filesystems works.
> > +#
> > +# Regression test for commit:
> > +#
> > +# 705191b03d50 ("fs: fix acl translation")
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick perms
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +
> > +# real QA test starts here
> > +
> > +_supported_fs generic
> > +_require_test
> 
> Better to have _require_idmapped_mounts at here. I'd like to leave idmapped-mounts.c
> part for vfs reviewing.
> 
> Thanks for this new testing coverage,
> Zorro
> 
> > +_require_user fsgqa
> > +_require_group fsgqa
> > +
> > +echo "Silence is golden"
> > +
> > +$here/src/idmapped-mounts/idmapped-mounts --test-setxattr-fix-705191b03d50 \
> > +	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
> > +
> > +status=$?
> > +exit
> > diff --git a/tests/generic/683.out b/tests/generic/683.out
> > new file mode 100644
> > index 00000000..7f2a2ace
> > --- /dev/null
> > +++ b/tests/generic/683.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 683
> > +Silence is golden
> > 
> > base-commit: fbc6486be09c93a68d3863ebf7e3ed851fc4721c
> > -- 
> > 2.32.0
> > 
> 
