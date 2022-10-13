Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1E3C43217
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Oct 2022 11:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiJMLvY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Oct 2022 07:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJMLvW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Oct 2022 07:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D279747B81
        for <fstests@vger.kernel.org>; Thu, 13 Oct 2022 04:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665661879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lalvGD/cZNFlrSrybOU5XC3b1fmNe6t6Ggl/pq9x4Tw=;
        b=iTRaAZ9cQqNIlqxf9oDi+zE1GSwR1Z4lw4hTYx4iU5tN310oZDHe/QUJMRKP1GwCysLI2Y
        aS12v2pEwF8Hv0mdO7QQebtHx2QP9GKTQtHCf7uHfXJQGRhEGk8RYMIUrKaD5hRUL41ciQ
        pe1usZhfE0+tR4YfKowP0zVrqD7aj2s=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-147-XkeKcT_yMDaFzvRmCOjATA-1; Thu, 13 Oct 2022 07:51:18 -0400
X-MC-Unique: XkeKcT_yMDaFzvRmCOjATA-1
Received: by mail-ua1-f72.google.com with SMTP id j29-20020a9f309d000000b003e6b2ca5510so750723uab.3
        for <fstests@vger.kernel.org>; Thu, 13 Oct 2022 04:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lalvGD/cZNFlrSrybOU5XC3b1fmNe6t6Ggl/pq9x4Tw=;
        b=lKI/sjsPfkSGBBGHwRv1KsDUTwoEbFstq65JltQbTOp+ZW5gkI/bXyYeMjmD4s1YxC
         8AjvW+3g4CrHNCwyF51wwNjvAaBNDQCX4A8SEAYukRDmqQppWeXD5bm+rP3crgN1lgWY
         +4dMIH41B65vqN2RoUii2oyVaFZvIOgTxC+DptyouqfckrV41mHVqRgC4DM/TAqEVFJa
         Va6St5tOQwgNcF8ykqN0oxLFRujPffl67E+Q7D2c+tLn8aoMu7/srX58mL/gemDIFsyr
         kHm6Sk2AEhykR2iuGy7xRoQAtlXkG5V7m4lE5+JI6tiKZ47nRs2LmAZQFaReO6KKm0bm
         75zQ==
X-Gm-Message-State: ACrzQf0xAc8FnsA8ir0Cqg6abcnjkUhnMIjmavdxxcqCwFYBpM8cHe4v
        oerTUBZaMs9C7Z/gS8qg/Vp7+O33vw0y7KYLEe3JS/IemFI+ZVfSOKScpgPB2hs0Nnd49fK/nH2
        lGEe32yKpaey4Xc7YJw==
X-Received: by 2002:a05:6122:c5b:b0:3ab:6244:cf55 with SMTP id i27-20020a0561220c5b00b003ab6244cf55mr15170790vkr.35.1665661878093;
        Thu, 13 Oct 2022 04:51:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4GZOap/R4r9rcqUgR4clAoxEKQRfA4NGb7zvStk+6PHB3zWgW2Kg2yRsM5Z0C2vE086orPyg==
X-Received: by 2002:a05:6a00:a8c:b0:558:991a:6691 with SMTP id b12-20020a056a000a8c00b00558991a6691mr35855939pfl.53.1665661866921;
        Thu, 13 Oct 2022 04:51:06 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b00177f32b1a32sm12284751pls.271.2022.10.13.04.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 04:51:06 -0700 (PDT)
Date:   Thu, 13 Oct 2022 19:51:02 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] check: optionally compress core dumps
Message-ID: <20221013115102.qb7r37ywdy2qbwkn@zlang-mailbox>
References: <166553910766.422356.8069826206437666467.stgit@magnolia>
 <166553911893.422356.7143540040827489080.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166553911893.422356.7143540040827489080.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Oct 11, 2022 at 06:45:18PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a new option, COREDUMP_COMPRESSOR, that will be used to compress
> core dumps collected during a fstests run.  The program specified must
> accept the -f -9 arguments that gzip has.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  README    |    4 ++++
>  common/rc |   14 +++++++++-----
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> 
> diff --git a/README b/README
> index 80d148be82..4c4f22f853 100644
> --- a/README
> +++ b/README
> @@ -212,6 +212,10 @@ Tools specification:
>      - Set FSSTRESS_AVOID and/or FSX_AVOID, which contain options added to
>        the end of fsstresss and fsx invocations, respectively, in case you wish
>        to exclude certain operational modes from these tests.
> + - core dumps:
> +    - Set COREDUMP_COMPRESSOR to a compression program to compress crash dumps.
> +      This program must accept '-f' and the name of a file to compress.  In
> +      other words, it must emulate gzip.
>  
>  Kernel/Modules related configuration:
>   - Set TEST_FS_MODULE_RELOAD=1 to unload the module and reload it between
> diff --git a/common/rc b/common/rc
> index 152b8bb414..c68869b7dc 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4956,13 +4956,17 @@ _save_coredump()
>  	local core_hash="$(_md5_checksum "$path")"
>  	local out_file="$RESULT_BASE/$seqnum.core.$core_hash"
>  
> -	if [ -s "$out_file" ]; then
> -		rm -f "$path"
> -		return
> -	fi
> -	rm -f "$out_file"
> +	for dump in "$out_file"*; do
> +		if [ -s "$dump" ]; then
> +			rm -f "$path"
> +			return 0
> +		fi
> +	done
>  
>  	mv "$path" "$out_file"
> +	test -z "$COREDUMP_COMPRESSOR" && return 0
> +
> +	$COREDUMP_COMPRESSOR -f "$out_file"

This patch looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

I'm just not sure if all/most compressor supports "-f" option, I use bzip2
and gzip mostly, they both support that.

Thanks,
Zorro

>  }
>  
>  init_rc
> 

