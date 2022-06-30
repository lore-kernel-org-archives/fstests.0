Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB1BC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Jun 2022 02:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbiF3CSU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 22:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiF3CSS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 22:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DD2713E32
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 19:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656555495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XP9k9gWAtgCMmPR+ae3+YtUkU01MhoolYxQwFMRA9PA=;
        b=BF1XXrIn5miC7WjAZHAjVyAcYwdQaprnidhxHSYkj+xSKpDpHwJgEkTzSRoh5ugkBw+nxg
        lIMNrNcAueldrtlaWOW2+99Uck6cL1AYd4TAZb1LvKlExqVfalM82+46+jhUhe4n7ra+fe
        WkMM3R329EE19DVJFsTwg2DsgzscBzo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-rbnaFDtgMjWHmtGyp6-EBw-1; Wed, 29 Jun 2022 22:18:13 -0400
X-MC-Unique: rbnaFDtgMjWHmtGyp6-EBw-1
Received: by mail-qv1-f69.google.com with SMTP id mz4-20020a0562142d0400b004726d99aa49so9820176qvb.10
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 19:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XP9k9gWAtgCMmPR+ae3+YtUkU01MhoolYxQwFMRA9PA=;
        b=Nt4GnfqDv9CqZG1au75asbUcuzuIOrDm7nuAZvkW53xxSVQc62FSM4u3NiNKF511D0
         siogcy2qnD1QVj6wgr+cSNtCMLCCPhRN+2lASduGTPCCQ07l8OWuxRyJ/gNPQNL5ix3b
         ppoNrye0jK+Zm64FBPn7ta4CUWIXUQtNDMlvmxI1gkc+K1LkOJYJNdQkS/cHyOR6z/dv
         x+e0f7BXWr/7gNRr5A//zu7ynH6q6csODWHrDksnarG4tXYN2d/0nKY95EH8DXf9GJcP
         3zmBGq/T33Uhh1fzKXG/oGm1xt4qXKw5NK4CpNLhKrc9YsixfCJRFd25yzy4/7MGhP5w
         yNng==
X-Gm-Message-State: AJIora+X+fXI1gO6H1zvRUEd9YozGvRqeYarxQuEATkZJ97+1gw8gpD0
        v9KtM/PtNZiJaAr+41S3RX/8hE7UXX2vk01NzirJaK8pJ0VWawP3L38h+1W02L2fTY+PmIxa2nB
        viT90T8B4ZrmHd1ZTSQ==
X-Received: by 2002:a05:620a:1031:b0:6ae:eaf2:928e with SMTP id a17-20020a05620a103100b006aeeaf2928emr4661248qkk.575.1656555492771;
        Wed, 29 Jun 2022 19:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sJLSKk9yUTATs5US32SwV9Vy3CVEllYYVaiciXq/5J64df3MYupnYe12M6Z9/XmR/bNur5yg==
X-Received: by 2002:a05:620a:1031:b0:6ae:eaf2:928e with SMTP id a17-20020a05620a103100b006aeeaf2928emr4661240qkk.575.1656555492463;
        Wed, 29 Jun 2022 19:18:12 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c24-20020ac853d8000000b003171a5dc474sm11730983qtq.23.2022.06.29.19.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 19:18:11 -0700 (PDT)
Date:   Thu, 30 Jun 2022 10:18:06 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH 2/9] xfs/070: filter new superblock verifier messages
Message-ID: <20220630021806.vosxxjoqdzabgzid@zlang-mailbox>
References: <165644767753.1045534.18231838177395571946.stgit@magnolia>
 <165644768886.1045534.3177166462110135738.stgit@magnolia>
 <20220629041547.GO1098723@dread.disaster.area>
 <20220629091248.vtqtlk2wvqkmtxkm@zlang-mailbox>
 <YrzVBs9h0lzYFvCo@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrzVBs9h0lzYFvCo@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 29, 2022 at 03:41:10PM -0700, Darrick J. Wong wrote:
> On Wed, Jun 29, 2022 at 05:12:48PM +0800, Zorro Lang wrote:
> > On Wed, Jun 29, 2022 at 02:15:47PM +1000, Dave Chinner wrote:
> > > On Tue, Jun 28, 2022 at 01:21:28PM -0700, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > 
> > > > In Linux 5.19, the superblock verifier logging changed to elaborate on
> > > > what was wrong.  Fix the xfs_repair filtering function to accomodate
> > > > this development.
> > > > 
> > > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > > ---
> > > >  common/repair |    1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > 
> > > > diff --git a/common/repair b/common/repair
> > > > index 463ef9db..398e9904 100644
> > > > --- a/common/repair
> > > > +++ b/common/repair
> > > > @@ -29,6 +29,7 @@ _filter_repair()
> > > >  # for sb
> > > >  /- agno = / && next;	# remove each AG line (variable number)
> > > >  s/(pointer to) (\d+)/\1 INO/;
> > > > +s/Superblock has bad magic number.*/bad magic number/;
> > > >  # Changed inode output in 5.5.0
> > > >  s/sb root inode value /sb root inode /;
> > > >  s/realtime bitmap inode value /realtime bitmap inode /;
> > > 
> > > Didn't I already fix that in commit 4c76d0ba ("xfs/070: filter the
> > > bad sb magic number error")?
> 
> Ah whoops I guess we can drop this one then.
> 
> > Yes, you've added a line as below:
> >   s/^Superblock has (bad magic number) 0x.*/\1/;
> > which is equal to:
> >   s/Superblock has bad magic number.*/bad magic number/;
> > So we need to fix it again.
> 
> We .... do?

Sorry, "don't" missed :-P

> 
> --D
> 
> > 
> > > 
> > > Cheers,
> > > 
> > > Dave.
> > > 
> > > -- 
> > > Dave Chinner
> > > david@fromorbit.com
> > > 
> > 
> 

