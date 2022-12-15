Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A319C4332F
	for <linux-fstests@archiver.kernel.org>; Thu, 15 Dec 2022 11:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiLOLho (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 15 Dec 2022 06:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiLOLhN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Dec 2022 06:37:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7366B2F671
        for <fstests@vger.kernel.org>; Thu, 15 Dec 2022 03:35:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0617421D5E;
        Thu, 15 Dec 2022 11:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671104124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tfd47DSgBUOyKzTS1lnmB2wa4M1JrOSlf44tLwh6xc4=;
        b=GvLTb1UHMbnhhHW6uuO6HGRN6AZZG1e0pKiSmfpDS5YzfN0CLyHDhIddrJKP6obi7ZatYe
        fPX+J87kxXBcjJE8FfqvUpkPwdXDmi29r78qFRu3PoN3soMvfAXLbnH8u5sIDDhflA3Bkn
        s3AKG5MgR8hmg6nw7yC8OaB0phODTJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671104124;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tfd47DSgBUOyKzTS1lnmB2wa4M1JrOSlf44tLwh6xc4=;
        b=9sbkmdVG8vWAq+r1OAIwd/o+J8DXA/r44Cxxiq+jmruy4bI3/fKKSf7oW9EI+vkX4/esY8
        ntMzMCZKFHdPiWBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7364138E5;
        Thu, 15 Dec 2022 11:35:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9Z4wM3sGm2PJewAAMHmgww
        (envelope-from <ddiss@suse.de>); Thu, 15 Dec 2022 11:35:23 +0000
Date:   Thu, 15 Dec 2022 12:36:15 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH] check: wipe tmp.arglist
Message-ID: <20221215123615.657bcfad@echidna.fritz.box>
In-Reply-To: <20221214215926.908628-1-leah.rumancik@gmail.com>
References: <20221214215926.908628-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Leah,

On Wed, 14 Dec 2022 13:59:26 -0800, Leah Rumancik wrote:

> Make sure tmp.arglist is wiped before each run to avoid
> accidentally rerunning tests.
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
> ---
>  check | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index d2e51296..81a30928 100755
> --- a/check
> +++ b/check
> @@ -46,7 +46,7 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
>  # by default don't output timestamps
>  timestamp=${TIMESTAMP:=false}
>  
> -rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.*
> +rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.* $tmp.arglist
>  
>  SRC_GROUPS="generic shared"
>  export SRC_DIR="tests"

I can't quite see how "accidental rerun" can happen, given that
_summary()/_wrapup() should remove any $tmp.arglist on completion,
and a PID collision for $tmp would also be needed. That said, it still
probably makes sense to be consistent with the other files here, so:

Reviewed-by: David Disseldorp <ddiss@suse.de>
