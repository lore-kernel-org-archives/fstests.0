Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A737AC25B4E
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Jan 2023 16:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjATQfU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Jan 2023 11:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjATQfT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Jan 2023 11:35:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548116E40E
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2023 08:34:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B6C3B5F8EA;
        Fri, 20 Jan 2023 16:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674232425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W/yyrvmH+A+NeXhGYGutVs7gjpAfIDPv1bat4AW+xjo=;
        b=UQipT6yjs6aXvfbdlGf55R6JppmPuRMYTrAJcnuEiz7gUTND1bgGgHfZIXR2YjNqHvTW0q
        VBCA9mmRWxn1B3EpX8zGuEK9CfEf2ganr4FRxp8CD0sr01zNKvHsiwrCabh8b2nwJjTKJy
        eQlftdH7mcIC1U9vqA6iIutJ8bZs4xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674232425;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W/yyrvmH+A+NeXhGYGutVs7gjpAfIDPv1bat4AW+xjo=;
        b=Nrg7Cria6NzioWyGrlhAyk3RuhLwkPpFtBft+nTuhAOg2Esju9Gf4RQ/B5UVbyvQlVHCWo
        kV+pm1G9M0jNtdCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9ABB51390C;
        Fri, 20 Jan 2023 16:33:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Kl1YJGnCymMoLAAAMHmgww
        (envelope-from <ddiss@suse.de>); Fri, 20 Jan 2023 16:33:45 +0000
Date:   Fri, 20 Jan 2023 17:34:54 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Jan Kara <jack@suse.cz>
Cc:     <fstests@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] common: Provide blocksize and ecclength to udf
 fsck
Message-ID: <20230120173454.31cdd5d5@echidna.fritz.box>
In-Reply-To: <20230120155034.22349-1-jack@suse.cz>
References: <20230120154944.25573-1-jack@suse.cz>
        <20230120155034.22349-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, 20 Jan 2023 16:50:29 +0100, Jan Kara wrote:

> udf_test program used for verifying filesystem is not able to determine
> filesystem blocksize. Provide it in the options together with disabling
> ecclength as it is not used on harddrives.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  common/rc | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 8060c03b7d18..bf3effa4c1ed 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3075,9 +3075,13 @@ _check_udf_filesystem()
>      fi
>  
>      local device=$1
> -    local opt_arg=""
> +    local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*(-b|--blocksize)[ =]?+([0-9]+).*/\2/p'`
> +    if [ -z "$blksz" ]; then
> +	blksz=512
> +    fi
> +    local opt_arg="-ecclength 1 -blocksize $blksz"
>      if [ $# -eq 2 ]; then
> -	opt_arg="-lastvalidblock $(( $2 - 1 ))"
> +	opt_arg+=" -lastvalidblock $(( $2 - 1 ))"
>      fi
>  
>      rm -f $seqres.checkfs

Looks fine - I suppose it's safe to assume the --media-type=hd default
blksz value.
Reviewed-by: David Disseldorp <ddiss@suse.de>
