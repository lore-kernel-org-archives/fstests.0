Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CFBC433ED
	for <linux-fstests@archiver.kernel.org>; Mon, 17 May 2021 13:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2518D611BF
	for <linux-fstests@archiver.kernel.org>; Mon, 17 May 2021 13:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbhEQNmo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 May 2021 09:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237441AbhEQNmo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 May 2021 09:42:44 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E77FC06175F
        for <fstests@vger.kernel.org>; Mon, 17 May 2021 06:41:26 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so5604094oto.0
        for <fstests@vger.kernel.org>; Mon, 17 May 2021 06:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xh1KuV3n10CBmy9nHbZ97oNShjxyxIIHs5c7vSNVy1o=;
        b=qc1hL6QsOY2gqg0InvPK1iLq8pe82NIuetqO0fy2NlMt+FpZX0vFrGvMEUG6yOSLya
         kFjrgggtA96Gdi4cXvXcG1huwAb+pFophV043tX+9+8IzPohQGI0H4mB/zOBnkXxeN6u
         diU0go2yf1YRihctzd4V7k7eruhTMK462sZyuqWs0pMdduaQTrLkhy23bvfhK/gguwDL
         jDAfWrH6f5oZ97AAr9Z4iT4uAuMDyVkouWrAaLwXFLO8u0wHZm21OyndEQDcFSlPg0Sw
         1z+4653bHsbMrvNQJMGFLTQ/3qplOONRDODVwEBLRe8SvpgJRe0ps/4g+c70SrMEpkRU
         q5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xh1KuV3n10CBmy9nHbZ97oNShjxyxIIHs5c7vSNVy1o=;
        b=aPTVQVtbnEfldHG5BvCWggkYr8H5KmdytxHe28gkYBUZur9hn6rSE1Ut9AfFgUhP5G
         n1pK+ebNUoE2mBvGqVsIzPs9shLsyQ+YQ5D0BdaxzsncXhmGPADLDqTWcA9W0i2BVWP/
         5t24jBHsp8x7Q98aYKXcxzcxMRTKUZDkgv+EPcIp/5UhaRC91j4yeyOVJVFVMMBtwsSI
         qWC7AT2BORRTM52LiCxIgTFeAaAGMG/snQE5ifjH04h/ZpJI/zAx29qHeuSxzk6bz2VA
         iVKDJLEMQx6efwe8hjE9NC5gplIfcZvN7dcG25vPEuph834euPgHOQ3bG2joQDoyxr/b
         Bf+A==
X-Gm-Message-State: AOAM5338D2K+dwRLSid75Ky/beqpXrRFgmG3hydfQWztzHBHjL4jGNA/
        ho93S9w3DSWdr0ylRnH4IZZiZ1V1NsdLNQ==
X-Google-Smtp-Source: ABdhPJx66b8LO6cdEwdxAewg0xntgPWw/uYH03ZZ2Vhic4xKpHrZNKS2pG+ZPvOp1uCIFW9YLIKHEA==
X-Received: by 2002:a9d:7e99:: with SMTP id m25mr8799941otp.37.1621258885694;
        Mon, 17 May 2021 06:41:25 -0700 (PDT)
Received: from google.com ([2601:4c3:201:ed00:978b:e9f7:db71:1d54])
        by smtp.gmail.com with ESMTPSA id i9sm3032769oog.17.2021.05.17.06.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 06:41:25 -0700 (PDT)
Date:   Mon, 17 May 2021 09:41:23 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/309: add test for ext4_dir_entry2 wipe
Message-ID: <YKJyg/CM1pkZVNUK@google.com>
References: <20210504193425.1642352-1-leah.rumancik@gmail.com>
 <YKFEHJUklppQuS7u@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKFEHJUklppQuS7u@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 17, 2021 at 12:11:08AM +0800, Eryu Guan wrote:
> On Tue, May 04, 2021 at 07:34:25PM +0000, Leah Rumancik wrote:
> > From: Leah Rumancik <lrumancik@google.com>
> > 
> > Check wiping of dir entry data upon removing a file, converting to an
> > htree, and splitting htree nodes.
> > 
> > Tests commit 6c0912739699d8e4b6a87086401bf3ad3c59502d ("ext4: wipe
> > ext4_dir_entry2 upon file deletion").
> > 
> > Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> > ---
> >  tests/ext4/309     | 193 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/ext4/309.out |   5 ++
> >  tests/ext4/group   |   1 +
> >  3 files changed, 199 insertions(+)
> >  create mode 100755 tests/ext4/309
> >  create mode 100644 tests/ext4/309.out
> > 
> > diff --git a/tests/ext4/309 b/tests/ext4/309
> > new file mode 100755
> > index 00000000..c46db688
> > --- /dev/null
> > +++ b/tests/ext4/309
> > @@ -0,0 +1,193 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2021 Google, Inc. All Rights Reserved.
> > +#
> > +# FS QA Test No. 309
> > +#
> > +# Test wiping of ext4_dir_entry2 data upon file removal, conversion
> > +# to htree, and splitting of htree nodes
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +status=1       # failure is the default!
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +_supported_fs ext4
> > +
> > +_require_scratch
> > +_require_dumpe2fs "$DUMPE2FS_PROG" dumpe2fs
> > +_require_command "$DEBUGFS_PROG" debugfs
> > +
> > +
> > +SCRATCH_DIR="${SCRATCH_MNT}/scratch_dir"
> 
> SCRATCH_DIR could be easily confused with SCRATCH_MNT. 'testdir' with
> lower case variable name should be fine.
> 
> > +
> > +# get block number filename's dir ent
> > +# argument 1: filename
> > +get_block() {
> > +  echo $($DEBUGFS_PROG $SCRATCH_DEV -R "dirsearch /scratch_dir $1" 2>> $seqres.full | grep -o -m 1 "phys [0-9]\+" | cut -c 6-)
> 
> Please use tab for indention.
> 
> Thanks,
> Eryu
> 
> > +_scratch_mkfs_sized $((128 * 1024 * 1024)) >> $seqres.full 2>&1
> > +blocksize=$($DUMPE2FS_PROG -h $SCRATCH_DEV 2>> $seqres.full | grep "Block size:" | cut -d ":" -f2 | tr -d " \t\n\r")
> 
> How about doing "_get_block_size $SCRATCH_MNT" after _scratch_mount ?
>

Sure, this all sounds good. I'll send out an updated version.

Thanks,
Leah
