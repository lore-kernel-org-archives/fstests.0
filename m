Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1083C05027
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Jan 2023 14:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjATOlE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Jan 2023 09:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjATOk6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Jan 2023 09:40:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188714DCCA
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2023 06:40:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8901422D8D;
        Fri, 20 Jan 2023 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674225614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LkwAjB7uBopZJhe/DhPFO6xRyaVn47cu7L7RfxypS/w=;
        b=DI4Qh3WAGgS3OnYiO6n1FWGP6SIGqUGrJIOxBfYOAEe680q9EUZgw2eGfXIot+ZORHOUhN
        lE2BHfLpxUSduDHslXc0MFkPt75Nj4YRucpMrEfD+Sr6BjLLXgWtTIp5T6Vnqf6B5z1pqe
        ZFPxVMYcT0fv8D+hiJ4QcdvL4NNAD0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674225614;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LkwAjB7uBopZJhe/DhPFO6xRyaVn47cu7L7RfxypS/w=;
        b=+0dcL1gt2L2ICVvyFhz+sPi+C3WT0cKTPv7Q3flUD6M/V4ZaRdOXnOwPaYlnh/DM75y5dC
        oeW2mZWZ3cdPZgCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C4C11390C;
        Fri, 20 Jan 2023 14:40:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uFPuGM6nymOkZwAAMHmgww
        (envelope-from <ddiss@suse.de>); Fri, 20 Jan 2023 14:40:14 +0000
Date:   Fri, 20 Jan 2023 15:41:23 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Jan Kara <jack@suse.cz>
Cc:     <fstests@vger.kernel.org>
Subject: Re: [PATCH 1/2] common: Provide blocksize and ecclength to udf fsck
Message-ID: <20230120154123.7f59e1cc@echidna.fritz.box>
In-Reply-To: <20230119105410.9236-1-jack@suse.cz>
References: <20230119104618.28701-1-jack@suse.cz>
        <20230119105410.9236-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Jan,

On Thu, 19 Jan 2023 11:54:02 +0100, Jan Kara wrote:

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
> index 8060c03b7d18..de94e5a4cde4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3075,9 +3075,13 @@ _check_udf_filesystem()
>      fi
>  
>      local device=$1
> -    local opt_arg=""
> +    local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`

It looks as though mkudffs also accepts --blocksize= for this, so it
should also be handled here, IIUC.

Looks fine otherwise.

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

