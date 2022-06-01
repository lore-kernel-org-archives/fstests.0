Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C140AC433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jun 2022 07:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350424AbiFAHu7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 03:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350446AbiFAHuB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 03:50:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC8A9CC8E
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 00:50:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0D6E11F8E1;
        Wed,  1 Jun 2022 07:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654069799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zw4qQVegx04UGsLy1HMjUyQbn7wVn2U3UoZOOTHmJew=;
        b=PkZYU196kOV1IsQ+/2zTm+bnLUs7jz7hCXB2AKGJrx/YjSVNlwU+c3LdrulBJJMpy+ujGf
        ZvAJnWN0PfXHTl+IWac4ilJD7hcke/xFSNi9UgItC7HdAKpBqr0oyvWsBKysYOuRv5XP1q
        GgWuvujQwI/yU0gCfwmS6ZQt3Y2aOcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654069799;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zw4qQVegx04UGsLy1HMjUyQbn7wVn2U3UoZOOTHmJew=;
        b=zh1VjcnxuJ9E+XtqBYhTBz6bx8QDqtUa1L3bUIWQFAQKWDjWu+JU9D7V4f1Cw8gBA919Gi
        0Z5B/BpeAuBus8Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3BC913A8F;
        Wed,  1 Jun 2022 07:49:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KkglNiYal2IlPwAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 01 Jun 2022 07:49:58 +0000
Date:   Wed, 1 Jun 2022 09:49:57 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Liu Yiding <liuyd.fnst@fujitsu.com>
Cc:     <fstests@vger.kernel.org>
Subject: Re: [PATCH] common/rc: Fix _require_batched_discard to skip test
 correctly
Message-ID: <20220601094957.02d94400@suse.de>
In-Reply-To: <20220531071252.30517-1-liuyd.fnst@fujitsu.com>
References: <20220531071252.30517-1-liuyd.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, 31 May 2022 15:12:52 +0800, Liu Yiding wrote:

> xfstest commit ee264b3f ("common/rc: Modify _require_batched_discard to
> improve test coverage") changed the way of determing if discard is
> supported by checking whether fstrim output contains "not supported"
> keywords.
> 
> On RHEL, fstrim output below info when discard is not supported
> "fstrim: /mnt/share0/: FITRIM ioctl failed: Function not implemented"
> 
> Supplyment unsupported keywords to _require_batched_discard.
> 
> Signed-off-by: Liu Yiding <liuyd.fnst@fujitsu.com>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 70a15f9c..eae9afc6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4008,7 +4008,7 @@ _require_batched_discard()
>  	fi
>  	_require_fstrim
>  
> -	grep -q "not supported" <($FSTRIM_PROG $1 2>&1)
> +	grep -q -E "not supported|not implemented" <($FSTRIM_PROG $1 2>&1)
>  	if [ "$?" = "0" ]
>  	then
>  		_notrun "FITRIM not supported on $1"

Looks fine.
Reviewed-by: David Disseldorp <ddiss@suse.de>
