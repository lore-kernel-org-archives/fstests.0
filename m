Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F079C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 14 Apr 2022 18:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbiDNTBb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 14 Apr 2022 15:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344963AbiDNTBb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 14 Apr 2022 15:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AD39186E9
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 11:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649962744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UkFyUxq95y4SEhEsvmmLMqPpqawmZDmzIVoyvb0a+us=;
        b=Q9bGw5HompOKIGEvOV2Duvgi3IOMQagL+O0L1JY6xZ+LPkgFeRtRIqxNq9SbdX5MWW6fxA
        eQ6A5NIFBQ2mrOp1JP8Iu+GnwwQT//ygfStdY/lvWuSf/aDXky8n5wXKYaXN76Z8RZoHl0
        QAaM687170v9p4jSQxpZ/lB292lWWDY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-hyCP188ZOUKcmwN-ETEqNQ-1; Thu, 14 Apr 2022 14:59:02 -0400
X-MC-Unique: hyCP188ZOUKcmwN-ETEqNQ-1
Received: by mail-qt1-f198.google.com with SMTP id o9-20020ac85549000000b002f1d0c8346eso3761701qtr.21
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 11:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=UkFyUxq95y4SEhEsvmmLMqPpqawmZDmzIVoyvb0a+us=;
        b=LSBmg7nQrNye4w/rKO3HlV8JFbwQ23+HaCr4slNWfgkoLRBQ8TBb0iCy0j3Vt4AOpq
         3pb1YP0GmMJD/KyZ8onVkYwmQQC1u2yCCTUbZIZ3uIKbbT0ujBaUpl/0VtiC2xxwgyfn
         XLxMdl14YXuKxZRWMDj1ojgM7tke3939BNFqXdQ4PJo5n9mqkxixEfgWuKhBq16fl3jI
         /0D+Id6sRvLb5d1oQxqjmgBcd3oGsL53mXoDy+A1osq3ZhTm0G9ZG3+XYC4wAIZIKq4e
         3mrSnCtPkp6ED/rEkli8fZdnxNIxTYhCCoeC2eIishWkkR6Qn9DBPzG/QuXqE2z1KXYU
         TjOw==
X-Gm-Message-State: AOAM5303mtTMZuS0g6F8XqcminfQRqKzdZjIpYnZBlCU4iu/EK1T3B7c
        z3cR310XI/N5ve3gZmtl8EHvZMufc2le3/zZQ2dt1lmLlZeX1/xv9O+vrH1NE2xNjV6vAKjzn+3
        Rw+kvAnc05xpXjZ3leA==
X-Received: by 2002:a05:620a:2586:b0:680:f846:4708 with SMTP id x6-20020a05620a258600b00680f8464708mr2918709qko.654.1649962741940;
        Thu, 14 Apr 2022 11:59:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxN5SMFyODng6rxtnOaiWayK84axAp0iGdo9vFUMd/ObEkbgU9mtkQvZOJJaFZnjIRFM/zVxw==
X-Received: by 2002:a05:620a:2586:b0:680:f846:4708 with SMTP id x6-20020a05620a258600b00680f8464708mr2918695qko.654.1649962741630;
        Thu, 14 Apr 2022 11:59:01 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d15-20020a05622a15cf00b002ef31d86837sm1662284qty.55.2022.04.14.11.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:59:01 -0700 (PDT)
Date:   Fri, 15 Apr 2022 02:58:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/4] xfs: make sure syncfs(2) passes back
 super_operations.sync_fs errors
Message-ID: <20220414185856.nmtg4xyh5atx7cp5@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <164971767143.169983.12905331894414458027.stgit@magnolia>
 <164971767699.169983.772317637668809854.stgit@magnolia>
 <20220412093727.5zsuh7mucv2wlwgm@zlang-mailbox>
 <20220412172853.GG16799@magnolia>
 <20220414144330.yby7dsxzqeawekmc@zlang-mailbox>
 <20220414154234.GB17014@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414154234.GB17014@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 14, 2022 at 08:42:34AM -0700, Darrick J. Wong wrote:
> On Thu, Apr 14, 2022 at 10:43:30PM +0800, Zorro Lang wrote:
> > On Tue, Apr 12, 2022 at 10:28:53AM -0700, Darrick J. Wong wrote:
> > > On Tue, Apr 12, 2022 at 05:37:27PM +0800, Zorro Lang wrote:
> > > > On Mon, Apr 11, 2022 at 03:54:37PM -0700, Darrick J. Wong wrote:
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > > 
> > > > > This is a regression test to make sure that nonzero error returns from
> > > > > a filesystem's ->sync_fs implementation are actually passed back to
> > > > > userspace when the call stack involves syncfs(2).
> > > > > 
> > > > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > > > ---
> > > > >  tests/xfs/839     |   42 ++++++++++++++++++++++++++++++++++++++++++
> > > > >  tests/xfs/839.out |    2 ++
> > > > >  2 files changed, 44 insertions(+)
> > > > >  create mode 100755 tests/xfs/839
> > > > >  create mode 100644 tests/xfs/839.out
> > > > > 
> > > > > 
> > > > > diff --git a/tests/xfs/839 b/tests/xfs/839
> > > > 
> > > > This case looks good to me. Just one question, is it possible to be a generic
> > > > case? From the code logic, it doesn't use xfs specified operations, but I'm
> > > > not sure if other filesystems would like to treat sync_fs return value as XFS.
> > > 
> > > Other filesystems (ext4 in particular) haven't been fixed to make
> > > ->sync_fs return error codes when the fs has been shut down via
> > > FS_IOC_SHUTDOWN.  We'll get there eventually, but for now I'd like to
> > > get this under test for XFS since we've applied those fixes.
> > 
> > If other filesystems intend to do that, how about using a generic case failure to
> > remind them they haven't done that :) If they don't intend that, keep this case
> > under xfs is good to me.
> 
> <shrug> I don't know if they do or not; I've been so strapped for time
> trying to get all these fixes out that I haven't had time to ask the
> ext4 or btrfs communities, let alone propose patches.
> 
> At the moment I'd really like to get as many patches out of djwong-dev
> as I can without people asking for more side projects.  As it stands
> today, landing the online fsck patchset is going to involve getting 185
> kernel patches, 95 xfsprogs patches, and 87 fstests patches all through
> review.

Sure, this case can be a xfs specified case at first. We'll see if need to
change it to be generic case later.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> --D
> 
> > > 
> > > > > new file mode 100755
> > > > > index 00000000..9bfe93ef
> > > > > --- /dev/null
> > > > > +++ b/tests/xfs/839
> > > > > @@ -0,0 +1,42 @@
> > > > > +#! /bin/bash
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +# Copyright (c) 2022 Oracle.  All Rights Reserved.
> > > > > +#
> > > > > +# FS QA Test No. 839
> > > > > +#
> > > > > +# Regression test for kernel commits:
> > > > > +#
> > > > > +# 5679897eb104 ("vfs: make sync_filesystem return errors from ->sync_fs")
> > > > > +# 2d86293c7075 ("xfs: return errors in xfs_fs_sync_fs")
> > > > 
> > > > BTW, after this change, now can I assume that sync(2) flushes all data and metadata
> > > > to underlying disk, if it returns 0.
> > > 
> > > Yes.
> > > 
> > > > Sorry, really confused on what these sync things
> > > > really guarantee :)
> > > 
> > > No worries -- the history of the sync variants has been very messy and
> > > confusing even to people on fsdevel.
> > > 
> > > --D
> > > 
> > > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > > > +#
> > > > > +# During a code inspection, I noticed that sync_filesystem ignores the return
> > > > > +# value of the ->sync_fs calls that it makes.  sync_filesystem, in turn is used
> > > > > +# by the syncfs(2) syscall to persist filesystem changes to disk.  This means
> > > > > +# that syncfs(2) does not capture internal filesystem errors that are neither
> > > > > +# visible from the block device (e.g. media error) nor recorded in s_wb_err.
> > > > > +# XFS historically returned 0 from ->sync_fs even if there were log failures,
> > > > > +# so that had to be corrected as well.
> > > > > +#
> > > > > +# The kernel commits above fix this problem, so this test tries to trigger the
> > > > > +# bug by using the shutdown ioctl on a clean, freshly mounted filesystem in the
> > > > > +# hope that the EIO generated as a result of the filesystem being shut down is
> > > > > +# only visible via ->sync_fs.
> > > > > +#
> > > > > +. ./common/preamble
> > > > > +_begin_fstest auto quick shutdown
> > > > > +
> > > > > +# real QA test starts here
> > > > > +
> > > > > +# Modify as appropriate.
> > > > > +_require_xfs_io_command syncfs
> > > > > +_require_scratch_nocheck
> > > > > +_require_scratch_shutdown
> > > > > +
> > > > > +# Reuse the fs formatted when we checked for the shutdown ioctl, and don't
> > > > > +# bother checking the filesystem afterwards since we never wrote anything.
> > > > > +_scratch_mount
> > > > > +$XFS_IO_PROG -x -c 'shutdown -f ' -c syncfs $SCRATCH_MNT
> > > > > +
> > > > > +# success, all done
> > > > > +status=0
> > > > > +exit
> > > > > diff --git a/tests/xfs/839.out b/tests/xfs/839.out
> > > > > new file mode 100644
> > > > > index 00000000..f275cdcc
> > > > > --- /dev/null
> > > > > +++ b/tests/xfs/839.out
> > > > > @@ -0,0 +1,2 @@
> > > > > +QA output created by 839
> > > > > +syncfs: Input/output error
> > > > > 
> > > > 
> > > 
> > 
> 

