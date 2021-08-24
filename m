Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F8AC4338F
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 16:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB8261357
	for <linux-fstests@archiver.kernel.org>; Tue, 24 Aug 2021 16:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhHXQdo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229596AbhHXQdn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 Aug 2021 12:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629822778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NkezBopDh4JA1Q9iuD+dOao4YIyYDK0GTQ7IbRsqyb0=;
        b=a9i/NqltwUnIfUdH/VsrbYxK10JzB+AoxvgW4dr7y4IfGhC2FTs3sRYwNDzz0O4KCzPvVJ
        eMZlkugkK9AqWFtphI43k9/klcrCbzC18L8ailI/s/m7xBRrJ3MBD3L0Q08qS+Tb/Suh59
        NxEHzoUiiC3WKYuRWPVx2R2M4F7tQG8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-9l8_rxRZM_uDbhZLuch26g-1; Tue, 24 Aug 2021 12:32:56 -0400
X-MC-Unique: 9l8_rxRZM_uDbhZLuch26g-1
Received: by mail-pg1-f198.google.com with SMTP id k28-20020a63ff1c0000b029023b84262596so12387978pgi.1
        for <fstests@vger.kernel.org>; Tue, 24 Aug 2021 09:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=NkezBopDh4JA1Q9iuD+dOao4YIyYDK0GTQ7IbRsqyb0=;
        b=fLbRVPfBuNw79FHHG7HHuZqFTxLbjNhIorOvEpMm9W5nN8eCNZcBaXni2PVBR4c5bk
         v7LxN/L7SbW0kBqz17ift9VSmMXXSXSNmDhVfd3cmIMPayRLd1ws/+Btef2oUE1P/9yX
         A62sVFdIemWO/4gvs7E/xRA4uwCC9l4IUVTcFHo5Yim8Z4halCj307uDbw1NPfJbSfi7
         FLdqyQ0w9oL0IF/vuo7IZXhrMl/ocshLIqFHHKoD5KCs9hxXLfweZE2O52PikIVkbrAC
         PkD/j5Q7iZhNIkOoVw0Vxwea3eNqRBWTmbDp0SsWbDm8WjQYPfRm5sI7qYpaTUdmuTRc
         sawg==
X-Gm-Message-State: AOAM532zApxGCrInmGoOkX3GXrhafNFmKKtFu8nJBem0Ff9D6ekQja+Q
        g6rtDVQ/IcyF2/6DbwPrOQU6PSAJCG3CxHC5QesKFAaI03ob2yaqufOwRd9tL1mUosRLJFfRV24
        BZMhrHEHDQdPFPzgaxw==
X-Received: by 2002:a17:902:7b83:b029:12c:2758:1d2d with SMTP id w3-20020a1709027b83b029012c27581d2dmr33803342pll.80.1629822774791;
        Tue, 24 Aug 2021 09:32:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2sNqxbYbxzZMs7V96eHJljZFq2ZgNx33gKmb1NFfrp/0eFv1T2BB+zBQnRr2v00jl7CR+FQ==
X-Received: by 2002:a17:902:7b83:b029:12c:2758:1d2d with SMTP id w3-20020a1709027b83b029012c27581d2dmr33803326pll.80.1629822774486;
        Tue, 24 Aug 2021 09:32:54 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j68sm23975794pgc.44.2021.08.24.09.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:32:54 -0700 (PDT)
Date:   Wed, 25 Aug 2021 00:53:41 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Murphy Zhou <xzhou@redhat.com>, fstests@vger.kernel.org,
        ddouwsma@redhat.com
Subject: Re: [PATCH v3] tests/xfs: check available blocks after log recovery
 on ro mount
Message-ID: <20210824165341.lvo5lwgosgh4n4ir@fedora>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        Murphy Zhou <xzhou@redhat.com>, fstests@vger.kernel.org,
        ddouwsma@redhat.com
References: <20210806014938.npfn2ykyirfrdlra@xzhoux.usersys.redhat.com>
 <20210806185545.GE3601425@magnolia>
 <20210823070541.mn2y4pn4256dwnhm@xzhoux.usersys.redhat.com>
 <20210823174316.GE12612@magnolia>
 <20210824050436.3l5jodgjhwt7wqzl@xzhoux.usersys.redhat.com>
 <20210824151428.GG12612@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824151428.GG12612@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Aug 24, 2021 at 08:14:28AM -0700, Darrick J. Wong wrote:
> On Tue, Aug 24, 2021 at 01:04:36PM +0800, Murphy Zhou wrote:
> > And followed by a rw mount.
> > 
> > Suggested-by:  Donald Douwsma <ddouwsma@redhat.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> > ---
> > 
> > Thanks Darrick very much for reviewing!
> > 
> > v2:
> >    Add explaination of the issue
> >    add xfs_force_bdev data $SCRATCH_MNT
> >    use DF_PROG
> >    Re numbered this test
> > v3:
> >    Add _require_scratch_shutdown
> >    Use _get_available_space
> >    Explain why does not use _scratch_mount
> > 
> >  tests/xfs/999     | 65 +++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/999.out |  2 ++
> >  2 files changed, 67 insertions(+)
> >  create mode 100755 tests/xfs/999
> >  create mode 100644 tests/xfs/999.out
> > 
> > diff --git a/tests/xfs/999 b/tests/xfs/999
> > new file mode 100755
> > index 00000000..0ce9989b
> > --- /dev/null
> > +++ b/tests/xfs/999
> > @@ -0,0 +1,65 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 RedHat All Rights Reserved.
> > +#
> > +# FS QA Test 999
> > +#
> > +# Testcase for kernel commit:
> > +#   50d25484bebe xfs: sync lazy sb accounting on quiesce of read-only mounts
> > +#
> > +# After shutdown and readonly mount, a following read-write mount would
> > +# get wrong number of available blocks. This is caused by unmounting the log
> > +# on a readonly filesystem doesn't log the sb counters.
> > +#
> > +. ./common/preamble
> > +_begin_fstest shutdown auto quick
> > +
> > +# real QA test starts here
> > +
> > +_supported_fs xfs
> > +_require_scratch
> > +_require_scratch_shutdown
> > +
> > +_scratch_mkfs > $seqres.full 2>&1
> > +# Don't use _scratch_mount because we need to mount without SELinux context
> > +# to reproduce this issue. If we mount with SELinux context, this testcase
> > +# is not reproducing the original issue.
> > +mount $SCRATCH_DEV $SCRATCH_MNT
> 
> This mount will fail if the test runner configured an external log or a
> realtime device, because you didn't specify those devices to the mount
> call.  Either this needs _require_nonexternal or $(_scratch_options
> mount) needs to be injected into the command line.

I think I know why Xiong said _scratch_mount can't reproduce this bug.

Before this patch v3, he tried to find the xfs corruption by using $DF_PROG $SCRATCH_MNT
before&after xfs_repair.

If we use _scratch_mount, new files we create won't contains SELinux label
in xfs inode attrfork. The corruption comes from sb_ifree (free inodes):
  Phase 2 - using internal log
        - zero log...
        - scan filesystem freespace and inode maps...
  sb_ifree 61, counted 60

But if we don't use _scratch_mount, the corruption comes from sb_fdblocks(free blocks):
  Phase 2 - using internal log
        - zero log...
        - scan filesystem freespace and inode maps...
  sb_fdblocks 130086290, counted 131007896

So if he use _scratch_mount, he can't get different available blocks by
$DF_PROG $SCRATCH_MNT, before&after xfs_repair. Due to the corrupted thing
is sb_ifree.

But I still can't understand one thing, even if do *not* use _scratch_mount, the attr(selinux label)
is local(short) format[1], didn't take more blocks. What takes more blocks, cause later
sb_fdblocks corruption?

Thanks,
Zorro

[1]
...
core.aformat = 1 (local)
...
u3 = (empty)
a.sfattr.hdr.totsize = 51
a.sfattr.hdr.count = 1
a.sfattr.list[0].namelen = 7
a.sfattr.list[0].valuelen = 37
a.sfattr.list[0].root = 0
a.sfattr.list[0].secure = 1
a.sfattr.list[0].name = "selinux"
a.sfattr.list[0].value = "unconfined_u:object_r:unlabeled_t:s0\000"


> 
> --D
> 
> > +_xfs_force_bdev data $SCRATCH_MNT
> > +
> > +# Write test file
> > +ls > $SCRATCH_MNT/testfile
> > +$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
> > +
> > +# Shutdown
> > +$XFS_IO_PROG -x -c "shutdown -f" $SCRATCH_MNT
> > +
> > +# Mount ReadOnly
> > +_scratch_unmount
> > +_scratch_mount -oro
> > +$DF_PROG $SCRATCH_MNT >> $seqres.full 2>&1
> > +# Umount and mount rw
> > +_scratch_unmount
> > +_scratch_mount
> > +
> > +# Get fdblocks before repair
> > +fdb1=$(_get_available_space $SCRATCH_MNT)
> > +_scratch_unmount
> > +
> > +# Repair
> > +_repair_scratch_fs >> $seqres.full 2>&1
> > +
> > +# Re-mount
> > +_scratch_mount
> > +
> > +# Get fdblocks after repair
> > +fdb2=$(_get_available_space $SCRATCH_MNT)
> > +
> > +echo fdb1 $fdb1 fdb2 $fdb2 >> $seqres.full 2>&1
> > +
> > +[ $fdb1 -ne $fdb2 ] && echo Wrong fdblocks: $fdb1 and $fdb2
> > +
> > +# success, all done
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/xfs/999.out b/tests/xfs/999.out
> > new file mode 100644
> > index 00000000..3b276ca8
> > --- /dev/null
> > +++ b/tests/xfs/999.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 999
> > +Silence is golden
> > -- 
> > 2.20.1
> > 
> 

