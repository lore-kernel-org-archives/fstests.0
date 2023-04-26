Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA07C7618E
	for <linux-fstests@archiver.kernel.org>; Wed, 26 Apr 2023 15:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjDZPd3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbjDZPd3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 26 Apr 2023 11:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BA6E8
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682523165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/UXzIOS42zwAbisYrvu9PUoIu4EfHsRshilah4JVYU0=;
        b=YgbQU9YpOsteTDW2MTSLVsjT1auLn/2zyqy+ffWqa5+16LXxzhRA92ziAu7+htDSZqkb2m
        w26HWNAL6eQqguYhvdJoR1SkKdUhqUwv4ONp7kUepkT1NMbh6IRX6S8u3b97V2ov53TVNg
        /cwnuxmapJPrVI4pwhE9DaQV1zcc02A=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-McXKtKaLOW2r3MvpRAX-mw-1; Wed, 26 Apr 2023 11:32:43 -0400
X-MC-Unique: McXKtKaLOW2r3MvpRAX-mw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-24732cc0c8fso6708833a91.3
        for <fstests@vger.kernel.org>; Wed, 26 Apr 2023 08:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682523162; x=1685115162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UXzIOS42zwAbisYrvu9PUoIu4EfHsRshilah4JVYU0=;
        b=geG+eiGPJza4kfQGBbfyxgZVLyCjPIYNApojMJqoenjOxWoldXOYvTn/2oUWUdPdnh
         IUA6a0QVO+S3hzltUHQpGUuFpUONH91ruKtD/nBTwHw++M4OA3m5xj+QgWbM5CfjbSbA
         2rbxfAru3o1qhcs+SQjNeVCnOQM1+cGG6SGr6WUBXRH4q7yOSrB3ATbv8o+S5howY6KZ
         DHCeBos1flkY7C4oiuMIP0XQ84Rk2Vd08zk5WAH3x9l1gKVnsb26p/aKqZz2Yd5uddS3
         uSmciJ2JhZb4YVIAdZbRR/zeN4nrjY6yZFGKjVJHn6/QuBGN0ngnfr+w0PsbgPZSSGsH
         I9YA==
X-Gm-Message-State: AAQBX9fGsosmCkU7Fy/FLJwPXiL7XViERhASxlo//wSTw1eIa1CmO8mu
        3LEgWL8MiWmKD7hgRwAWSyJA2/o8esaSFoTR69JaILSleofdoLFdU9n8XXEFPyUl+oMa77heNmA
        V2m3LKkOEvVdZDv7jPg==
X-Received: by 2002:a17:90a:ff0e:b0:249:78bb:2bea with SMTP id ce14-20020a17090aff0e00b0024978bb2beamr19861446pjb.32.1682523162500;
        Wed, 26 Apr 2023 08:32:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350asQDgCLzrUaorMHKDuEDdXHPwCZiSMCSJM0g4S2+JnqW8HtnnksoOI1RWaAi8TtSWYqtgKfA==
X-Received: by 2002:a17:90a:ff0e:b0:249:78bb:2bea with SMTP id ce14-20020a17090aff0e00b0024978bb2beamr19861431pjb.32.1682523162168;
        Wed, 26 Apr 2023 08:32:42 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z2-20020a6552c2000000b0051b3d5543c4sm6243249pgp.30.2023.04.26.08.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 08:32:41 -0700 (PDT)
Date:   Wed, 26 Apr 2023 23:32:36 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, fstests@vger.kernel.org,
        Eryu Guan <guan@eryu.me>,
        Marc Dionne <marc.dionne@auristor.com>,
        Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org
Subject: Re: [PATCH v2 5/6] generic/531: Check for O_TMPFILE
Message-ID: <20230426153236.lyfv3jnigl4kirtp@zlang-mailbox>
References: <20230424141042.450535-1-dhowells@redhat.com>
 <20230424141042.450535-6-dhowells@redhat.com>
 <20230426144931.uxapfrnh6adcwevd@zlang-mailbox>
 <20230426145149.mjsuugpgusqr6oj2@zlang-mailbox>
 <20230426145450.GA59209@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426145450.GA59209@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 26, 2023 at 07:54:50AM -0700, Darrick J. Wong wrote:
> On Wed, Apr 26, 2023 at 10:51:49PM +0800, Zorro Lang wrote:
> > On Wed, Apr 26, 2023 at 10:49:31PM +0800, Zorro Lang wrote:
> > > On Mon, Apr 24, 2023 at 03:10:41PM +0100, David Howells wrote:
> > > > Make generic/531 check that the filesystem under test supports O_TMPFILE
> > > > before attempting to test it.
> > > > 
> > > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > > cc: linux-afs@lists.infradead.org
> > > > ---
> > > >  tests/generic/531 | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/tests/generic/531 b/tests/generic/531
> > > > index 5e84ca97..e5f3dddd 100755
> > > > --- a/tests/generic/531
> > > > +++ b/tests/generic/531
> > > > @@ -20,6 +20,7 @@ testfile=$TEST_DIR/$seq.txt
> > > >  # real QA test starts here
> > > >  _supported_fs generic
> > > >  _require_scratch
> > > > +_require_xfs_io_command "-T"
> > > 
> > > Make sense,
> > > 
> > > Reviewed-by: Zorro Lang <zlang@redhat.com>
> > 
> > Oh, generic/530 is similar with 531, why only 531 need this one?
> 
> AFS doesn't support shutdown, presumably.

Oh, 530 require shutdown :)

> 
> (But yes, both tests should be _require-ing this.)

Yes, I'll add that to generic/530 too, when I merge it.

> 
> --D
> 
> > > 
> > > >  _require_test_program "t_open_tmpfiles"
> > > >  
> > > >  _scratch_mkfs >> $seqres.full 2>&1
> > > > 
> > 
> 

