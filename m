Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB18C27C7C
	for <linux-fstests@archiver.kernel.org>; Fri, 20 Jan 2023 14:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjATOnS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 20 Jan 2023 09:43:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjATOnQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 20 Jan 2023 09:43:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63BB80B90
        for <fstests@vger.kernel.org>; Fri, 20 Jan 2023 06:42:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 232E75FA94;
        Fri, 20 Jan 2023 14:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674225699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oV3XlD+IMKfbxqB4i9tKCACOVQQUDToIR48Jj4PI/kc=;
        b=zqddzvTGjdrAY0KU1mUIi3QjNImR/wEXFMGPgDHwhy/zGNubgLXZDl13nhcm0nHk0NYlby
        Mt/jfalPOb0NQ7mfXWAVJIps9/aLzDiQTbH0viU2QNHORKo28tbx/C18jJxmtx7tLmQUYo
        pSKjEZ0oSqahrWFkWcdEFUxwfCMkSnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674225699;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oV3XlD+IMKfbxqB4i9tKCACOVQQUDToIR48Jj4PI/kc=;
        b=U58YfPPkOrbkte7MSRbhzoArczV7//nSIP7WgQGvc0U03+zA3dv126pKvWEp7F3gVaMlgo
        ABYiE1kZcuhoVcBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06F921390C;
        Fri, 20 Jan 2023 14:41:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1nE/ACOoymORaAAAMHmgww
        (envelope-from <ddiss@suse.de>); Fri, 20 Jan 2023 14:41:39 +0000
Date:   Fri, 20 Jan 2023 15:42:48 +0100
From:   David Disseldorp <ddiss@suse.de>
To:     Jan Kara <jack@suse.cz>
Cc:     <fstests@vger.kernel.org>
Subject: Re: [PATCH 2/2] common: Unmount udf filesystem prior checking
Message-ID: <20230120154248.0f5aee8b@echidna.fritz.box>
In-Reply-To: <20230119105410.9236-2-jack@suse.cz>
References: <20230119104618.28701-1-jack@suse.cz>
        <20230119105410.9236-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, 19 Jan 2023 11:54:03 +0100, Jan Kara wrote:

> _check_udf_filesystem forgot to unmount the filesystem prior to checking
> it. That was leading to check failures.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  common/rc | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index de94e5a4cde4..df6f237cabaa 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3074,6 +3074,12 @@ _check_udf_filesystem()
>  	return
>      fi
>  
> +    # Is the filesystem mounted?
> +    local type=`_fs_type $device`
> +    if [ "$type" = "$FSTYP" ]; then
> +	local mountpoint=`_umount_or_remount_ro $device`
> +    fi
> +
>      local device=$1
>      local blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
>      if [ -z "$blksz" ]; then
> @@ -3090,6 +3096,10 @@ _check_udf_filesystem()
>  	_udf_test_known_error_filter | \
>  	grep -E -iv "Error count:.*[0-9]+.*total occurrences:.*[0-9]+|Warning count:.*[0-9]+.*total occurrences:.*[0-9]+" && \
>          echo "Warning UDF Verifier reported errors see $seqres.checkfs." && return 1
> +    # Remount the filesystem
> +    if [ "$type" = "$FSTYP" ]; then
> +	_mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint
> +    fi
>      return 0
>  }
>  

Looks fine.
Reviewed-by: David Disseldorp <ddiss@suse.de>
