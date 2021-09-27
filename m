Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CF4C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Sep 2021 08:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8BE6108E
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Sep 2021 08:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhI0IqC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Sep 2021 04:46:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41564 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233425AbhI0Ip5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Sep 2021 04:45:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E3FD1200A6;
        Mon, 27 Sep 2021 08:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632732258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5s4LzLYKDv1H379RX6zBCycenuUWDqkO7GNf+IvFNQM=;
        b=LIatziQCxnj2sXrfR2c2+qp1B1M4gmMlU51PqCwUyUiAaItBLAGe4RKCH5zm7GugmIxYUO
        Wm/1XaYHnjaIjjS9Hql7nUKKCFrxnI2mEeXy+eEXEeOJhHWQaVwNfltuu9INjXtMq3rzmr
        M/HZNPeBjaShoxNTG5x4YVW1yiy/F3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632732258;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5s4LzLYKDv1H379RX6zBCycenuUWDqkO7GNf+IvFNQM=;
        b=NpFLvs2wzLHdi4dP6gugmtTxTMeapFG6O+deGdLhoX9W3cmLwl1SZzraBEdd7wUJnsbDcS
        IEqRNj+KXWbowjAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B43D13A6A;
        Mon, 27 Sep 2021 08:44:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oZ8ZG2KEUWHhVQAAMHmgww
        (envelope-from <lhenriques@suse.de>); Mon, 27 Sep 2021 08:44:18 +0000
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id db4a4caa;
        Mon, 27 Sep 2021 08:44:17 +0000 (UTC)
Date:   Mon, 27 Sep 2021 09:44:17 +0100
From:   Luis Henriques <lhenriques@suse.de>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>, Eryu Guan <guan@eryu.me>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2 1/2] common/rc: add _require_user_exists() to check if
 a user exists
Message-ID: <YVGEYQLYroePoys6@suse.de>
References: <20210924091911.19413-1-lhenriques@suse.de>
 <20210924091911.19413-2-lhenriques@suse.de>
 <20210926101354.gniy2ytswm662y5y@fedora>
 <20210926102217.332hdmrhwlvgkrxj@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210926102217.332hdmrhwlvgkrxj@fedora>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Sep 26, 2021 at 06:22:17PM +0800, Zorro Lang wrote:
> On Sun, Sep 26, 2021 at 06:13:54PM +0800, Zorro Lang wrote:
> > On Fri, Sep 24, 2021 at 10:19:10AM +0100, Luis Henriques wrote:
> > > Function _require_user() does check if a user exists *and* if it is able
> > > to execute commands.  Add a new function to simply check if a user exists.
> > > 
> > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > > ---
> > >  common/rc | 27 ++++++++++++++++++---------
> > >  1 file changed, 18 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index 154bc2dd7e94..de9ba56eefcf 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -2289,18 +2289,27 @@ _cat_group()
> > >  	cat /etc/group
> > >  }
> > >  
> > > -# check for a user on the machine, fsgqa as default
> > > +# check if a user exists in the system
> > > +#
> > > +_require_user_exists()
> > > +{
> > > +	local user=$1
> > > +	_cat_passwd | grep -q $user
> > > +	[ "$?" == "0" ] || _notrun "$user user not defined."
> > 
> > As _require_user() does "su $qa_user" after the "grep", so it really make sure
> > there's an "user". But if the _require_user_exists() only trys to grep /etc/passed
> > to make sure there's an "$user", I'd like to make the "grep" condition be more exact.
> > For example, if there's an user "myuser100" in the /etc/passwd, then _require_user_exists
> > "myuser" or "user100" or "user1" or "user10" all return 0.
> > 
> > So how about:
> >   _cat_passwd | grep -qw $user
> > 
> > Or more exact:
> >   _cat_passwd | cut -d: -f1 | grep -qw $user
> > 
> > Or other better command line:)
> 
> Oh, the "-w" doesn't work with an user with "_", likes myuser_123. So
> how about:
> 
>   _cat_passwd | grep -q ^$user:

Yep, that seems to make sense.  I'll prepare v3 and send it out soon.

Cheers,
--
Luís
