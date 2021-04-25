Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24FEC433B4
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 06:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2BC61483
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 06:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhDYGb4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 25 Apr 2021 02:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhDYGb4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Apr 2021 02:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619332276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g76PM57L2+R001d8uGZcGXNPwNRPCvV9zBTPdtUl1qI=;
        b=LTNUkC9DBd79yTMIjEjoHMnDAuDI7rUsqxVIjQ49TZDzgSwYpBoNUAHrsMgqZlqNvrq6Xa
        Xr+7daX/pBd8Xbu3c1JOf2fYdgHOfL3u8TPPEmGgpV2wAyLTXNWVWQOeB4xP6fxpELdJs1
        1KX7+ibKctj/qwT9DO7OYwj1zP0kicA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-4ASlhPbZOx2gCJ3CVA1uHA-1; Sun, 25 Apr 2021 02:31:12 -0400
X-MC-Unique: 4ASlhPbZOx2gCJ3CVA1uHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF35F18397A5;
        Sun, 25 Apr 2021 06:31:11 +0000 (UTC)
Received: from localhost (unknown [10.66.61.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA52B1000358;
        Sun, 25 Apr 2021 06:31:10 +0000 (UTC)
Date:   Sun, 25 Apr 2021 14:48:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org
Subject: Re: generic/095 and generic/300 failures
Message-ID: <20210425064828.GX13946@localhost.localdomain>
Mail-Followup-To: Eryu Guan <guan@eryu.me>,
        Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org
References: <YH5siAMU+6p7iD01@infradead.org>
 <YIT4n/154e/vOm9H@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIT4n/154e/vOm9H@desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 25, 2021 at 01:05:35PM +0800, Eryu Guan wrote:
> On Tue, Apr 20, 2021 at 07:54:16AM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > generic/095 and generic/300 have been failing for me with every config
> > on every file system for a while with the following messages:
> > 
> > --- tests/generic/095.out	2016-03-29 13:59:30.405053956 +0000
> > +++ results/generic/095.out.bad	2021-04-20 05:44:54.432081845 +0000
> > @@ -1,2 +1,7 @@
> >  QA output created by 095
> > +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> > +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> > +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> > +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> > +job9: No I/O performed by mmap, perhaps try --debug=io option for details?
> >  Silence is golden           
> > 
> > --- tests/generic/300.out	2016-03-29 13:59:30.431720622 +0000
> > +++ results/generic/300.out.bad	2021-04-20 05:45:06.324708699 +0000
> > @@ -2,3 +2,4 @@
> >  
> >  Run fio with random aio-dio pattern
> >    
> > +falloc_raicer: No I/O performed by falloc, perhaps try --debug=io option for details?
> > 
> > 
> > ----- End forwarded message -----
> 
> Yeah, I've noticed these failures as well, and it seems that it's caused
> by fio behavior change, as Zorro said he never hit such failures[1].
> 
> I'm using fio-3.7

I use fio-3.25-3. I never saw the errors you metioned above.

How about CC axboe@kernel.dk (fio maintainer) if you still can reproduce this
error on latest fio version?

Thanks,
Zorro

> 
> # fio --version
> fio-3.7-66-gedfc
> 
> Thanks,
> Eryu
> 
> [1] https://www.spinics.net/lists/fstests/msg15871.html
> 

