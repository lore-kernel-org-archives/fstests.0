Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3C3C25B4E
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Jan 2023 16:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjATQsC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Jan 2023 11:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjATQsB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Jan 2023 11:48:01 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F394688
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2023 08:48:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 91B605FB71;
        Fri, 20 Jan 2023 16:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674233278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0kohTfCqcOft9KrsOXQZPV7pI8env0iZ1gw0uaQt0c=;
        b=pxKLwRh8IiKxEJjQnzXLKneaUnpzhOliYH+GePx43rZkOOiSTAkf5Xtaj0SBGyaQpLPQgW
        VUXPK3Gdxr/qTJcSKhc16wOETKeUtThKHoSc3SdF9XxiRqbP7A206+5MaMzlkI/NnW+f8T
        3o69AWIRH8q8FLElvUuJfdQAOBjJIO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674233278;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H0kohTfCqcOft9KrsOXQZPV7pI8env0iZ1gw0uaQt0c=;
        b=z0agMcq+NykoTsP7BdA2eeqXqrkTjBUiHWwLd/Sc/njQJMhmCozC2typCTk1PYyFWCXv9V
        zQQYHL81VbaJVPDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E17B1390C;
        Fri, 20 Jan 2023 16:47:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KxZLHr7FymNmMwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 20 Jan 2023 16:47:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E6F10A06B5; Fri, 20 Jan 2023 17:47:57 +0100 (CET)
Date:   Fri, 20 Jan 2023 17:47:57 +0100
From:   Jan Kara <jack@suse.cz>
To:     David Disseldorp <ddiss@suse.de>
Cc:     Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] common: Provide blocksize and ecclength to udf
 fsck
Message-ID: <20230120164757.tcxgw2wbnq46vuyw@quack3>
References: <20230120154944.25573-1-jack@suse.cz>
 <20230120155034.22349-1-jack@suse.cz>
 <20230120173454.31cdd5d5@echidna.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120173454.31cdd5d5@echidna.fritz.box>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri 20-01-23 17:34:54, David Disseldorp wrote:
> On Fri, 20 Jan 2023 16:50:29 +0100, Jan Kara wrote:
> 
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
> > index 8060c03b7d18..bf3effa4c1ed 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3075,9 +3075,13 @@ _check_udf_filesystem()
> >      fi
> >  
> >      local device=$1
> > -    local opt_arg=""
> > +    local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*(-b|--blocksize)[ =]?+([0-9]+).*/\2/p'`
> > +    if [ -z "$blksz" ]; then
> > +	blksz=512
> > +    fi
> > +    local opt_arg="-ecclength 1 -blocksize $blksz"
> >      if [ $# -eq 2 ]; then
> > -	opt_arg="-lastvalidblock $(( $2 - 1 ))"
> > +	opt_arg+=" -lastvalidblock $(( $2 - 1 ))"
> >      fi
> >  
> >      rm -f $seqres.checkfs
> 
> Looks fine - I suppose it's safe to assume the --media-type=hd default
> blksz value.
> Reviewed-by: David Disseldorp <ddiss@suse.de>

Thanks for review! Yeah, I didn't really find a value in trying to handle
anything else. If a real usecase comes, we can always tweak this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
