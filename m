Return-Path: <SRS0=EYS7=3E=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B257C33CB1
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jan 2020 04:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF7E2467A
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jan 2020 04:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMB/FBLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgAOEVm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jan 2020 23:21:42 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39017 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgAOEVm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Jan 2020 23:21:42 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so6284006plp.6
        for <fstests@vger.kernel.org>; Tue, 14 Jan 2020 20:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=78p/Xe587xAfBF/xtKGtQmFh71S16W5nN1ZOoFc6p5I=;
        b=tMB/FBLwVx4gHasq6Ij6KhqSPYGTU3dqn2PmERROdaID51XJ74E6vDE/+FR/pdK427
         vYoeBjFEH8K46YHQYBLzwyBULgkUIwK6YXCg74Rh0Lfq41XSJOr2xZgJM01NoH0BHs03
         GDzkGjCw/xAS6gETApDwahodIAh46EH7brW7uVSm5MdtsebLyE5WlwgWZbRvyerzEiTg
         4tWK7XOFB3PanLvyoqZN+VgzEXHuLJRGWmifWYyDg5CAWbMbSwHDfV1hlSaG9bCsNzhu
         GFFqjwu+yMWyh/v8LWdFIGt6o8bmsSCbapt77pv5gg3+PcYPSHHTJNwlqW3TGOatn4kB
         BlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=78p/Xe587xAfBF/xtKGtQmFh71S16W5nN1ZOoFc6p5I=;
        b=O1W2qJ4ZLzAHB5Z0lm2C+qktKfOBNK4GCxZ4SsKVSsYk9h59QVzOww0z6ISUZGNYlW
         8GwnN8d2UdRQpmPBZ8Xl6WtecEx/g/wnzS+RpPQs6IYWtMBx04OYFygq1u0qmcHpjqO0
         GCFzkM9JupTF0Me0LfxeJ/99lK0N8De8SfY2Lu9Fi0hifOHsAeqfClDKIOdyghddMHR2
         5LRZZCojgPq7te/1f8JjX+Mm70X8LK+/Tz40TwSX5E6jd1svkOeIzK9LKZ+hX463dRGz
         TyC2dHRG9AoIvEoTFOutVRQlo9eKCNaHl4iGB0Hf3B2NyrLFhFiyG7qstKexrSniLLkH
         NxiQ==
X-Gm-Message-State: APjAAAW8JB7vt31pHEAihcpjYnptDrXTkr9Uz9Lj3DzxnryA6JPlxAKg
        SasOfQ2Hi+avw+NgipB4YmS5njRG
X-Google-Smtp-Source: APXvYqxDXS906RILi6VmlSzpeOBJTtrAE2X3dujXfuD4LvYQCEEQfihb+x4/A5pKDlW682bwMAqhzg==
X-Received: by 2002:a17:902:b701:: with SMTP id d1mr24001715pls.280.1579062101395;
        Tue, 14 Jan 2020 20:21:41 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b12sm19451552pfi.157.2020.01.14.20.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 20:21:40 -0800 (PST)
Date:   Wed, 15 Jan 2020 12:21:32 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/175, generic/176: cleanup testdir before exit
Message-ID: <20200115042132.xl6ijsavac23x7dx@xzhoux.usersys.redhat.com>
References: <20200113032409.11501-1-jencce.kernel@gmail.com>
 <20200113224203.GA8241@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113224203.GA8241@magnolia>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jan 13, 2020 at 02:42:03PM -0800, Darrick J. Wong wrote:
> On Mon, Jan 13, 2020 at 11:24:09AM +0800, Murphy Zhou wrote:
> > Usually the _mkfs helper will cleanup these directories at the
> > beginning of testcase. However, when testing on NFS, the cleanup
> > could be very slow and it is confusing that: We have already
> > started to run generic/176 but we get stuck in _mkfs, cleaning
> > up files left by the previous testcase generic/175.
> 
> Isn't this a general problem with the way nfs handles "mkfs" on scratch
> devices?  So you'd want to fix this once by doing the cleanup between
> tests instead of playing whackamole with whatever crazy file tests we
> think of next?

Hmm, it's hard to tell. Deleting these files at anywhere makes sense.
This patch is hardly a "fix", just trying to make it more clear.

> 
> > To be clear, cleanup testdir before exit.
> > 
> > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > ---
> >  tests/generic/175 | 1 +
> >  tests/generic/176 | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/tests/generic/175 b/tests/generic/175
> > index 79e5b3d6..bd966a28 100755
> > --- a/tests/generic/175
> > +++ b/tests/generic/175
> > @@ -61,6 +61,7 @@ bytes=$((blks * blksz))
> >  echo "reflinking $blks blocks, $bytes bytes" >> "$seqres.full"
> >  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
> >  
> > +rm -rf $testdir
> 
> Or put another way, this probably ought to be in _try_wipe_scratch_devs()

That's for devices I believe..

Thanks,
Murphy

> 
> --D
> 
> >  # success, all done
> >  status=0
> >  exit
> > diff --git a/tests/generic/176 b/tests/generic/176
> > index a084578a..bc83762e 100755
> > --- a/tests/generic/176
> > +++ b/tests/generic/176
> > @@ -73,6 +73,7 @@ bytes=$((blocks_needed * blksz))
> >  echo "reflinking $((blocks_needed / 2)) blocks, $((bytes / 2)) bytes" >> "$seqres.full"
> >  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
> >  
> > +rm -rf $testdir
> >  # success, all done
> >  status=0
> >  exit
> > -- 
> > 2.20.1
> > 
