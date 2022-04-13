Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75C8C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Apr 2022 18:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiDMSZq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Apr 2022 14:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbiDMSZp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Apr 2022 14:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F1425006C
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649874203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9lgnmBmciW2lq2Wz2KNbzk9pNp34wGGm9lnhfQal6pE=;
        b=c15gfoZvZiW9p1fxXS8bWX00f26T5dB6euthU2QlGOlVPBu/8YenB1cfoXeqc2ES2LDrL3
        rd3BtPTuBVQKPfjf17vfCuajoSsQprQ0vnh7ls2yC/LD1HLloHm6rPTRDwwmp0i998iOvl
        9z1gPJr/FBPCGxhhn8oj7oZnyWF2B/Q=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-37KnVdfiNuGVxJr5lNIlXA-1; Wed, 13 Apr 2022 14:23:22 -0400
X-MC-Unique: 37KnVdfiNuGVxJr5lNIlXA-1
Received: by mail-qk1-f198.google.com with SMTP id ay14-20020a05620a178e00b0069a9c319c64so1712986qkb.3
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 11:23:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9lgnmBmciW2lq2Wz2KNbzk9pNp34wGGm9lnhfQal6pE=;
        b=u7gqBy5vuxTInS46CHEHPH8RCVs/su5oqX0jimTLxW3cx7WAryHo9BF0mqfCcXIeYB
         6Ns7ohY8YDcGXUP3IA7Ns3VS2HmCf4YozpC1XBN27AzM41Mj5RRTIWxd9M6Su0T2WNYc
         STeLqIaD8evabTR/w5uwT8i30Ea3qBQEupwvvKx0ZsuG1Gom1fWxxGDICkcEOw/FPll7
         0PsoAPs7mVVpY/83GURmDbP9jf804/DtTvBawoEE9eyRy6vBvPoABUzjtVazrV1EcYL/
         FXjClwcf+eIVcuz7l4QEmM48Bx3xw8+y3GWXoSprG//4aLVP2lZ4DP+iHlhCmbTgopXp
         rADQ==
X-Gm-Message-State: AOAM5306O24Cp5elQpYNevJPptT2a7dDeiTQ6Dm4EmkSNGsOoXIt4h/d
        mLJOazZ9dhrkANRHA/o9NxaXiewyhKc3lXsf1v+EIvuHLJxDXUkaQI9OyCSO1hBNB+r7IE5P/EH
        IXoxWZGaZyKJFs6o84g==
X-Received: by 2002:a05:620a:29d0:b0:680:9c1a:557a with SMTP id s16-20020a05620a29d000b006809c1a557amr7682815qkp.646.1649874201016;
        Wed, 13 Apr 2022 11:23:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCn2khQiDonjfLl9vGxiN/oxjzSDzqNMc6Ce8aesfGx67ikSSSU6uEItwFb7n1+JqH1V1sBA==
X-Received: by 2002:a05:620a:29d0:b0:680:9c1a:557a with SMTP id s16-20020a05620a29d000b006809c1a557amr7682803qkp.646.1649874200721;
        Wed, 13 Apr 2022 11:23:20 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p28-20020a05620a15fc00b0069c28de43casm4942331qkm.102.2022.04.13.11.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 11:23:19 -0700 (PDT)
Date:   Thu, 14 Apr 2022 02:23:14 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] xfs/187: don't rely on FSCOUNTS for free space data
Message-ID: <20220413182314.bfk55f4axio5amc7@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org
References: <164971765670.169895.10730350919455923432.stgit@magnolia>
 <164971766238.169895.2389864738831855587.stgit@magnolia>
 <20220412084716.vwljkrc7bpnzl75z@zlang-mailbox>
 <20220412171156.GF16799@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412171156.GF16799@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 12, 2022 at 10:11:56AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 12, 2022 at 04:47:16PM +0800, Zorro Lang wrote:
> > On Mon, Apr 11, 2022 at 03:54:22PM -0700, Darrick J. Wong wrote:
> > > From: Darrick J. Wong <djwong@kernel.org>
> > > 
> > > Currently, this test relies on the XFS_IOC_FSCOUNTS ioctl to return
> > > accurate free space information.  It doesn't.  Convert it to use statfs,
> > > which uses the accurate versions of the percpu counters.  Obviously,
> > > this only becomes a problem when we convert the free rtx count to use
> > > (sloppier) percpu counters instead of the (more precise and previously
> > > buggy) ondisk superblock counts.
> > > 
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  tests/xfs/187 |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > 
> > > diff --git a/tests/xfs/187 b/tests/xfs/187
> > > index 1929e566..a9dfb30a 100755
> > > --- a/tests/xfs/187
> > > +++ b/tests/xfs/187
> > > @@ -135,7 +135,7 @@ punch_off=$((bigfile_sz - frag_sz))
> > >  $here/src/punch-alternating $SCRATCH_MNT/bigfile -o $((punch_off / fsbsize)) -i $((rtextsize_blks * 2)) -s $rtextsize_blks
> > >  
> > >  # Make sure we have some free rtextents.
> > > -free_rtx=$($XFS_IO_PROG -c 'statfs' $SCRATCH_MNT | grep counts.freertx | awk '{print $3}')
> > > +free_rtx=$($XFS_IO_PROG -c 'statfs' $SCRATCH_MNT | grep statfs.f_bavail | awk '{print $3}')
> > 
> > Do you mean the "cnt->freertx = mp->m_sb.sb_frextents" in xfs_fs_counts() isn't
> > right?
> 
> Correct -- prior to the patches introduced here:
> https://lore.kernel.org/linux-xfs/164961485474.70555.18228016043917319266.stgit@magnolia/T/#t
> 
> The kernel would account actual ondisk rt extent usage *and* in-memory
> transaction reservations in mp->m_sb.sb_frextents, which meant that one
> thread calling xfs_log_sb racing with another thread allocating space on
> the rt volume would write the wrong sb_frextents value to disk, which
> corrupts the superblock counters.
> 
> The fix for that is to separate the two uses into separate counters --
> now mp->m_sb.sb_frextents tracks the ondisk usage, and mp->m_frextents
> also includes tx reservations.  m_frextents is a percpu counter, which
> means that we won't be able to rely on it for a precise accounting after
> the series is merged.  Hence the switch to statfs, which does use the
> slow-but-accurate percpu_counter_sum method.

Thanks for your detailed explanation, so it's about this patch:
[PATCH 3/3] xfs: use a separate frextents counter for rt extent reservations

It's good to me, it would be better if we can add more content (as above) into commit log.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> --D
> 
> > Thanks,
> > Zorro
> > 
> > >  if [ $free_rtx -eq 0 ]; then
> > >  	echo "Expected fragmented free rt space, found none."
> > >  fi
> > > 
> > 
> 

