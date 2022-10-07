Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFCBC433FE
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Oct 2022 12:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJGMpf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Oct 2022 08:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiJGMpe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Oct 2022 08:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B727B291
        for <fstests@vger.kernel.org>; Fri,  7 Oct 2022 05:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665146732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GLr7Gt2dC4Ir7s09uhTfCpNPvoL4bioMe30SOVPG5bw=;
        b=J6bAto7Rf+oveK5k/tBcuVFuopENrLe7VU+MjTpqSPQwdbBrwWmXqO4cMwZl7KLdGYgVX+
        aVOsnPAobyNwqYN9tGb58oWzEbR9yla+lHY93fxlypoHMl5AkPdB1PjI9tYgU+mrNH3VNu
        nKVLt8qYwZfGBEv3g5dXGU1Zg0OUYCw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-317-PmIDLmynOdicJstA6b9Qzw-1; Fri, 07 Oct 2022 08:45:31 -0400
X-MC-Unique: PmIDLmynOdicJstA6b9Qzw-1
Received: by mail-qt1-f200.google.com with SMTP id ew15-20020a05622a514f00b0035cb76e35e5so2938095qtb.7
        for <fstests@vger.kernel.org>; Fri, 07 Oct 2022 05:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLr7Gt2dC4Ir7s09uhTfCpNPvoL4bioMe30SOVPG5bw=;
        b=AtYi1vdaShBHVBdVcH2kX7csw2qcbHwvmc8B7tOduCrO5O6OlRFZwEGbexcV4op0iv
         c6JMl6Te5hAJhs/rBaf0FjsHPfYyiLzsS7b82CjK+EY4hPeXmroH/VmNF6/+NkIJksm4
         sf60OqIU3ZJ7GAiDba+9nJvsrRSaqxPp1ivxAlfoVcG+d9GY01WxGJS7GRxY2iChltaf
         Pdc5LyF3IERLX9OqviUoW/W2GA2HGLzAE4jYDorbl0S278gEi1Dsedm3a6Wz4aERCmmZ
         OAt75pwD6MVQCaVa/RP4V/0gzgTqkhvuDcdQMXgi4UHZfcVSgjeKLEjXhCqdzc5lyyWC
         wc1A==
X-Gm-Message-State: ACrzQf1V42KPf/tj5KbRzCauhWSPMyE9uhdiSjb/Fuc/f5sQtYyvZyPS
        dRHLD8vVAb/iONBQMYFyPakTG9sHYotWg96CkizyLubZWZui6ekUoA7SN/ng6/kHA8Br47ssjcd
        vxRFjRl2yc5z4gV/N+A==
X-Received: by 2002:ad4:4ea2:0:b0:4b1:86aa:e31a with SMTP id ed2-20020ad44ea2000000b004b186aae31amr4019753qvb.10.1665146731089;
        Fri, 07 Oct 2022 05:45:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4+5SITRdFMnFqkx1Ewcco9lwFJjesMF+ZFjLrxm5quNZq583eaih4MmdaTVGly3EoZC62D6g==
X-Received: by 2002:ad4:4ea2:0:b0:4b1:86aa:e31a with SMTP id ed2-20020ad44ea2000000b004b186aae31amr4019736qvb.10.1665146730841;
        Fri, 07 Oct 2022 05:45:30 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x18-20020a05620a259200b006ced196a73fsm1855244qko.135.2022.10.07.05.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 05:45:30 -0700 (PDT)
Date:   Fri, 7 Oct 2022 20:45:26 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] check: optionally compress core dumps
Message-ID: <20221007124526.wr2laws2c7rzujtv@zlang-mailbox>
References: <166500906990.887104.14293889638885406232.stgit@magnolia>
 <166500908117.887104.12652015559068296578.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166500908117.887104.12652015559068296578.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 05, 2022 at 03:31:21PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Compress coredumps whenever desired to save space.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  README    |    1 +
>  common/rc |   13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> 
> diff --git a/README b/README
> index 80d148be82..ec923ca564 100644
> --- a/README
> +++ b/README
> @@ -241,6 +241,7 @@ Misc:
>     this option is supported for all filesystems currently only -overlay is
>     expected to run without issues. For other filesystems additional patches
>     and fixes to the test suite might be needed.
> + - Set COMPRESS_COREDUMPS=1 to compress core dumps with gzip -9.

This patch looks good to me, just one question I'm thinking -- should this
parameter be under "Misc:" or "Tools specification:" part? If the former is
good, then:

Reviewed-by: Zorro Lang <zlang@redhat.com>


>  
>  ______________________
>  USING THE FSQA SUITE
> diff --git a/common/rc b/common/rc
> index 9750d06a9a..d3af4e07b2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4955,12 +4955,25 @@ _save_coredump()
>  	local core_hash="$(_md5_checksum "$path")"
>  	local out_file="$RESULT_BASE/$seqnum.core.$core_hash"
>  
> +	if [ "$COMPRESS_COREDUMPS" = "1" ]; then
> +		out_file="${out_file}.gz"
> +	fi
> +
>  	if [ -s "$out_file" ]; then
>  		rm -f "$path"
>  		return
>  	fi
>  	rm -f "$out_file"
>  
> +	if [ "$COMPRESS_COREDUMPS" = "1" ]; then
> +		if gzip -9 < "$path" > "$out_file"; then
> +			rm -f "$path"
> +		else
> +			rm -f "$out_file"
> +		fi
> +		return
> +	fi
> +
>  	mv "$path" "$out_file"
>  }
>  
> 

