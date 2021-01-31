Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC17C433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 31 Jan 2021 16:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4B164E27
	for <linux-fstests@archiver.kernel.org>; Sun, 31 Jan 2021 16:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhAaQDM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 31 Jan 2021 11:03:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229474AbhAaQDG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 31 Jan 2021 11:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612108896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GbKgY2r7xVzD1FtxYJXVocz16vdGsGUrkaYR+XhL7T8=;
        b=MmSzFrVHs20cmFTG7peQM6OF/rtnwQcaVra2ISWjRNtrewSxHf9zs1UCh19TV+8f0p+4xA
        RF1c6/Aije+BLBr3ZNMIuyqL74s/lOE9tziXsRUgI4N1yRXUvrzEzlf1gi758KnFs0HMPw
        gLggmUZWBOatg9aRrDJKV1NJCyteACA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-O8bPyFGOPZWDsHZMKeaSPQ-1; Sun, 31 Jan 2021 11:01:34 -0500
X-MC-Unique: O8bPyFGOPZWDsHZMKeaSPQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AD2C801817;
        Sun, 31 Jan 2021 16:01:33 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C0594D;
        Sun, 31 Jan 2021 16:01:32 +0000 (UTC)
Date:   Mon, 1 Feb 2021 00:18:34 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ltp/fsstress: don't fail on io_uring ENOSYS
Message-ID: <20210131161834.GY14354@localhost.localdomain>
Mail-Followup-To: Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
References: <7a7b7128-ba62-59e1-552b-3b1fd6b1eb50@redhat.com>
 <20210129081043.GT14354@localhost.localdomain>
 <20210131143007.GD2350@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131143007.GD2350@desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jan 31, 2021 at 10:30:07PM +0800, Eryu Guan wrote:
> On Fri, Jan 29, 2021 at 04:10:44PM +0800, Zorro Lang wrote:
> > On Thu, Jan 28, 2021 at 03:31:40PM -0600, Eric Sandeen wrote:
> > > We might have URING #defined at build time, but be running on a kernel
> > > which does not support it.
> > > 
> > > For that reason, we should not exit with an error if 
> > > io_uring_queue_init() fails with ENOSYS. We can just note the lack of
> > > support and skip all future io_uring operations.
> > > 
> > > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > > ---
> > > 
> > > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > > index 22df5e38..73751935 100644
> > > --- a/ltp/fsstress.c
> > > +++ b/ltp/fsstress.c
> > > @@ -35,6 +35,7 @@ io_context_t	io_ctx;
> > >  #include <liburing.h>
> > >  #define URING_ENTRIES	1
> > >  struct io_uring	ring;
> > > +bool have_io_uring;			/* to indicate runtime availability */
> > >  #endif
> > >  #include <sys/syscall.h>
> > >  #include <sys/xattr.h>
> > > @@ -706,9 +707,15 @@ int main(int argc, char **argv)
> > >  			}
> > >  #endif
> > >  #ifdef URING
> > > +			have_io_uring = true;
> > > +			/* If ENOSYS, just ignore uring, other errors are fatal. */
> > 
> > Yes, I thought about if we should do this since rhel8 kernel removed io_uring
> > support from kernel, but left userspace liburing. But if we do this for io_uring,
> > should we do the same check the others which can be disabled from kernel? Likes: AIO?
> 
> io_uring is a relative new interface, and it's quite possible that some
> distros don't support it. aio has been there for a long time, and is
> very unlikely disabled. If we really need to do the same check for aio,
> we could do it in another patch I guess.

OK, I just have this one question, this patch looks good to me.

Thanks,
Zorro

> 
> Thanks,
> Eryu
> 

