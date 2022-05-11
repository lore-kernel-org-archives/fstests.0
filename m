Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D8DC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 11 May 2022 08:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243642AbiEKI1H (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 May 2022 04:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243651AbiEKI1F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 May 2022 04:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2D52541A2
        for <fstests@vger.kernel.org>; Wed, 11 May 2022 01:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652257621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cql7hWPMpwkxr2WZ63RnHCoEyq5kNLOgvXpNPmzbk1w=;
        b=Fyb40Bn3McQMkLUxY9arjdJFBf0w9XSQ/qVPDh6b1Pxqs4RlG5MKoP5AKJyS8q1v1/C6Vt
        14H0xAOw3/8v5hKLXUqSu5GKiQPktSaPIkDljKypsktDIh2odZoNsXlW9iZFilyUCweHUm
        46HP3yuwKHPI/ORd1VD3OJBKjM2m2TA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-uUAJ_SBVNFmDrRLw2nkpqQ-1; Wed, 11 May 2022 04:27:00 -0400
X-MC-Unique: uUAJ_SBVNFmDrRLw2nkpqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21267800882;
        Wed, 11 May 2022 08:27:00 +0000 (UTC)
Received: from fedora (unknown [10.40.194.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 717591460E2C;
        Wed, 11 May 2022 08:26:59 +0000 (UTC)
Date:   Wed, 11 May 2022 10:26:57 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] ext4: reject the 'commit' option on ext2 filesystems
Message-ID: <20220511082657.paviz6qq5aj7i7ti@fedora>
References: <20220510183232.172615-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510183232.172615-1-ebiggers@kernel.org>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 10, 2022 at 11:32:32AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The 'commit' option is only applicable for ext3 and ext4 filesystems,
> and has never been accepted by the ext2 filesystem driver, so the ext4
> driver shouldn't allow it on ext2 filesystems.
> 
> This fixes a failure in xfstest ext4/053.
> 
> Fixes: 8dc0aa8cf0f7 ("ext4: check incompatible mount options while mounting ext2/3")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Good catch, thanks.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> ---
>  fs/ext4/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 1847b46af8083..69d67724df24f 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1913,6 +1913,7 @@ static const struct mount_opts {
>  	 MOPT_EXT4_ONLY | MOPT_CLEAR},
>  	{Opt_warn_on_error, EXT4_MOUNT_WARN_ON_ERROR, MOPT_SET},
>  	{Opt_nowarn_on_error, EXT4_MOUNT_WARN_ON_ERROR, MOPT_CLEAR},
> +	{Opt_commit, 0, MOPT_NO_EXT2},
>  	{Opt_nojournal_checksum, EXT4_MOUNT_JOURNAL_CHECKSUM,
>  	 MOPT_EXT4_ONLY | MOPT_CLEAR},
>  	{Opt_journal_checksum, EXT4_MOUNT_JOURNAL_CHECKSUM,
> 
> base-commit: 23e3d7f7061f8682c751c46512718f47580ad8f0
> -- 
> 2.36.1
> 

