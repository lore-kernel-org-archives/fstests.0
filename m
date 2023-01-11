Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BD4C46467
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Jan 2023 12:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjAKMRd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 Jan 2023 07:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjAKMRb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Jan 2023 07:17:31 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BC3C23
        for <fstests@vger.kernel.org>; Wed, 11 Jan 2023 04:17:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C9C1177B2;
        Wed, 11 Jan 2023 12:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1673439449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=idIsSYt0Hxc8YzEmgHr7YqIs3rVTq1+I/Fa3L+pw3jw=;
        b=DlMCKrv5czHnxOyLXH+DLeBTn3z29D3tscNdV2QOWD/2H+wBpajTQEij3x5MfNRzyOjxRw
        eoVtramnRXIooMGa5nlQ2ovDYnLHOUQZ23eQR0o7MQbepdW/pVP6Gu9d7KXoddYBhhKOhi
        kjP5Vt6nGyU4nqGZ/D/PmZy71tFIL2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1673439449;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=idIsSYt0Hxc8YzEmgHr7YqIs3rVTq1+I/Fa3L+pw3jw=;
        b=vKX52G3OuCkzt+1V0HGm3HuXU3DtqAxtu01l3EF66/Lxo57Y3DHtV7IPFTdUKdG5JcEwW3
        7qRZAI700ToRvUCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D86D13591;
        Wed, 11 Jan 2023 12:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YEO6AdmovmP1QwAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 11 Jan 2023 12:17:29 +0000
Date:   Wed, 11 Jan 2023 13:18:33 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     An Long <lan@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] btrfs/011: use $_btrfs_profile_configs to limit the
 tests
Message-ID: <20230111131833.471ada43@echidna.fritz.box>
In-Reply-To: <20230110172221.24710-1-lan@suse.com>
References: <20230110172221.24710-1-lan@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

On Wed, 11 Jan 2023 01:22:21 +0800, An Long wrote:

> Generally the tester need BTRFS_PROFILE_CONFIGS to test certain
> profiles. For example, skip raid56 as it's not supported.
> 
> Signed-off-by: An Long <lan@suse.com>
> ---
>  tests/btrfs/011 | 48 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 6c3d037f..b9d175d1 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -22,6 +22,8 @@
>  . ./common/preamble
>  _begin_fstest auto replace volume
>  
> +_btrfs_get_profile_configs
...
> +	if [[ "${_btrfs_profile_configs[@]}" =~ "-m raid1 -d raid1" ]]; then
> +		workout "-m raid1 -d raid1" 2 no 2048
> +	fi

These regexes aren't anchored, so above could match "-m raid1 -d raid10"
- not a problem given current profiles, but still not ideal.

My preference would be to use a loop for filtering workout parameters
against _btrfs_profile_configs, e.g.

for i in "-m single -d single:1 no 64" \
	 "-m dup -d single:1 no 64" \
	 "-m dup -d single:1 cancel 1024" \
	 ...; do
	# confirm "${i%:*}" is in _btrfs_profile_configs...
	workout "${i%:*}" ${i#*:}
done

Cheers, David
