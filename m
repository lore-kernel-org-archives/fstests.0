Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF65C4708C
	for <linux-fstests@archiver.kernel.org>; Mon,  5 Dec 2022 23:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLEXgN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 5 Dec 2022 18:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbiLEXfH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Dec 2022 18:35:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E475A20197
        for <fstests@vger.kernel.org>; Mon,  5 Dec 2022 15:34:55 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5DD8C1FDC1;
        Mon,  5 Dec 2022 23:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1670283294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rGzHp5avc4pkNygT0hkozMmHcEIIS8RyjQ57fxCJi5U=;
        b=xW0Cg1+wOt2XV4i9Ja39/G72l6gXbmFDvq1+SD+myNQTSVuSw4C1PlOXzkcvvzfVguhIZ3
        zSfb+3kWAaC7XXSjE2098AoLp/Cr9hKqfByNOcTIm0MsEO0Ch+O7CO9rtZzS0cHryxsz6b
        EPU4asq7N+AT31/Po72AIbWEu1/W7L8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1670283294;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rGzHp5avc4pkNygT0hkozMmHcEIIS8RyjQ57fxCJi5U=;
        b=rhl01OiY4gMiK1XMTCNbbKr6SRfKjk/HeAi27Tmgz7rAJTVDTQ1rdeLfAgPJR+/fMABdp+
        qXVxKpkgiavFlBAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 403471348F;
        Mon,  5 Dec 2022 23:34:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id gTgzDh6AjmNyEwAAGKfGzw
        (envelope-from <ddiss@suse.de>); Mon, 05 Dec 2022 23:34:54 +0000
Date:   Tue, 6 Dec 2022 00:35:42 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Jan Kara <jack@suse.cz>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/044: Fix failure when mount options are
 incompatible with ext3
Message-ID: <20221206003542.50227091@echidna.fritz.box>
In-Reply-To: <20221205124144.23770-1-jack@suse.cz>
References: <20221205124144.23770-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi Jan,

On Mon,  5 Dec 2022 13:41:44 +0100, Jan Kara wrote:

> There are some mount options that are incompatible with ext3 filesystem
> type. If they are used, this test fails because it tries to remount the
> filesystem as ext3. The test makes sense even without remounting as ext3
> so just make the test silently skip the remount.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  tests/ext4/044 | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/ext4/044 b/tests/ext4/044
> index 50de5a40bdc7..96fa70cc0d1e 100755
> --- a/tests/ext4/044
> +++ b/tests/ext4/044
> @@ -53,9 +53,10 @@ _within_tolerance "sec_ctime" $sec_ctime $sec 1 -v
>  
>  _scratch_unmount >> $seqres.full 2>&1
>  
> -# Test mount to ext3 then mount back to ext4 and check timestamp again
> -_mount -t ext3 `_scratch_mount_options $*` || _fail "ext3 mount failed"
> -_scratch_unmount >> $seqres.full 2>&1
> +# Test mount to ext3 then mount back to ext4 and check timestamp again.  We
> +# ignore if ext3 failed to mount. It can happen because some mount options are
> +# incompatible with ext3. Still the test makes sense.
> +_mount -t ext3 `_scratch_mount_options $*` >> $seqres.full 2>&1 && _scratch_unmount >> $seqres.full 2>&1
>  _scratch_mount

I suppose this makes sense compared to filtering or dropping all mount
options. $* should always be empty here, right?

Looks fine otherwise...
Reviewed-by: David Disseldorp <ddiss@suse.de>
