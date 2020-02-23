Return-Path: <SRS0=lR6x=4L=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19E9C35666
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Feb 2020 16:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E6220836
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Feb 2020 16:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSsnMTKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgBWQH4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Feb 2020 11:07:56 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42012 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726208AbgBWQHz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Feb 2020 11:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582474074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JsQSjegY898AV3KJTrEngDhJSaNXdwlwa+SvMKC5A7A=;
        b=VSsnMTKwvlxTjnC+VWG6qUl8tcRPwYEH5tRiTNgdnha4Ke9V2YvYzKtMHM4GooFoP3UD0P
        qV7OuzzYvROPnYNbIlxZzBf3ferdarF9RE7+IiIq2+T/XcTgEZQpctTDa2PS7wJSoimisN
        PiH6JJ3bpHSqRxkLJjlhylXXm/UbFfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-SviWEiReMzySb2xfxaorhw-1; Sun, 23 Feb 2020 11:07:51 -0500
X-MC-Unique: SviWEiReMzySb2xfxaorhw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37A9F18A5500;
        Sun, 23 Feb 2020 16:07:50 +0000 (UTC)
Received: from localhost (dhcp-12-102.nay.redhat.com [10.66.12.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9CA185F13;
        Sun, 23 Feb 2020 16:07:49 +0000 (UTC)
Date:   Mon, 24 Feb 2020 00:18:19 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/513: fix 4k allocsize fails on 64k pagesize
Message-ID: <20200223161818.GN14282@dhcp-12-102.nay.redhat.com>
Mail-Followup-To: Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org
References: <20200218165818.21066-1-zlang@redhat.com>
 <20200223124545.GB3840@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223124545.GB3840@desktop>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Feb 23, 2020 at 08:45:48PM +0800, Eryu Guan wrote:
> On Wed, Feb 19, 2020 at 12:58:18AM +0800, Zorro Lang wrote:
> > The minimal I/O preallocation size is page size. The allocsize=4k
> > always fails on 64k pagesize machine. So change the fs blocksize
> > allocsize test to allocsize=64k.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> 
> I think it's better to make the page size auto-detected, and filter out
> the actual size to something like "PAGESIZE" in .out file.
> 
> > ---
> >  tests/xfs/513     | 4 ++--
> >  tests/xfs/513.out | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tests/xfs/513 b/tests/xfs/513
> > index 70bc2f1c..3c3f5163 100755
> > --- a/tests/xfs/513
> > +++ b/tests/xfs/513
> > @@ -178,13 +178,13 @@ do_test()
> >  
> >  echo "** start xfs mount testing ..."
> >  # Test allocsize=size
> > -# Valid values for this option are page size (typically 4KiB) through to 1GiB
> > +# Valid values for this option are page size through to 1GiB
> >  do_mkfs
> >  if [ $dbsize -ge 1024 ];then
> >  	blsize="$((dbsize / 1024))k"
> >  fi
> >  do_test "" pass "allocsize" "false"
> > -do_test "-o allocsize=$blsize" pass "allocsize=$blsize" "true"
> > +do_test "-o allocsize=64k" pass "allocsize=64k" "true"
> 
> do_test "-o allocsize=PAGESIZE" pass "allocsize=PAGESIZE" "true"
> 
> And do_test converts the "PAGESIZE" to actual page size.

I thought about that too, but due to this case only uses PAGESIZE once
at here. So I don't know if it's worth changing much code for that.
And I don't think the PAGESIZE is necessary for this test, 4k and 64k
are all fine for me. The case just trys to make sure 4k/64k can be parsed by
fs_parse().

What do you think?

Thanks,
Zorro

> 
> >  do_test "-o allocsize=1048576k" pass "allocsize=1048576k" "true"
> >  do_test "-o allocsize=$((dbsize / 2))" fail
> >  do_test "-o allocsize=2g" fail
> > diff --git a/tests/xfs/513.out b/tests/xfs/513.out
> > index 9be18dd8..2d9f8384 100644
> > --- a/tests/xfs/513.out
> > +++ b/tests/xfs/513.out
> > @@ -5,7 +5,7 @@ QA output created by 513
> >  ** start xfs mount testing ...
> >  FORMAT: 
> >  TEST: "" "pass" "allocsize" "false"
> > -TEST: "-o allocsize=4k" "pass" "allocsize=4k" "true"
> > +TEST: "-o allocsize=64k" "pass" "allocsize=64k" "true"
> 
> So .out prints "... allocsize=PAGESIZE" ...
> 
> Thanks,
> Eryu
> 
> >  TEST: "-o allocsize=1048576k" "pass" "allocsize=1048576k" "true"
> >  TEST: "-o allocsize=2048" "fail"
> >  TEST: "-o allocsize=2g" "fail"
> > -- 
> > 2.20.1
> > 
> 

