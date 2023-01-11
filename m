Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446EEC46467
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Jan 2023 10:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjAKKAF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 Jan 2023 05:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjAKJ7j (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Jan 2023 04:59:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44072193EE
        for <fstests@vger.kernel.org>; Wed, 11 Jan 2023 01:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673430976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fCqtpaxQt53nHswaEL2SHmpHivHPHqsA6MI0eluOxws=;
        b=Ugk7mFYrwURjrhh0hRdV1brLjs2ZBH3jSP+KVw7sK2tOIYt0KpmGDVGQgs6SMNLrDAS07H
        bkstid0vEJjPM0X0UXCqBSTgRbbif0+rcUBrX74dNmbWCxsPGeU0BThWdtsZ4Z9u7xbkZi
        mZvQfPC3wNttaa+atWsi4Yqg9touNa8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-47-vyEwSdU5PkiECNYEnLhsdQ-1; Wed, 11 Jan 2023 04:56:14 -0500
X-MC-Unique: vyEwSdU5PkiECNYEnLhsdQ-1
Received: by mail-pj1-f72.google.com with SMTP id 31-20020a17090a0fa200b00226e43409c2so6193157pjz.9
        for <fstests@vger.kernel.org>; Wed, 11 Jan 2023 01:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCqtpaxQt53nHswaEL2SHmpHivHPHqsA6MI0eluOxws=;
        b=eHUsWolt6iOFcBIZoOMOXfdiv/l4eG1xDkw4P/uqRES6aktN9qu9wQOlRpunlxnqmN
         q+40TFHWPQFzVAUKxFj6EdLSYrlor38ISfg6yb/mXRyjF0PT9BZWgQAOUkKlkLt1WO0O
         rD6Hth3jEeHQGWj6zWn3YX14DcpD9Z1lZi+X63zhPLZY3N5vgxi3C0HtrJjBE2I45fWM
         d09DiXTVBgq7kZUBmMGHTezcuc388xzll8RAGSPYoqlICvO6tvXAbi6heuhoBXyFtHvN
         +BLqgedTQUgFAGpS9qpOiNxVRGooRpzs7leuAqBY8mX27kKpVBf0ewb7KQUTTAJVnnuM
         tiyQ==
X-Gm-Message-State: AFqh2kpnM2Bp6SIoRH/q09hoKSj8OnUvynElLyF24kkrYtDwVuz4PAC2
        gCDAf0HmuSYjL/Pymq4n35HRhG1VK3s0snrYk25Q4CEP9kzcqoGgAkuSvQube374sPBPrb6pnsA
        65l6DjOMvMm0U6aO2Xg==
X-Received: by 2002:a05:6a20:499d:b0:af:767a:a7e1 with SMTP id fs29-20020a056a20499d00b000af767aa7e1mr1804987pzb.23.1673430973569;
        Wed, 11 Jan 2023 01:56:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtVqFMMx6ShhD2cEKl+VLLoqc9fnjcxI49YUnRCIh0vXSJMM84F9l0MqdrpQe3kY2wQJaL/xw==
X-Received: by 2002:a05:6a20:499d:b0:af:767a:a7e1 with SMTP id fs29-20020a056a20499d00b000af767aa7e1mr1804974pzb.23.1673430973207;
        Wed, 11 Jan 2023 01:56:13 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jg7-20020a17090326c700b0019324fbec59sm7425393plb.41.2023.01.11.01.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 01:56:12 -0800 (PST)
Date:   Wed, 11 Jan 2023 17:56:09 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: drop SGI DMF specific _mount_ops_filter
Message-ID: <20230111095609.xca2wmkgsdxaiwqt@zlang-mailbox>
References: <20230110222243.6522-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110222243.6522-1-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jan 10, 2023 at 11:22:43PM +0100, David Disseldorp wrote:
> The _mount() helper function is the only caller of _mount_ops_filter(),
> which appears to have been used in the past to replace the SGI DMF
> specific mtpt= mount option setting.
> 
> _mount() invocations could now be replaced with $MOUNT_PROG calls
> directly, but I've retained the helper function for readability.
> 
> Link: https://irix7.com/techpubs/007-3683-007.pdf
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---

This makes sense to me. Likes we've removed dmapi things, this "-o mtpt"
support can be removed too.

The _mount_ops_filter() might can be brought back if we need a filter
for _mount() in one day, I think that's another story. Now let's remove
it if it's useless.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 23530413..81ce1026 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -120,7 +120,7 @@ _get_hugepagesize()
>  
>  _mount()
>  {
> -    $MOUNT_PROG `_mount_ops_filter $*`
> +    $MOUNT_PROG $*
>  }
>  
>  # Call _mount to do mount operation but also save mountpoint to
> @@ -211,19 +211,6 @@ _test_options()
>  	TEST_OPTIONS="$TEST_OPTIONS ${log_opt}logdev=$TEST_LOGDEV"
>  }
>  
> -_mount_ops_filter()
> -{
> -    local params="$*"
> -    local last_index=$(( $# - 1 ))
> -
> -    [ $last_index -gt 0 ] && shift $last_index
> -    local fs_escaped=$1
> -
> -    echo $params | \
> -        $PERL_PROG -ne "s#mtpt=[^,|^\n|^\s]*#mtpt=$fs_escaped\1\2#; print;"
> -
> -}
> -
>  # Used for mounting non-scratch devices (e.g. loop, dm constructs)
>  # with the safe set of scratch mount options (e.g. loop image may be
>  # hosted on $SCRATCH_DEV, so can't use external scratch devices).
> -- 
> 2.35.3
> 

