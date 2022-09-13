Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294FCC6FA82
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Sep 2022 12:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbiIMM3o (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Sep 2022 08:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiIMM3X (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Sep 2022 08:29:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AB061D60
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 05:28:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 030721F8C6;
        Tue, 13 Sep 2022 12:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663072061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3X8EbHHh6pCsdmo5AIn8U/eEThZtbYvDt66iCLHfSEY=;
        b=IVFnE80Yxx7TGixnFfP3B7/JofbZcD99Ch5CVDJ+1D/IsiJN/4znqSqZ2DuDg/vVdBPNUv
        cVGBIhhnGp98Xp2qXSLx5iQ5Khu/T4/lANNHPGnjlAYHAKyS72mkiBg4QDsSlgVQZ/JaRU
        DIDr8gwnEt9oHsaNMkdY3qCGRgoihvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663072061;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3X8EbHHh6pCsdmo5AIn8U/eEThZtbYvDt66iCLHfSEY=;
        b=5feii5Kn3jJakksWIUG4oA7dCjXdc3YfLFdDrwwliKvTe/dzGVfmLltrPT/eDl6n8C5JLM
        GV2rXY/441gqq8BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBF9313AB5;
        Tue, 13 Sep 2022 12:27:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xflBNDx3IGOAAQAAMHmgww
        (envelope-from <ddiss@suse.de>); Tue, 13 Sep 2022 12:27:40 +0000
Date:   Tue, 13 Sep 2022 14:27:51 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: replace obsolescent egrep and fgrep
Message-ID: <20220913142751.2d4026d9@echidna.suse.de>
In-Reply-To: <20220913093345.84370-1-zlang@kernel.org>
References: <20220913093345.84370-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, 13 Sep 2022 17:33:45 +0800, Zorro Lang wrote:

> Due to the change in grep project:
>   a95156247098 ("egrep, fgrep: now obsolete")
> 
> some tests start to fail on latest Fedora system with grep-3.8-1.fc38
> or newer version, as:
> 
>   generic/447 70s ... egrep: warning: egrep is obsolescent; using grep -E
>   ...
>       @@ -1,4 +1,5 @@
>        QA output created by 447
>       +egrep: warning: egrep is obsolescent; using grep -E
>       ...
> 
> So use grep -E and -F to instead of egrep and fgrep commands.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
>  common/rc | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index a25cbcd0..dee3965e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -30,6 +30,17 @@ dd()
>  	fi
>  }
>  
> +# The egrep and fgrep are obsolescent
> +egrep()
> +{
> +	grep -E "$@"
> +}
> +
> +fgrep()
> +{
> +	grep -F "$@"
> +}
> +
>  # Prints the md5 checksum of a given file
>  _md5_checksum()
>  {

Nit: AFAICT there's only one fgrep caller, so just change that single
case. With that fixed:

Reviewed-by: David Disseldorp <ddiss@suse.de>
