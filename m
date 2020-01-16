Return-Path: <SRS0=clGf=3F=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4126EC33CB3
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jan 2020 07:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142662075B
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Jan 2020 07:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fC5DW9H1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgAPHpT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Jan 2020 02:45:19 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36227 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbgAPHpS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Jan 2020 02:45:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so7999407plm.3
        for <fstests@vger.kernel.org>; Wed, 15 Jan 2020 23:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EEe/GkaZ2LgKg5zgCN5U285mZs10pnF/q75Olv8HuzQ=;
        b=fC5DW9H1mxNKKWsqFjmEzoj6p/bMT0ObNG4tsUc+npYxqWhXX4DywNzMK0DIY4HT69
         Jq/WbRE8XqBbS0t6oALZuMVlogeHUxKjb9ZzkaAOl58MuQ8VtHfmwcwi2PkCe9Ovmy7V
         hPxnGJ7Kd/pfZN5igUXnRE9tfLzu9DhWn8FXvhfNlFcS302a4H1pSdUtjEcmrrN02jmR
         TiswgHbm1IEont9FCMDl11cpmlURA8ojIMM3F1EcrwCzGUOgKCUW9/65qho5PojfSkKa
         HZS3h1tLpLBrHzbAnIK3GdGopCxxBRRxDH/mOUbX1ws7vTGc94Ad5ZTCPjxzqrnbLs/Q
         /kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EEe/GkaZ2LgKg5zgCN5U285mZs10pnF/q75Olv8HuzQ=;
        b=I6cV6SsGPOTphmMruENWSzXE77A/tag1eavuwpruBojG+EjRmabevBKcJxa/58kiX1
         Q8bySWyqH+P/PzEBN+agPSlRDdSZYl2iTPCC23q74YvA4rLkDjri6bsXKlGoc+T0JQ7l
         QfNIwjBY4K4LaNC7Iydt5Qq5lw+RD1GR4L17cCiuoLBltivmq/xL0pKF1snJPTLy5JGC
         maHooPBG4bOkJ54ZGxMymBYqXbSuz8YhBSF+0/livz5bF8Md6/9MSgyGsvxKJWCiZJOF
         6XSsvH536xe0VIOnC5kR7LdcyjVldsYht/Cr/SETlRaN3/s9IYch+yobGMStmDDux1WX
         UkVQ==
X-Gm-Message-State: APjAAAXijXK1rTyRi9XIYO/DFA+IG7DDz98BI83YVxXlk0MBDmxrh4wB
        gkVobxLqk52lU3hU2QfPgSU=
X-Google-Smtp-Source: APXvYqy5pBfyf1uyn7B/mAJTX60RGitASUHYB66RiSrTBXJxg++L0jxmSHtJUC5t93OFW0j8K5T1xA==
X-Received: by 2002:a17:90b:46c4:: with SMTP id jx4mr5242561pjb.32.1579160717678;
        Wed, 15 Jan 2020 23:45:17 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 3sm2275659pjg.27.2020.01.15.23.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 23:45:16 -0800 (PST)
Date:   Thu, 16 Jan 2020 15:45:09 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/175, generic/176: cleanup testdir before exit
Message-ID: <20200116074509.gnfkvvpy2jhahv3n@xzhoux.usersys.redhat.com>
References: <20200113032409.11501-1-jencce.kernel@gmail.com>
 <20200113224203.GA8241@magnolia>
 <20200115042132.xl6ijsavac23x7dx@xzhoux.usersys.redhat.com>
 <20200115171923.GG8257@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115171923.GG8257@magnolia>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 15, 2020 at 09:19:23AM -0800, Darrick J. Wong wrote:
> On Wed, Jan 15, 2020 at 12:21:32PM +0800, Murphy Zhou wrote:
> > On Mon, Jan 13, 2020 at 02:42:03PM -0800, Darrick J. Wong wrote:
> > > On Mon, Jan 13, 2020 at 11:24:09AM +0800, Murphy Zhou wrote:
> > > > Usually the _mkfs helper will cleanup these directories at the
> > > > beginning of testcase. However, when testing on NFS, the cleanup
> > > > could be very slow and it is confusing that: We have already
> > > > started to run generic/176 but we get stuck in _mkfs, cleaning
> > > > up files left by the previous testcase generic/175.
> > > 
> > > Isn't this a general problem with the way nfs handles "mkfs" on scratch
> > > devices?  So you'd want to fix this once by doing the cleanup between
> > > tests instead of playing whackamole with whatever crazy file tests we
> > > think of next?
> > 
> > Hmm, it's hard to tell. Deleting these files at anywhere makes sense.
> > This patch is hardly a "fix", just trying to make it more clear.
> > 
> > > 
> > > > To be clear, cleanup testdir before exit.
> > > > 
> > > > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > > > ---
> > > >  tests/generic/175 | 1 +
> > > >  tests/generic/176 | 1 +
> > > >  2 files changed, 2 insertions(+)
> > > > 
> > > > diff --git a/tests/generic/175 b/tests/generic/175
> > > > index 79e5b3d6..bd966a28 100755
> > > > --- a/tests/generic/175
> > > > +++ b/tests/generic/175
> > > > @@ -61,6 +61,7 @@ bytes=$((blks * blksz))
> > > >  echo "reflinking $blks blocks, $bytes bytes" >> "$seqres.full"
> > > >  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
> > > >  
> > > > +rm -rf $testdir
> > > 
> > > Or put another way, this probably ought to be in _try_wipe_scratch_devs()
> > 
> > That's for devices I believe..
> 
> It exists to zap the scratch devices into enough of a clean state that
> whatever contents a test wrote to the scratch devices cannot easily
> (e.g. mount) leak into the next test.  IOWs, exactly where you'd want
> FSTYP=NFS to delete whatever junk is in the scratch mount.
> 
> Plus then you get a clean nfs scratch mount at the start of each test
> without needing to whackamole each test.
> 
> > Thanks,
> > Murphy
> > 
> > > 
> > > --D
> > > 
> > > >  # success, all done
> > > >  status=0
> > > >  exit
> > > > diff --git a/tests/generic/176 b/tests/generic/176
> > > > index a084578a..bc83762e 100755
> > > > --- a/tests/generic/176
> > > > +++ b/tests/generic/176
> > > > @@ -73,6 +73,7 @@ bytes=$((blocks_needed * blksz))
> > > >  echo "reflinking $((blocks_needed / 2)) blocks, $((bytes / 2)) bytes" >> "$seqres.full"
> > > >  _reflink_range "$testdir/file1" 0 "$testdir/file2" 0 $bytes >> "$seqres.full"
> > > >  
> > > > +rm -rf $testdir
> 
> Also this will massively slow down generic/17[56] on btrfs/XFS
> considering that we don't care about deleting the massively reflinked
> file we created.

Deleting them would be a good testcase to me. After all the tests,
deleting them should not cause any problem, or spending to much
time. Leaving them behind and letting them get formatted by mkfs,
definitely will be faster, but may make potential problems not
discovered.


If you think the deleting will be extremely slow, maybe it's time
to optimize how xfs deleting reflinked files.

Thanks,
Murphy

> 
> --D
> 
> > > >  # success, all done
> > > >  status=0
> > > >  exit
> > > > -- 
> > > > 2.20.1
> > > > 
