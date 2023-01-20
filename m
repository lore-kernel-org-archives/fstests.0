Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E703C05027
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Jan 2023 19:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjATTWV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Jan 2023 14:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjATTWU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Jan 2023 14:22:20 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91015113EE
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2023 11:22:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 402D15FC4D;
        Fri, 20 Jan 2023 19:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674242538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VMPZT5s2npe7yu6CP96zsVmXem1hvQgYzhRDey+QNAc=;
        b=JaKnqEswuhIJcRMLdMwfeZ6TIPUAjGiI85DEDneU2pifSMl7JOscJGLWH2FqmBLivAOCEq
        ljeCk3y+kPwuH3kPZO8gaWXDsyciHULzJJ1lBPY9jHNnK/hwtLYT3IPvNsImo6MseUhb4K
        fHtGFK9TlJ8XmKBS0aK4cQNVS882hcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674242538;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VMPZT5s2npe7yu6CP96zsVmXem1hvQgYzhRDey+QNAc=;
        b=c5d7LPmb3w//MDvzRfIYI+9lZBbdcSG8YpagsVhJm/YmPTcxPKS4HvMD5KD+p5qTdiH5Oq
        u8UuPKhU3NXO4YCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3513813251;
        Fri, 20 Jan 2023 19:22:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YJPtDOrpymNiewAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 20 Jan 2023 19:22:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BA073A06B5; Fri, 20 Jan 2023 20:22:17 +0100 (CET)
Date:   Fri, 20 Jan 2023 20:22:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, David Disseldorp <ddiss@suse.de>,
        fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common: Provide blocksize and ecclength to udf fsck
Message-ID: <20230120192217.uf7g7dbz6xtvtevj@quack3>
References: <20230119104618.28701-1-jack@suse.cz>
 <20230119105410.9236-1-jack@suse.cz>
 <20230120154123.7f59e1cc@echidna.fritz.box>
 <20230120154510.xgqweuagzmqup4ql@quack3>
 <20230120190815.fajw7d2cgwim7cju@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120190815.fajw7d2cgwim7cju@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat 21-01-23 03:08:15, Zorro Lang wrote:
> On Fri, Jan 20, 2023 at 04:45:10PM +0100, Jan Kara wrote:
> > Hello!
> > 
> > On Fri 20-01-23 15:41:23, David Disseldorp wrote:
> > > On Thu, 19 Jan 2023 11:54:02 +0100, Jan Kara wrote:
> > > > udf_test program used for verifying filesystem is not able to determine
> > > > filesystem blocksize. Provide it in the options together with disabling
> > > > ecclength as it is not used on harddrives.
> > > > 
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > >  common/rc | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/common/rc b/common/rc
> > > > index 8060c03b7d18..de94e5a4cde4 100644
> > > > --- a/common/rc
> > > > +++ b/common/rc
> > > > @@ -3075,9 +3075,13 @@ _check_udf_filesystem()
> > > >      fi
> > > >  
> > > >      local device=$1
> > > > -    local opt_arg=""
> > > > +    local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
> > > 
> > > It looks as though mkudffs also accepts --blocksize= for this, so it
> > > should also be handled here, IIUC.
> 
> And _scratch_mkfs_sized need blocksize too. If udf support blocksize parameter,
> you might like to take a look at that helper too, due to it always use 4096 for udf
> blocksize.
> 
> Similar helpers are _scratch_mkfs_geom (maybe not suit for udf) and
> _scratch_mkfs_blocksized.

Thanks for the tips, I'll have a look into those next.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
