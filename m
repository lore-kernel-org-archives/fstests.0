Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2D5C433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Apr 2022 08:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343881AbiDKIg7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Apr 2022 04:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343866AbiDKIg5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Apr 2022 04:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 333A239174
        for <fstests@vger.kernel.org>; Mon, 11 Apr 2022 01:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649666081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CRMcsThZ+mgxQqXaqa8DSpdKioml7O8lSKRcCINo2rI=;
        b=auwKVHvkxvocUbMZWS95bqevV9ov9EFlkWrcYxYxijKtm6+eS9MeAA2+TLEfTX4c9kiPk0
        zLXYVy9d4S4GVLq4Vl4as7jb88eQSk7Rb8EZkrZIGPD9LBR60kCiQo5WBA3cxj5UAkQ6HA
        2VK3KMJd/3G8MMR2loZ95gYX5Q2/JL4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-GK40eoRZN8yW176_lG6bmQ-1; Mon, 11 Apr 2022 04:34:40 -0400
X-MC-Unique: GK40eoRZN8yW176_lG6bmQ-1
Received: by mail-pl1-f199.google.com with SMTP id s18-20020a170902ea1200b001570031e832so4451280plg.6
        for <fstests@vger.kernel.org>; Mon, 11 Apr 2022 01:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=CRMcsThZ+mgxQqXaqa8DSpdKioml7O8lSKRcCINo2rI=;
        b=m+sylzGRIQJABncIieTCCn4/w8Z91NBDWvmRxDIQm0e0sI73m9aRn6dJmjcq9ezVgE
         iQ+Wl/jeFH9FYV69A/r5OYnPfyW7PH8wjVZrMfW5n8fUYK6k43O/G4bqAsVELnx+cJFr
         8ngqxOrXQA3YT1Ze1w9e7BtsdDGZKS7V56XZuotQ0Nqc2V33Gklfz53cWYttfAQQW1xM
         vUcH7hIQt6Y65/BlVJGzPNP/CvHZ3w3d0dkTqc3W+sjTA1HD+oi0/O/gpvxTmI+PCzLE
         hQopi88sRycauo6YDdNCaFN+1bytR/qramD8hwOKD1dKm7iLeAg7/5gUzzwLF0FpRt5h
         ny7A==
X-Gm-Message-State: AOAM533XoPAAIzZXZH4tZiZ/NZksM3btu+GUx64LT/nzrcs+HcYJMXbf
        5mduVGt/WGlSJd2aui5zn2UvEbrDiRuwGooW8D3eqWGyUgFZ3nFG8Mygd2E0Na4wrgcNqdBzbtK
        YHdEr6NP77VV5XYDmaw==
X-Received: by 2002:a17:902:cf02:b0:14d:54cf:9a6a with SMTP id i2-20020a170902cf0200b0014d54cf9a6amr30871088plg.137.1649666079002;
        Mon, 11 Apr 2022 01:34:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznER0ILn2169okJUMMrI9V7bvywz57OfI3mJgXUuPc84Jg9wj7VgB2585TaIY7QCSvCSsdeA==
X-Received: by 2002:a17:902:cf02:b0:14d:54cf:9a6a with SMTP id i2-20020a170902cf0200b0014d54cf9a6amr30871074plg.137.1649666078615;
        Mon, 11 Apr 2022 01:34:38 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e10-20020a6558ca000000b0039cc25511dbsm12188988pgu.0.2022.04.11.01.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 01:34:37 -0700 (PDT)
Date:   Mon, 11 Apr 2022 16:34:33 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH v2] xfs: test xfsdump when an inode < root inode is
 present
Message-ID: <20220411083433.omc3yvn75k5ap6zk@zlang-mailbox>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org
References: <20220408170847.1088522-1-zlang@redhat.com>
 <20220409040056.GA14099@magnolia>
 <20220410121103.wk2hgixq57dogzah@zlang-mailbox>
 <20220411053135.GH1609613@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411053135.GH1609613@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 11, 2022 at 03:31:35PM +1000, Dave Chinner wrote:
> On Sun, Apr 10, 2022 at 08:11:03PM +0800, Zorro Lang wrote:
> > On Fri, Apr 08, 2022 at 09:00:56PM -0700, Darrick J. Wong wrote:
> > > On Sat, Apr 09, 2022 at 01:08:47AM +0800, Zorro Lang wrote:
> > > > From: Eric Sandeen <sandeen@redhat.com>
> > > > 
> > > > This tests a longstanding bug where xfsdumps are not properly
> > > > created when an inode is present on the filesytsem which has
> > > > a lower number than the root inode.
> > > > 
> > > > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > > > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > > > ---
> > > > 
> > > > Friendly ping for reviewing.
> > > > 
> > > > Thanks,
> > > > Zorro
> > > > 
> > > >  common/dump       |  1 +
> > > >  tests/xfs/543     | 63 +++++++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/xfs/543.out | 47 +++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 111 insertions(+)
> > > >  create mode 100755 tests/xfs/543
> > > >  create mode 100644 tests/xfs/543.out
> > > > 
> > > > diff --git a/common/dump b/common/dump
> > > > index ea16d442..ab48cd13 100644
> > > > --- a/common/dump
> > > > +++ b/common/dump
> > > > @@ -219,6 +219,7 @@ _require_tape()
> > > >  
> > > >  _wipe_fs()
> > > >  {
> > > > +    [[ "$WIPE_FS" = "no" ]] && return
> > > 
> > > Is WIPE_FS intended as a general means to prevent wipefs -a between
> > > tests?  If so, it ought to be in the README.
> > 
> > Actually I don't know how to if I should say WIPE_FS means to prevent
> > wipefs -a between tests. Due to:
> > 
> > 1) We have a _wipe_fs() in common/dump[1], it's very old, and it only
> > try to make a new xfs, although it calls wipe "fs"... And it's only used
> > for tests/xfs/* cases to call _create_dumpdir_*() function.
> > 
> > 2) Then we have _try_wipe_scratch_devs() in common/rc [2], which calls
> > _try_wipe_scratch_xfs() in common/xfs [3] (which is newer), it's only
> > used in ./check script now.
> > 
> > So I'm wondering if we'd better to change the _wipe_fs() to:
> > _wipe_dump()
> > {
> > 	[[ "$WIPE_DUMP" = "no" ]] && return
> > 	_require_scratch
> > 
> > 	_try_wipe_scratch_devs >>$seqres.full
> > 	_scratch_mount >>$seqres.full
> > }
> > 
> > What do you think?
> 
> common/dump::_wipe_fs() is effectively just _scratch_mkfs() followed
> by mounting it. It does not need to exist at all.

Oh! I was really confused why dumpdir need to wipefs at first, so that's
the reason. I just checked all cases which call _create_dumpdir_*, and
yes, they just hope to omit below common steps by running _create_dumpdir_*:
_require_scratch
_scratch_mkfs
_scratch_mount

I'd like to remove the common/dump::_wipe_fs(), and help all related cases
call _require_scratch && _scratch_mkfs && _scratch_mount by themselves. Due
to it's match the current xfstests case format.

Is that good to you? Anymore suggestions or notice ?

Thanks,
Zorro

> 
> The test(s) need to have run _require_scratch() in it's setup, it
> shouldn't be hidden deep inside random functions that fill the
> scratch device.
> 
> They should also run scratch_mkfs/mount themselves to prep the
> scratch device, and then _wipe_fs() can go away entirely.
> 
> And the new test simply calls the function to populate the scratch
> device at the place where you want to preserve the previous contents
> of the scratch device without first running scratch_mkfs....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 

