Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEA1C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Oct 2022 14:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJMOz1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Oct 2022 10:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJMOzZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Oct 2022 10:55:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8618AC48B
        for <fstests@vger.kernel.org>; Thu, 13 Oct 2022 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665672923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qWUmYZh4xYf2XMKoXQm+CFqb+G2yigbGg+qhtVxZcdI=;
        b=aD4ASYGkaAPr+xAmeJ3EYEupPu35vIfMK21Op7lB/QeKT1PgWN/kuvvWvJm1GFmFOhSyWC
        ODLmKE7UQ6cOQ25qf2sqJk3jtmM6kpzBOuOGyylffu+/HGiMRZ/0dqsUNQTgQc9/VXCUsg
        u4lou3WJCW2n9f4FjEKMZVYBiDTBvCU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-246-vkQz7pCnMAuhkc_5DpkumA-1; Thu, 13 Oct 2022 10:55:21 -0400
X-MC-Unique: vkQz7pCnMAuhkc_5DpkumA-1
Received: by mail-qt1-f197.google.com with SMTP id gd8-20020a05622a5c0800b0039cb77202eeso1447284qtb.0
        for <fstests@vger.kernel.org>; Thu, 13 Oct 2022 07:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWUmYZh4xYf2XMKoXQm+CFqb+G2yigbGg+qhtVxZcdI=;
        b=50YXui4immus92Kk8VIepbd4COIIwLB12KVvcjCJoxiGGR06ASDU36D0xaeKnWURsO
         QJnznNgyOFWJeR7p8doCMkLF2rhTHlj/lolSDxdWhARKz6bgLmxwI21qgig15YA2IIxx
         U8yN3eWdkoaLo5gORy/UwQ8IrHWT8Hno3xYRqBIgz2hI/eCFtDiuONzPHow4njwLaIaC
         ydeWdLfIcip0NWnTUj8bc2I1ZMsAoC4b/I42NwGE7FvlQlIMqEggRVQ3ByEfcDbeSmT/
         Bi9yJ0qPK+hCUoi8FKL4YXI8ExH+peLVKJjdMyjtFVuUYykJfCkVpVjQJNIuZ1XalB8Z
         7/yQ==
X-Gm-Message-State: ACrzQf0n7WLIxbJY3Q4JGxCddiSq8pKYtY0LGXz0h0pIRRHXojSN5NKm
        cy15x51DUkApBQkdfoXl8ipfGzKxxZKfPLRcr2QnVCkPICO8lIqLEntXtu53QC8ORfE7ixk43pZ
        XZ0xNmY4qQwrjhgGZSQ==
X-Received: by 2002:a05:620a:244d:b0:6ee:7a23:dfa6 with SMTP id h13-20020a05620a244d00b006ee7a23dfa6mr201940qkn.463.1665672920755;
        Thu, 13 Oct 2022 07:55:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5ir6m2yoz+N0yyWHfzNwH0C4fGM0YB8nV7wQImXPL0mtWxZxrvVMr4r7y03MQSm9Vz+m0F2A==
X-Received: by 2002:a05:620a:244d:b0:6ee:7a23:dfa6 with SMTP id h13-20020a05620a244d00b006ee7a23dfa6mr201932qkn.463.1665672920534;
        Thu, 13 Oct 2022 07:55:20 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t12-20020a37aa0c000000b006eeb25369e9sm2648279qke.25.2022.10.13.07.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 07:55:20 -0700 (PDT)
Date:   Thu, 13 Oct 2022 22:55:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/5] populate: export the metadump description name
Message-ID: <20221013145515.2vx3xy6hnf37777o@zlang-mailbox>
References: <166553912229.422450.15473762183660906876.stgit@magnolia>
 <166553912788.422450.6797363004980943410.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166553912788.422450.6797363004980943410.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 11, 2022 at 06:45:27PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Not sure why this hasn't been broken all along, but we should be
> exporting this variable so that it shows up in subshells....

May I ask where's the subshell which uses $POPULATE_METADUMP?

> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  common/populate |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/common/populate b/common/populate
> index cfdaf766f0..b501c2fe45 100644
> --- a/common/populate
> +++ b/common/populate
> @@ -868,9 +868,9 @@ _scratch_populate_cached() {
>  	local meta_tag="$(echo "${meta_descr}" | md5sum - | cut -d ' ' -f 1)"
>  	local metadump_stem="${TEST_DIR}/__populate.${FSTYP}.${meta_tag}"
>  
> -	# These variables are shared outside this function
> -	POPULATE_METADUMP="${metadump_stem}.metadump"
> -	POPULATE_METADUMP_DESCR="${metadump_stem}.txt"
> +	# This variable is shared outside this function
> +	export POPULATE_METADUMP="${metadump_stem}.metadump"
> +	local POPULATE_METADUMP_DESCR="${metadump_stem}.txt"

If the POPULATE_METADUMP_DESCR is not shared outside anymore, how about change
it to lower-case?

>  
>  	# Don't keep metadata images cached for more 48 hours...
>  	rm -rf "$(find "${POPULATE_METADUMP}" -mtime +2 2>/dev/null)"
> 

