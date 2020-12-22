Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE0C43333
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Dec 2020 07:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E92023122
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Dec 2020 07:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgLVHGz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Dec 2020 02:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgLVHGy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Dec 2020 02:06:54 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28292C0611BB
        for <fstests@vger.kernel.org>; Mon, 21 Dec 2020 23:05:38 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id y8so6942859plp.8
        for <fstests@vger.kernel.org>; Mon, 21 Dec 2020 23:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1WBc7dOxFv0x4ynOeC5CLVapd4hnynfwS0JfydQzmVM=;
        b=qWRARBHcNDVajIcYUvPn3FDd44lUGc5YHF6A/GCd8lHCNp/oo9vpCzRnIpKg90FwTV
         oF6gyPNt6Qh3MAirRSMWe2LMvATQkwibCQpqIPCPB7sMJueUCUVXQsmFVZQ8g7z7esh+
         FFMPoiGKx72muqclhQeYvGAtgYZYOCPHndZu3lS6g3AnI8yzp+0afcdT8eXPOTI1+MXr
         5IExdwlbBwJ2zH28K7pREPvPDNPmsnVCGKvtUyv6qKvh9ECMzSkdWPxRXYUhWPERdhyg
         aERmQMlZpKBfAysmFTGJrnqAEhwiHzAr4BidzYZ1uWfR2pakACsDX0vwgSnh1K95ezcf
         TQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1WBc7dOxFv0x4ynOeC5CLVapd4hnynfwS0JfydQzmVM=;
        b=bri9E3wJug1gIBOJOVI5B/N7lqwRYVSzMi8OmZI8E56ZRhqMbNzu6xI3ZuTSy8EQAD
         OT/MXx+YSysY/yc1tXfsU3NuEq7vu8H6HXyNWOh2USCm76xN0gZ0/2aG8PynTM5ILIGg
         bLk7X9ZJg6zEAR/lrJUDhZjy3lPF8QXzF5BGq3DohEM1tY/YPy3sHa5NIoP3MSvEVi7h
         nYH0kg9U2tyTCx9Nb3R+aEoAVgwEG0RS9jeqIeb0HUcJNIwtxdcpgsuVAYbGLiLES/hF
         R6Ru0eOuafu8wl9F1cu9Qj+HV5L1nqoUw0oG3/8Q3biG1qwy7by6N6oit/4LmNFE76CJ
         JYhQ==
X-Gm-Message-State: AOAM5311X92uLSIPLRsqAWRLPzZTOUIwlg6s4kPo4eyXZ87Ulc3Dift+
        /es3fzSpHntO2beFrJlR4GLj9H7yr1c=
X-Google-Smtp-Source: ABdhPJw6iBdLd3KiyiE7++aQxYp1E1vSpiX6X1GmUDZs+JxBVyzVbZa4gP4seLedHnpTqqKHWPYYuw==
X-Received: by 2002:a17:90a:e551:: with SMTP id ei17mr20366046pjb.187.1608620737737;
        Mon, 21 Dec 2020 23:05:37 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x6sm19227005pfq.57.2020.12.21.23.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 23:05:36 -0800 (PST)
Date:   Tue, 22 Dec 2020 15:05:29 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] common/filter: add _filter_stat
Message-ID: <20201222070529.rqvun74aoocharcg@xzhoux.usersys.redhat.com>
References: <20201208020442.16307-1-jencce.kernel@gmail.com>
 <20201220144041.GZ3853@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201220144041.GZ3853@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Dec 20, 2020 at 10:40:41PM +0800, Eryu Guan wrote:
> On Tue, Dec 08, 2020 at 10:04:42AM +0800, Murphy Zhou wrote:
> > New stat(2) starts to use statx(7) call. Then if file does not
> > exist, it breaks golden output like this:
> > 
> > -stat: cannot stat 'SCRATCH_MNT/xxx': No such file or directory
> > +stat: cannot statx 'SCRATCH_MNT/xxx': No such file or directory
> > 
> > Add this filter to fix it, and add this filter to testcases that
> > need it.
> > 
> > Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> > ---
> >  common/filter     | 6 ++++++
> >  tests/generic/397 | 6 +++---
> >  tests/generic/435 | 2 +-
> >  tests/generic/440 | 2 +-
> >  tests/xfs/348     | 2 +-
> >  5 files changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/common/filter b/common/filter
> > index a8b3882f..6fbf70c2 100644
> > --- a/common/filter
> > +++ b/common/filter
> > @@ -510,6 +510,12 @@ _filter_mv()
> >  	sed -e "s/^renamed //"
> >  }
> >  
> > +# New stat(2) uses statx(7)
> > +_filter_stat()
> > +{
> > +	sed -e "s/cannot statx/cannot stat/"
> > +}
> > +
> 
> Thanks for the fix! But I think maybe it's better to filter 'stat' to
> 'statx' (and update the affected .out files accordingly), so that when
> all distros pick up the new behavior we may eventually remove this
> filter, or at least we won't see failures if new tests forget to use
> _filter_stat, as no-one is testing with old distros.

Agree and Okay, this makes sense.

Thanks very much for the reviewing!

> 
> Thanks,
> Eryu
> 
> >  _filter_lostfound()
> >  {
> >  	sed -e '/^lost+found$/d'
> > diff --git a/tests/generic/397 b/tests/generic/397
> > index 97111555..bb4de31c 100755
> > --- a/tests/generic/397
> > +++ b/tests/generic/397
> > @@ -83,8 +83,8 @@ _unlink_session_encryption_key $keydesc
> >  _scratch_cycle_mount
> >  
> >  # Check that unencrypted names aren't there
> > -stat $SCRATCH_MNT/edir/empty |& _filter_scratch
> > -stat $SCRATCH_MNT/edir/symlink |& _filter_scratch
> > +stat $SCRATCH_MNT/edir/empty |& _filter_stat |& _filter_scratch
> > +stat $SCRATCH_MNT/edir/symlink |& _filter_stat |& _filter_scratch
> >  
> >  # Check that the correct numbers of files and subdirectories are there
> >  ls $SCRATCH_MNT/edir | wc -l
> > @@ -106,7 +106,7 @@ ln -s foo $SCRATCH_MNT/edir/0123456789abcdef |& _filter_scratch
> >  
> >  # Delete the encrypted directory (should succeed)
> >  rm -r $SCRATCH_MNT/edir
> > -stat $SCRATCH_MNT/edir |& _filter_scratch
> > +stat $SCRATCH_MNT/edir |& _filter_stat |& _filter_scratch
> >  
> >  # success, all done
> >  status=0
> > diff --git a/tests/generic/435 b/tests/generic/435
> > index 9f54c6c4..71c5a3f0 100755
> > --- a/tests/generic/435
> > +++ b/tests/generic/435
> > @@ -73,7 +73,7 @@ _scratch_cycle_mount
> >  # and ext4 reported a "Structure needs cleaning" error when removing files.
> >  find $SCRATCH_MNT/edir/ -type f | xargs stat -c %i | sort | uniq | wc -l
> >  rm -rf $SCRATCH_MNT/edir |& head -n 10
> > -stat $SCRATCH_MNT/edir |& _filter_scratch
> > +stat $SCRATCH_MNT/edir |& _filter_stat |& _filter_scratch
> >  
> >  # success, all done
> >  status=0
> > diff --git a/tests/generic/440 b/tests/generic/440
> > index d775f1e0..8a81d60a 100755
> > --- a/tests/generic/440
> > +++ b/tests/generic/440
> > @@ -87,7 +87,7 @@ _scratch_cycle_mount
> >  cat $SCRATCH_MNT/edir2/link
> >  exec 3< $SCRATCH_MNT/edir2/link # pin inode with cached key in memory
> >  _unlink_session_encryption_key $keydesc
> > -stat $SCRATCH_MNT/edir/file |& _filter_scratch
> > +stat $SCRATCH_MNT/edir/file |& _filter_stat |& _filter_scratch
> >  cat "$(find $SCRATCH_MNT/edir/ -type f)"
> >  exec 3>&-
> >  
> > diff --git a/tests/xfs/348 b/tests/xfs/348
> > index 194d9f99..208382fb 100755
> > --- a/tests/xfs/348
> > +++ b/tests/xfs/348
> > @@ -112,7 +112,7 @@ for dt in $dtypes; do
> >  		rm -f $tmp.stat.err
> >  		ftype=$(stat --printf=%F $testdir/$file 2>$tmp.stat.err)
> >  		if [ -s $tmp.stat.err ]; then
> > -			cat $tmp.stat.err
> > +			cat $tmp.stat.err | _filter_stat
> >  		else
> >  			echo "stat: '$testdir/$file' is a $ftype"
> >  			# Verify that readlink of a file posing as a symlink
> > -- 
> > 2.20.1

-- 
Murphy
