Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B80C05027
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Jan 2023 11:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjATLtg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Jan 2023 06:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjATLtU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Jan 2023 06:49:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A64BD17E
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2023 03:48:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B2E922C38;
        Fri, 20 Jan 2023 11:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674215310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ps6uT8UXAOkvyI3EQlFiP60OVVYhXDbLvky04xODM00=;
        b=0+8BzEsTH5vb4T5ZZv+FKoerU/IGkISeU5lpPJboGPyIWHOO9YjehFw3psZvBXZgtPiJzX
        xvdgLnz0g+dfUJ5i4kSUilOdQLAtGqwkleYhZsV5m9nnUuBc6KoIjUDIp+mf9zpoS2scjB
        eRWPfscB2t26Zb0SXbY8aK8xg3Gn1N0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674215310;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ps6uT8UXAOkvyI3EQlFiP60OVVYhXDbLvky04xODM00=;
        b=p65cFZE1hAVUoozFBjrniast9ZXxVwCf7cL9+V14+tteR+7Kel/MfYyIXRIFwvcXQko3e7
        Z5qHoWqFWdiOrVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EB001390C;
        Fri, 20 Jan 2023 11:48:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b/PKFY5/ymN8AgAAMHmgww
        (envelope-from <ddiss@suse.de>); Fri, 20 Jan 2023 11:48:30 +0000
Date:   Fri, 20 Jan 2023 12:49:39 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     An Long <lan@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v4] btrfs/011: use $_btrfs_profile_configs to limit the
 tests
Message-ID: <20230120124939.6441a073@echidna.fritz.box>
In-Reply-To: <20230114031909.8294-1-lan@suse.com>
References: <20230111131833.471ada43@echidna.fritz.box>
        <20230114031909.8294-1-lan@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi,

On Sat, 14 Jan 2023 11:19:09 +0800, An Long wrote:

> Generally the tester need BTRFS_PROFILE_CONFIGS to test certain
> profiles. For example, skip raid56 as it's not supported.
> 
> Signed-off-by: An Long <lan@suse.com>
> ---
>  tests/btrfs/011 | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 6c3d037f..ac45e735 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -48,6 +48,7 @@ _require_scratch_dev_pool 5
>  _require_scratch_dev_pool_equal_size
>  _require_scratch_size $((10 * 1024 * 1024)) #kB
>  _require_command "$WIPEFS_PROG" wipefs
> +_btrfs_get_profile_configs
>  
>  rm -f $tmp.*
>  
> @@ -237,18 +238,27 @@ btrfs_replace_test()
>  	fi
>  }
>  
> -workout "-m single -d single" 1 no 64
> +if [[ "${_btrfs_profile_configs[@]}" =~ "-m single -d single"( |$) ]]; then
> +	workout "-m single -d single" 1 no 64
> +fi
> +
>  # Mixed BG & RAID/DUP profiles are not supported on zoned btrfs
>  if ! _scratch_btrfs_is_zoned; then
> -	workout "-m dup -d single" 1 no 64
> -	workout "-m dup -d single" 1 cancel 1024
> -	workout "-m raid0 -d raid0" 2 no 64
> -	workout "-m raid1 -d raid1" 2 no 2048
> -	workout "-m raid10 -d raid10" 4 no 64
> -	workout "-m single -d single -M" 1 no 64
> -	workout "-m dup -d dup -M" 1 no 64
> -	workout "-m raid5 -d raid5" 2 no 64
> -	workout "-m raid6 -d raid6" 3 no 64
> +	for t in "-m dup -d single:1 no 64" \
> +		"-m dup -d single:1 cancel 1024" \
> +		"-m raid0 -d raid0:2 no 64" \
> +		"-m raid1 -d raid1:2 no 2048" \
> +		"-m raid10 -d raid10:4 no 64" \
> +		"-m single -d single -M:1 no 64" \
> +		"-m dup -d dup -M:1 no 64" \

This dup/dup case no longer gets run with a default
_btrfs_profile_configs[]. Is that intentional?

Cheers, David
