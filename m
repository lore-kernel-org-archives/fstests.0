Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841EDC433DB
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 14:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452A7619FF
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Mar 2021 14:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbhCXODr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 Mar 2021 10:03:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235945AbhCXODg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 24 Mar 2021 10:03:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD9B061A05;
        Wed, 24 Mar 2021 14:03:33 +0000 (UTC)
Date:   Wed, 24 Mar 2021 15:03:30 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Eryu Guan <guan@eryu.me>,
        fstests <fstests@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v10 0/6] fstests: add idmapped mounts tests
Message-ID: <20210324140330.cx35tciq73ruzvrv@wittgenstein>
References: <20210322134522.916512-1-brauner@kernel.org>
 <20210322135002.6tyexslvqfiaari7@wittgenstein>
 <20210322142115.4ehetdcopvmvs7fl@wittgenstein>
 <CAOQ4uxjB3aDehSeomAvi-7rUJRZmmR=GQFAqod9SzSoGu5PjnA@mail.gmail.com>
 <20210324084126.ke7mden2s3a35koa@wittgenstein>
 <CAOQ4uxjwN+3xAjen5G8pRccYX_4bSCrcQUR5pqi2bFRpGPeSqw@mail.gmail.com>
 <20210324134554.rio27zsmsfzs6eqa@wittgenstein>
 <CAOQ4uxg4hkwgyFX=uq-M+jytEPs64069vn-YyhY_Y+x8jrdBjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg4hkwgyFX=uq-M+jytEPs64069vn-YyhY_Y+x8jrdBjQ@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 24, 2021 at 04:01:18PM +0200, Amir Goldstein wrote:
> > > Meanwhile, found a bug in Makefile:
> > >
> > > --- a/src/idmapped-mounts/Makefile
> > > +++ b/src/idmapped-mounts/Makefile
> > > @@ -25,11 +25,11 @@ depend: .dep
> > >
> > >  include $(BUILDRULES)
> > >
> > > -idmapped-mounts:
> > > +idmapped-mounts: $(CFILES_IDMAPPED_MOUNTS)
> > >         @echo "    [CC]    $@"
> > >         $(Q)$(LTLINK) $(CFILES_IDMAPPED_MOUNTS) -o $@ $(CFLAGS)
> > > $(LDFLAGS) $(LDLIBS)
> > >
> > > -mount-idmapped:
> > > +mount-idmapped: $(CFILES_MOUNT_IDMAPPED)
> > >         @echo "    [CC]    $@"
> > >         $(Q)$(LTLINK) $(CFILES_MOUNT_IDMAPPED) -o $@ $(CFLAGS)
> > > $(LDFLAGS) $(LDLIBS)
> >
> > Stupid question maybe but what is the reason for this change?
> > It builds fine without those lines.
> >
> > Building idmapped-mounts
> > [CC]    idmapped-mounts
> > [CC]    mount-idmapped
> >
> 
> My mistake. You are right. It should be fine as is.
> I may have messed up something else while building.
> 
> You may take the fix or leave it - as you wish.

Eh, it kinda makes it more obvious to have the lines there and they
don't hurt so I've added your change.

Christian
