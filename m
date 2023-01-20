Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD30C05027
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Jan 2023 15:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjATPpk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjATPpi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Jan 2023 10:45:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFB3975F
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2023 07:45:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7F4F65FAF2;
        Fri, 20 Jan 2023 15:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674229511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iO2XdmddKrCKSRRxtGFTym64RMqz5T8fUq+wB74kCUs=;
        b=pXXcHvEaA2pCAD7Zk/pT/K9S2cdd90qFPzidX3qbuRWb1CSFe9pPIQlEBH8A90Wq/H0DaP
        qPaGOgWd8ty0wlWldUK3fArpgJQJu5364OlP8mGwwAGGakre4exLytzYZHrE0nT1zS/Blk
        QS0BENWD19oh8e1Y+Sj4ZdmQT+2xJRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674229511;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iO2XdmddKrCKSRRxtGFTym64RMqz5T8fUq+wB74kCUs=;
        b=6VXTm4VzA/3z0FIZ324fK7SdGOOYgmxQYAnlFBjkUEOtnoeKdNLX3TlIkgcYEH6vy40sdz
        k4wI6qMqxGroTiCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74FAA13251;
        Fri, 20 Jan 2023 15:45:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6qCLHAe3ymMVEAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 20 Jan 2023 15:45:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F4211A06B5; Fri, 20 Jan 2023 16:45:10 +0100 (CET)
Date:   Fri, 20 Jan 2023 16:45:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     David Disseldorp <ddiss@suse.de>
Cc:     Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common: Provide blocksize and ecclength to udf fsck
Message-ID: <20230120154510.xgqweuagzmqup4ql@quack3>
References: <20230119104618.28701-1-jack@suse.cz>
 <20230119105410.9236-1-jack@suse.cz>
 <20230120154123.7f59e1cc@echidna.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120154123.7f59e1cc@echidna.fritz.box>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hello!

On Fri 20-01-23 15:41:23, David Disseldorp wrote:
> On Thu, 19 Jan 2023 11:54:02 +0100, Jan Kara wrote:
> > udf_test program used for verifying filesystem is not able to determine
> > filesystem blocksize. Provide it in the options together with disabling
> > ecclength as it is not used on harddrives.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  common/rc | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index 8060c03b7d18..de94e5a4cde4 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3075,9 +3075,13 @@ _check_udf_filesystem()
> >      fi
> >  
> >      local device=$1
> > -    local opt_arg=""
> > +    local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
> 
> It looks as though mkudffs also accepts --blocksize= for this, so it
> should also be handled here, IIUC.

Thanks for review! I've fixed this.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
