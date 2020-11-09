Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B80C388F7
	for <linux-fstests@archiver.kernel.org>; Mon,  9 Nov 2020 18:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8481E206F1
	for <linux-fstests@archiver.kernel.org>; Mon,  9 Nov 2020 18:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpMoYdvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgKIS4b (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 9 Nov 2020 13:56:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:59714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729302AbgKIS4b (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 9 Nov 2020 13:56:31 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73B8A206D8;
        Mon,  9 Nov 2020 18:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604948190;
        bh=JhqTni/GwoaMIwcOIln42GD9nhoul6SktLsP8Ikqp2o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fpMoYdvrN0ebhaccUHtTd/z56Qewjn/oKBoLZ7NJXN8TsVP1wE87ksgoV9bRBAzJw
         tv+MZGHSUADNtEiT1Z7zXIxEv1fSlip9g2xHPuMLyRBB8rFumvO1DOwctgovOTu9M5
         1ZTqJTqIbPmURvD4ESu4AkndEP4Mzktm5z497LWg=
Message-ID: <b0adb484dac6c2020467f148c7e00a9dab6af5df.camel@kernel.org>
Subject: Re: [PATCH] common/rc: allow setting $SCRATCH_FS_MOUNT_OPTS
From:   Jeff Layton <jlayton@kernel.org>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org
Date:   Mon, 09 Nov 2020 13:56:29 -0500
In-Reply-To: <20201108063701.GG3853@desktop>
References: <20201105150936.410407-1-jlayton@kernel.org>
         <20201108063701.GG3853@desktop>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, 2020-11-08 at 14:37 +0800, Eryu Guan wrote:
> On Thu, Nov 05, 2020 at 10:09:36AM -0500, Jeff Layton wrote:
> > We already have a $TEST_FS_MOUNT_OPTS which gets applied only to the
> > test mount, but we don't have a corresponding variable for the scratch
> > mount. Add one.
> 
> MOUNT_OPTIONS is used for the scratch mount, and
> _common_dev_mount_options includes it. Would you please confirm if that
> works for you?
> 
> Thanks,
> Eryu
> 

Yes, it does. I had had a problem with that at one point, but I don't
currently recall what it was. In any case, feel free to drop this one.

Thanks,
Jeff

> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  common/rc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 65ebfe201139..23874d1e5b8e 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -308,7 +308,7 @@ _scratch_mount_options()
> >  {
> >  	_scratch_options mount
> >  
> > 
> > 
> > 
> > -	echo `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
> > +	echo `_common_dev_mount_options $*` $SCRATCH_OPTIONS $SCRATCH_FS_MOUNT_OPTS \
> >  					$SCRATCH_DEV $SCRATCH_MNT
> >  }
> >  
> > 
> > 
> > 
> > -- 
> > 2.28.0

-- 
Jeff Layton <jlayton@kernel.org>

