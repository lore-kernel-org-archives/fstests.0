Return-Path: <SRS0=V6JG=AR=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9632EC433E0
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jul 2020 13:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7676A2073E
	for <linux-fstests@archiver.kernel.org>; Mon,  6 Jul 2020 13:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594043455;
	bh=8X476Xx6QPMaGgy21UD16TAEA7+Tbxw96acl9dKgorg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=GijdNI2ouyKRR6j8eGx0BAKV9x5IPYfIKjWXZq2i5Um6Zk6on+Ed926GeXHIa4ACX
	 sTdQm+EIDKXQrjWHpSRYc9jfCxO2iSOMs4UFK/2A4RhxKyfcQUvUlyykIQVkTurvCi
	 AosfeDpF0FFOZm4TUJ7fpVGgjikF8Jq4VDk9ykKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgGFNuz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728961AbgGFNuy (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 6 Jul 2020 09:50:54 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B8BF2070C;
        Mon,  6 Jul 2020 13:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594043453;
        bh=8X476Xx6QPMaGgy21UD16TAEA7+Tbxw96acl9dKgorg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QxzRj6/nWi0Wpc8PFeD6ytA1nz5on6qrh5K83/v/ldM6YWKVKUzkWRjLrhuV0yT/0
         tz+cmlyoY925qBFqrOmtTTTUpdL217vFKIxCzSgLtpzpukfNbW7s7Eu2k0zutB9aGc
         lrCOJpmY7Of5X1AdoiZPZygoQcUeFFwrj8uiBcmk=
Message-ID: <17a70522b84b74f1ada52de04f3695bd260ce06b.camel@kernel.org>
Subject: Re: [PATCH] generic/377: filter out xattrs that don't start with
 'user.'
From:   Jeff Layton <jlayton@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Date:   Mon, 06 Jul 2020 09:50:52 -0400
In-Reply-To: <20200705114113.GS1938@dhcp-12-102.nay.redhat.com>
References: <20200701175205.342650-1-jlayton@kernel.org>
         <20200705114113.GS1938@dhcp-12-102.nay.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, 2020-07-05 at 19:41 +0800, Zorro Lang wrote:
> On Wed, Jul 01, 2020 at 01:52:05PM -0400, Jeff Layton wrote:
> > Most hosts that I've been testing on seem to display security.selinux in
> > listxattr. 377.out doesn't account for that so it routinely fails for me
> > in testing.
> > 
> > When testing the output of listxattr in generic/377, filter out any xattr
> > names that don't start with 'user.'. That should help ensure consistent
> > output on SELinux-enabled hosts.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> 
> Yeah, I hit this error[1] too. This patch looks good to me.
> 
> One more question, do you hit similar failure on generic/062, likes [2]? 
> 
> Thanks,
> Zorro
> 
> [1]
> --- /dev/fd/63	2020-07-02 12:07:42.948327419 -0400
> +++ results/generic/377.out.bad	2020-07-02 12:07:41.990305624 -0400
> @@ -1,4 +1,5 @@
>  QA output created by 377
> +xattr: security.selinux
>  xattr: user.foo
>  xattr: user.hello
>  xattr: user.ping
> ...
> 
> [2]
> --- /dev/fd/63	2020-07-02 07:15:09.072853920 -0400
> +++ results/generic/062.out.bad	2020-07-02 07:15:08.156833194 -0400
> @@ -52,6 +52,7 @@
>  SCRATCH_MNT/reg: user.name2: No such attribute or operation not permitted
>  *** final list (strings, type=reg, nsp=user)
>  # file: SCRATCH_MNT/reg
> +security.selinux=0x73797374656d5f753a6f626a6563745f723a6e66735f743a733000
>  user.name=0xbabe
>  user.name3=0xdeface
> ...
> 

Thanks.

Yes, I generally hit this too. We can do a similar fix for that one. I
just figured I'd float this smaller patch before I went to the effort.

I'll plan to spin up a second patch that similarly fixes generic/062.

> >  tests/generic/377 | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > I'm not sure why this doesn't fail for most people, unless most are
> > turning off SELinux. Is this the right approach?
> > 
> > diff --git a/tests/generic/377 b/tests/generic/377
> > index f7835ee8ff9e..f08abdca60a6 100755
> > --- a/tests/generic/377
> > +++ b/tests/generic/377
> > @@ -48,7 +48,7 @@ $SETFATTR_PROG -n user.ping -v pong $testfile
> >  $SETFATTR_PROG -n user.hello -v there $testfile
> >  
> >  # 1. Call listxattr without buffer length argument. This should succeed.
> > -$listxattr $testfile | sort
> > +$listxattr $testfile | grep '^xattr: user\.' | sort
> >  
> >  # 2. Calling listxattr on nonexistant file should fail with -ENOENT.
> >  $listxattr ""
> > @@ -66,7 +66,7 @@ $listxattr $testfile 9
> >  $listxattr $testfile 11
> >  
> >  # 6. Calling listxattr with buffersize bigger than needed should succeed.
> > -$listxattr $testfile 500 | sort
> > +$listxattr $testfile 500 | grep '^xattr: user\.' | sort
> >  
> >  status=0
> >  exit
> > -- 
> > 2.26.2
> > 

-- 
Jeff Layton <jlayton@kernel.org>

