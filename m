Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F531C433E6
	for <linux-fstests@archiver.kernel.org>; Sun, 31 Jan 2021 15:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CEE664E51
	for <linux-fstests@archiver.kernel.org>; Sun, 31 Jan 2021 15:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhAaOdU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 31 Jan 2021 09:33:20 -0500
Received: from out20-97.mail.aliyun.com ([115.124.20.97]:48400 "EHLO
        out20-97.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhAaObC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 31 Jan 2021 09:31:02 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07929036|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.552211-0.0013787-0.446411;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.JT2kYLL_1612103407;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JT2kYLL_1612103407)
          by smtp.aliyun-inc.com(10.147.40.44);
          Sun, 31 Jan 2021 22:30:07 +0800
Date:   Sun, 31 Jan 2021 22:30:07 +0800
From:   Eryu Guan <guan@eryu.me>
To:     zlang@redhat.com
Cc:     Eric Sandeen <sandeen@redhat.com>, fstests@vger.kernel.org
Subject: Re: [PATCH] ltp/fsstress: don't fail on io_uring ENOSYS
Message-ID: <20210131143007.GD2350@desktop>
References: <7a7b7128-ba62-59e1-552b-3b1fd6b1eb50@redhat.com>
 <20210129081043.GT14354@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129081043.GT14354@localhost.localdomain>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jan 29, 2021 at 04:10:44PM +0800, Zorro Lang wrote:
> On Thu, Jan 28, 2021 at 03:31:40PM -0600, Eric Sandeen wrote:
> > We might have URING #defined at build time, but be running on a kernel
> > which does not support it.
> > 
> > For that reason, we should not exit with an error if 
> > io_uring_queue_init() fails with ENOSYS. We can just note the lack of
> > support and skip all future io_uring operations.
> > 
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > ---
> > 
> > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > index 22df5e38..73751935 100644
> > --- a/ltp/fsstress.c
> > +++ b/ltp/fsstress.c
> > @@ -35,6 +35,7 @@ io_context_t	io_ctx;
> >  #include <liburing.h>
> >  #define URING_ENTRIES	1
> >  struct io_uring	ring;
> > +bool have_io_uring;			/* to indicate runtime availability */
> >  #endif
> >  #include <sys/syscall.h>
> >  #include <sys/xattr.h>
> > @@ -706,9 +707,15 @@ int main(int argc, char **argv)
> >  			}
> >  #endif
> >  #ifdef URING
> > +			have_io_uring = true;
> > +			/* If ENOSYS, just ignore uring, other errors are fatal. */
> 
> Yes, I thought about if we should do this since rhel8 kernel removed io_uring
> support from kernel, but left userspace liburing. But if we do this for io_uring,
> should we do the same check the others which can be disabled from kernel? Likes: AIO?

io_uring is a relative new interface, and it's quite possible that some
distros don't support it. aio has been there for a long time, and is
very unlikely disabled. If we really need to do the same check for aio,
we could do it in another patch I guess.

Thanks,
Eryu
