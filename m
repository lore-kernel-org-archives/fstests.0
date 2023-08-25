Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1346DEE49B4
	for <linux-fstests@archiver.kernel.org>; Fri, 25 Aug 2023 14:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbjHYOVY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 25 Aug 2023 10:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343721AbjHYOU5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 Aug 2023 10:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BE39E
        for <fstests@vger.kernel.org>; Fri, 25 Aug 2023 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692973210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jW2pKWmiWuGVCpTSPaJ/2vNwmbskt87fODz1wXV/nco=;
        b=iGm+3B3VAab9MmZz86oZ63RIoWuNgOhlNzNqkv2DYKTFGC/lfldCNDi+IGEkfcoHaFa0SR
        RUzNU+iI2MZ5Z99JMPnZb/7ADfmhgJQCi+VWzqDR/PM7hCz7BbGzfOhCSmcvfVriHMNZ9U
        zG3e1/IndZqaWlPgOrDX2DnC0ELMh94=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-WF_TrGLzP5uvstS-I_PMfA-1; Fri, 25 Aug 2023 10:16:57 -0400
X-MC-Unique: WF_TrGLzP5uvstS-I_PMfA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26d50941f68so907246a91.1
        for <fstests@vger.kernel.org>; Fri, 25 Aug 2023 07:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692973016; x=1693577816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jW2pKWmiWuGVCpTSPaJ/2vNwmbskt87fODz1wXV/nco=;
        b=IkU0VY4nwt/Cz7flnSmSjhaDUj9IodmK6Cj8qgTdFijfNJB7vcE0TtEp6gJkXc+rIl
         qx9odcAJ+HlOZBknL515fynRb+FXNij4/S3Xxb3N3gHu+OHu1AJ/C55fsn4A/cjdTXdn
         YRHNP/b8Bqj8OPbjNY3z7iWyFC6Qnsu9XERXW9Zs7U6A5ofNayXeJpfgIJF/Gzmd6a1W
         yBemi6QkMkuj0l8HKzUEbuvclL6pMKbwVtvPB7Ef64qiiM7vdq/S5ZCe3n4Tf2e9Ew+A
         roLhGPR6FfZqGlRgJfidof7ijTdpVs0GaksWM3M/KpKIZJG5RO52iB9nJKbPKyfQWykM
         Ze0w==
X-Gm-Message-State: AOJu0YyjyjFAQNOpzqqri+jLAtsD4kFmC3XVqsTukZqr7Yg+XF9Bo5RW
        /vzu986leqociAFDra+lc3PukIIyzHl2I2POv1FINH2tVhKhIbuFS0OfHqLSDE4KALOyId21cAn
        Y6cl4pkix/F9L5RyrikehqqBeOdAf
X-Received: by 2002:a17:903:1cb:b0:1bc:2f17:c628 with SMTP id e11-20020a17090301cb00b001bc2f17c628mr23081280plh.56.1692973015961;
        Fri, 25 Aug 2023 07:16:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNyJuRaeG/wD40ZlriJCiVyGeHnbnm97mEEygHS5vOfubfDn6+ZG24ejI/qSeWLcZMOy99Mw==
X-Received: by 2002:a17:903:1cb:b0:1bc:2f17:c628 with SMTP id e11-20020a17090301cb00b001bc2f17c628mr23081258plh.56.1692973015671;
        Fri, 25 Aug 2023 07:16:55 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b001bd41b70b60sm1759088plf.45.2023.08.25.07.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 07:16:55 -0700 (PDT)
Date:   Fri, 25 Aug 2023 22:16:51 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH fstests v2 3/3] generic/578: only run on filesystems that
 support FIEMAP
Message-ID: <20230825141651.vd6lh3n4ztru5svl@zlang-mailbox>
References: <20230824-fixes-v2-0-d60c2faf1057@kernel.org>
 <20230824-fixes-v2-3-d60c2faf1057@kernel.org>
 <20230824170931.GC11251@frogsfrogsfrogs>
 <bc2586e3da8719b98126b22c15645a7951b9c1d9.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc2586e3da8719b98126b22c15645a7951b9c1d9.camel@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 24, 2023 at 01:28:26PM -0400, Jeff Layton wrote:
> On Thu, 2023-08-24 at 10:09 -0700, Darrick J. Wong wrote:
> > On Thu, Aug 24, 2023 at 12:44:19PM -0400, Jeff Layton wrote:
> > > Some filesystems (e.g. NFS) don't support FIEMAP. Limit generic/578 to
> > > filesystems that do.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  common/rc         | 13 +++++++++++++
> > >  tests/generic/578 |  1 +
> > >  2 files changed, 14 insertions(+)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 33e74d20c28b..98d27890f6f7 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -3885,6 +3885,19 @@ _require_metadata_journaling()
> > >  	fi
> > >  }
> > >  
> > > +_require_fiemap()
> > > +{
> > > +	local testfile=$TEST_DIR/fiemaptest.$$
> > > +
> > > +	touch $testfile
> > > +	$XFS_IO_PROG -r -c "fiemap" $testfile 1>$testfile.out 2>&1
> > > +	if grep -q 'Operation not supported' $testfile.out; then
> > > +	  _notrun "FIEMAP is not supported by this filesystem"
> > > +	fi
> > > +
> > > +	rm -f $testfile $testfile.out
> > > +}
> > 
> > _require_xfs_io_command "fiemap" ?
> > 
> > 
> 
> Ok, I figured we'd probably do this test after testing for that
> separately, but you're correct that we do require it here.
> 
> If we add that, should we also do this, at least in all of the general
> tests?
> 
>     s/_require_xfs_io_command "fiemap"/_require_fiemap/
> 
> I think we end up excluding some of those tests on NFS for other
> reasons, but other filesystems that don't support fiemap might still try
> to run these tests.

We have lots of cases contains _require_xfs_io_command "fiemap", so I think
we can keep this "tradition", don't bring a new _require_fiemap for now,
so ...

>  
> > > +
> > >  _count_extents()
> > >  {
> > >  	$XFS_IO_PROG -r -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -l
> > > diff --git a/tests/generic/578 b/tests/generic/578
> > > index b024f6ff90b4..903055b2ca58 100755
> > > --- a/tests/generic/578
> > > +++ b/tests/generic/578
> > > @@ -26,6 +26,7 @@ _require_test_program "mmap-write-concurrent"
> > >  _require_command "$FILEFRAG_PROG" filefrag
> > >  _require_test_reflink
> > >  _require_cp_reflink
> > > +_require_fiemap

_require_xfs_io_command "fiemap"

> > >  
> > >  compare() {
> > >  	for i in $(seq 1 8); do
> > > 
> > > -- 
> > > 2.41.0
> > > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

