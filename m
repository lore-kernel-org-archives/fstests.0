Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE873C4338F
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Aug 2021 15:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA1160C3F
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Aug 2021 15:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhHHPnn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 Aug 2021 11:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229923AbhHHPnm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Aug 2021 11:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628437403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+IEORuFiDBopKBKehyh4RSNqtiJHu2O3iNWr/yRaZ3I=;
        b=gZfpRFdIDIXeouigBwwnrNnCInsl1pFW66A8ErtNG71YPCXt9KN9rAfnNylV09RuE8wKkK
        LDdlwBrIRR4ZCypQj0MXPwhHcenEVHpYrztQbj319RC5wnifEY+1N0v9Ucd8/z+JG+kOth
        p5HZVLV+ptN1VPVyhSpxqL+vTeLTB2c=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-TWCLkNKbOOK-1-L7umWj4g-1; Sun, 08 Aug 2021 11:43:20 -0400
X-MC-Unique: TWCLkNKbOOK-1-L7umWj4g-1
Received: by mail-pj1-f72.google.com with SMTP id s2-20020a17090a0742b0290177b02e795eso8022314pje.7
        for <fstests@vger.kernel.org>; Sun, 08 Aug 2021 08:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=+IEORuFiDBopKBKehyh4RSNqtiJHu2O3iNWr/yRaZ3I=;
        b=NyxxHQVo2NA2bHaKyURu60NfQvy94kN5gWVJXj9dA3DnTeT2UCnqVO1slsh+Qt2w7L
         TJIMMpTHzNHazfMHh2HFedOaxsWWFt21lJ4WmD939Uvqp3mCY/xSAH1oDmoPT+3ADwSd
         H7Qqytrtz+ukPzDOPlaMK7x2GZzZsouxRd8gCuX1ck8K3tVu3wthpgQWuzRunPxIJNjz
         bvYt/2YxSCVdIC2djlLi5FLsAWXTJjOCTop0ypPReiCS3HGoVtJuovINec9AfIBkNyGI
         VTKFM2VJxp4M9ksYEeIBoFn4kB0o6eo+Zd7iEU4/mOHyYwtNtUm9ZjAcf1nvB4W33uAB
         GXZA==
X-Gm-Message-State: AOAM532lDcXrvXgguNSeFaIiSGpozLa42R5xuaZqtpU9eG8yINanVxd/
        eix2kHAMuVY7T2ZbbLd56I26tN0G96KjB738wA0lNgplldSzdbqt25iZ1kXsY/T5qFeWq4QygNv
        JhfT8ExqmNjmyrdb0CA==
X-Received: by 2002:a63:1e5c:: with SMTP id p28mr63634pgm.3.1628437398949;
        Sun, 08 Aug 2021 08:43:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJJaOgxwDoBwxePcSDMpJtXf51xc2wMC4rCiigcHyxwBdh+ETh9wHqlpRcJDNSgxmjH/g0Uw==
X-Received: by 2002:a63:1e5c:: with SMTP id p28mr63613pgm.3.1628437398689;
        Sun, 08 Aug 2021 08:43:18 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s133sm17876585pfs.190.2021.08.08.08.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Aug 2021 08:43:18 -0700 (PDT)
Date:   Sun, 8 Aug 2021 23:44:01 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs: quota state command should report upg grace times
 separately
Message-ID: <20210808154401.ayh6skncanqf3rb4@fedora>
Mail-Followup-To: Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
References: <20210806051012.1640342-1-zlang@redhat.com>
 <YQ/ryebsyGy7vurG@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQ/ryebsyGy7vurG@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Aug 08, 2021 at 10:35:53PM +0800, Eryu Guan wrote:
> On Fri, Aug 06, 2021 at 01:10:12PM +0800, Zorro Lang wrote:
> > Regression test for d8a94546 ("xfs_quota: state command should report
> > ugp grace times"). When give "-ugp" or "-a" options to xfs_quota
> > state command, it should report grace times for all three types
> > separately.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> >  tests/xfs/175     | 33 +++++++++++++++++++++++++++++++++
> >  tests/xfs/175.out | 21 +++++++++++++++++++++
> >  2 files changed, 54 insertions(+)
> >  create mode 100755 tests/xfs/175
> >  create mode 100644 tests/xfs/175.out
> > 
> > diff --git a/tests/xfs/175 b/tests/xfs/175
> > new file mode 100755
> > index 00000000..0b7d81ec
> > --- /dev/null
> > +++ b/tests/xfs/175
> > @@ -0,0 +1,33 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 175
> > +#
> > +# Regression test for d8a94546 ("xfs_quota: state command should report
> > +# ugp grace times"). When give "-ugp" or "-a" options to xfs_quota state
> > +# command, it should report grace times for all three types separately.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick quota
> 
> Should source ./common/quota here
> 
> > +
> > +# real QA test starts here
> > +_supported_fs xfs
> > +_require_scratch
> > +_require_quota
> > +
> > +# Format filesystem and set up quota limits
> > +_scratch_mkfs > $seqres.full
> > +_qmount_option "grpquota"
> > +_scratch_mount >> $seqres.full
> 
> s/_scratch_mount/_qmount/
> 
> > +
> > +$XFS_QUOTA_PROG -x -c 'timer -u 5d' $SCRATCH_MNT
> 
> Should set group quota timer, as we only enable grpquota above,
> otherwise we hit "xfs_quota: cannot set timer: No such process" failre
> here.
> 
> I fixed all on commit.

Sorry, I forgot to commit below changes[1] in my local git repo, before sending
this patch ... It's still staged ... Sorry about that, if you haven't merged
this patch, I can send a V2.

Thanks,
Zorro

[1]
[zorro@zlang-laptop xfstests-dev]$ git diff
diff --git a/tests/xfs/175 b/tests/xfs/175
index 0b7d81ec..2cd38842 100755
--- a/tests/xfs/175
+++ b/tests/xfs/175
@@ -11,6 +11,8 @@
 . ./common/preamble
 _begin_fstest auto quick quota
 
+. ./common/quota
+
 # real QA test starts here
 _supported_fs xfs
 _require_scratch
@@ -21,7 +23,7 @@ _scratch_mkfs > $seqres.full
 _qmount_option "grpquota"
 _scratch_mount >> $seqres.full
 
-$XFS_QUOTA_PROG -x -c 'timer -u 5d' $SCRATCH_MNT
+$XFS_QUOTA_PROG -x -c 'timer -g 5d' $SCRATCH_MNT


> 
> Thanks,
> Eryu
> 
> > +# xfs_quota state -ugp or -a should report times for all three types separately.
> > +echo "* state -ugp:"
> > +$XFS_QUOTA_PROG -x -c 'state -ugp' $SCRATCH_MNT | grep 'grace time'
> > +echo "* state -a:"
> > +$XFS_QUOTA_PROG -x -c 'state -a' $SCRATCH_MNT | grep 'grace time'
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/xfs/175.out b/tests/xfs/175.out
> > new file mode 100644
> > index 00000000..83247e21
> > --- /dev/null
> > +++ b/tests/xfs/175.out
> > @@ -0,0 +1,21 @@
> > +QA output created by 175
> > +* state -ugp:
> > +Blocks grace time: [--------]
> > +Inodes grace time: [--------]
> > +Realtime Blocks grace time: [--------]
> > +Blocks grace time: [5 days]
> > +Inodes grace time: [5 days]
> > +Realtime Blocks grace time: [5 days]
> > +Blocks grace time: [--------]
> > +Inodes grace time: [--------]
> > +Realtime Blocks grace time: [--------]
> > +* state -a:
> > +Blocks grace time: [--------]
> > +Inodes grace time: [--------]
> > +Realtime Blocks grace time: [--------]
> > +Blocks grace time: [5 days]
> > +Inodes grace time: [5 days]
> > +Realtime Blocks grace time: [5 days]
> > +Blocks grace time: [--------]
> > +Inodes grace time: [--------]
> > +Realtime Blocks grace time: [--------]
> > -- 
> > 2.31.1
> 

