Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C97C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 13:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbiF2NOh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 09:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbiF2NOf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 09:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7654B2E0AF
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656508472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zd8aFdPlSATqPHRh1X3SShXmkcKaAIDBAR6f8ZRDwoM=;
        b=SYPpGmq1Psed53r/GS/QSKeKZZXH7HG+/mtxZPknpp6axo/z9HtHa5++JV6z+ZIOKpufBD
        HXsX/X+YA1cbvwxSbikAr8apuI9uKOTScFy/bIFds3PbeyDEMNpsTRVrZjYIiTEQSjXQRS
        PkuHIrvKOIjiLNf9kMsCiL/jIENIq7U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-RXzNrW5rNHO7Hyk8WOd4BA-1; Wed, 29 Jun 2022 09:14:31 -0400
X-MC-Unique: RXzNrW5rNHO7Hyk8WOd4BA-1
Received: by mail-qk1-f198.google.com with SMTP id z9-20020a376509000000b006af1048e0caso11909488qkb.17
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 06:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zd8aFdPlSATqPHRh1X3SShXmkcKaAIDBAR6f8ZRDwoM=;
        b=ggyjOscZuJ4EZccujnl1x3l8BO0aDIyDJcxfm88rO0liVQfN9/YBdrRRCnl3aXZ2D5
         ISA491kZzbP8ivBK7P6b7JDhf9VjL4JVGoirnclH9p0LzNzB3AWtLvdMEtIigak/KNQm
         n3bZYHj6BnUbrwkx2F0kA/PXY0jew1BqIwO+UEB+itMGnpOoADS/NruHwgee/V3G7ncN
         KCaXqSyEKTlmd3qsK8izTMTDHXlVktZUcL1ssvh1OJcla7NbU3uhtKeQZs5AnwaYADuD
         qiQS4Cb2Cm7AbWL6QrziCW4TH2fP4KdoVcMz7qnsrTUsLZmRZoIgmrCUnTma/YDce1CM
         qtlg==
X-Gm-Message-State: AJIora9kR+sxc4BQpfA/qkZi958x+Y3gHWfTl8j0731REu/MXdOvkJjS
        KcJuXeq3Rkf7iem9aGMbX0fSDb9gCdTlaN06VZIJCOQ/ya6MUiILppzEV1KrLGRFcjxJe5wCXXp
        gjNRYWb8tKj7mZ5H/wA==
X-Received: by 2002:a05:6214:5d03:b0:470:3bac:9c56 with SMTP id me3-20020a0562145d0300b004703bac9c56mr7740301qvb.86.1656508470475;
        Wed, 29 Jun 2022 06:14:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tTOAFEuCjuSaYfKECV1MYc7IrAGKCXJsWGNYWV1eTV2166fHdNEU2YT+6zydJXshtLXa3KbA==
X-Received: by 2002:a05:6214:5d03:b0:470:3bac:9c56 with SMTP id me3-20020a0562145d0300b004703bac9c56mr7740259qvb.86.1656508469892;
        Wed, 29 Jun 2022 06:14:29 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y17-20020a05620a25d100b006a6a5d1e240sm14545642qko.34.2022.06.29.06.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 06:14:29 -0700 (PDT)
Date:   Wed, 29 Jun 2022 21:14:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH -v3 6/7] ext4/035: skip this test if the scratch device
 does not support 1k block sizes
Message-ID: <20220629131424.2oistash4w67pf2m@zlang-mailbox>
References: <20220629124540.175775-1-tytso@mit.edu>
 <20220629124540.175775-7-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629124540.175775-7-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 29, 2022 at 08:45:39AM -0400, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/ext4/035 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/ext4/035 b/tests/ext4/035
> index cad3595b..1f26e766 100755
> --- a/tests/ext4/035
> +++ b/tests/ext4/035
> @@ -26,6 +26,9 @@ _exclude_scratch_mount_option dax
>  _require_command "$RESIZE2FS_PROG" resize2fs
>  
>  $MKFS_EXT4_PROG -F -b 1024 -E "resize=262144" $SCRATCH_DEV 32768 >> $seqres.full 2>&1
> +if [ $? -ne 0 ]; then
> +    _notrun "Can't make file system with a block size of 1024"
> +fi
>  _scratch_mount
>  
>  echo "Resizing to 262145 blocks"
> -- 
> 2.31.0
> 

