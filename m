Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFCAFA3743
	for <linux-fstests@archiver.kernel.org>; Mon, 31 Oct 2022 15:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJaPFN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 31 Oct 2022 11:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJaPFM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 31 Oct 2022 11:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB18311178
        for <fstests@vger.kernel.org>; Mon, 31 Oct 2022 08:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667228656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ujuXgEg6GjhCjwVsOvEk/m6GYmLITMv/RPxyO4ahhr8=;
        b=dWieQET3MwJsqCcRuf6WRmHLeFGAiw+mmTD6DTQjWIq96Tpa91P7VBIWA/07GfLAIgSuK9
        h0dtg0VTMGKrkJIiMofk3nmn/jmQyscMl5J+7ioDSRRo5+WfIOdvKUWXBb86nzyQQGJ6Id
        ORyPDeNkEYWRb75Vf11TY51Ufy6k+D8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-325-JvhpkCUzN9-FTU_YA8PFnQ-1; Mon, 31 Oct 2022 11:04:12 -0400
X-MC-Unique: JvhpkCUzN9-FTU_YA8PFnQ-1
Received: by mail-pf1-f199.google.com with SMTP id t7-20020a62ea07000000b005619a832f68so5838325pfh.11
        for <fstests@vger.kernel.org>; Mon, 31 Oct 2022 08:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujuXgEg6GjhCjwVsOvEk/m6GYmLITMv/RPxyO4ahhr8=;
        b=hYiFVna96/VJ/TA7c+vYZl/sicsXCxaPhOPzv7J44gwTiyzEU5tfNhpbvpL95TxM/V
         +p5k9V7hnyuBDVIo4ZUP41hpBvqSQwlXKi2CO4DLmM175+hDRvcAB3YC9NHJZEWTnQTj
         NumBarrgRgF0klnaDijcupm5ufM+usHy8lUQheGaUeSZbafGxghcB12fpUtS+N2jGh0v
         K2nb1XC3Fire83Tr72+5CSKqq+enr6iN+m/BN2/Se6ga67NrUK3C/6/+1FVU7u4DzOyA
         l+HzHk2umonzgZyGggfKy2iHuJEy1GWc9kiChaUtQUAmq4Bi7cP6bD4mGTIWleg8zCzt
         SSpw==
X-Gm-Message-State: ACrzQf1ABXqLMhPZ/RyGQyRIQDEsDnDwWndyyiYCIXcWXLD8ivFf6AOn
        beWRo0ozxIdgBfXVqzr/hNAo8vOOyW8ULlD+ZEqN9spgGxh7GmzidGdqHYXU3TDZmaPi6XpWEMj
        kQiRJOPGxA5yzrvRMAQ==
X-Received: by 2002:a17:902:d2c4:b0:187:a4e:f9c1 with SMTP id n4-20020a170902d2c400b001870a4ef9c1mr11914217plc.168.1667228650003;
        Mon, 31 Oct 2022 08:04:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7y3GxHIqxEDFFzyzofa1S5AAjRdS7RmaPIH0uair58A3Ku3nB4d3oMDxUxpuQqs6VwwIHQvg==
X-Received: by 2002:a17:902:d2c4:b0:187:a4e:f9c1 with SMTP id n4-20020a170902d2c400b001870a4ef9c1mr11914190plc.168.1667228649697;
        Mon, 31 Oct 2022 08:04:09 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id r20-20020a170902be1400b00186b758c9fasm4567644pls.33.2022.10.31.08.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 08:04:08 -0700 (PDT)
Date:   Mon, 31 Oct 2022 23:04:04 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     xiubli@redhat.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v3] encrypt: add ceph support
Message-ID: <20221031150404.etbrz45c7bkgcgdb@zlang-mailbox>
References: <20221031083819.573521-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031083819.573521-1-xiubli@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 31, 2022 at 04:38:19PM +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> This will enable ceph could run the fscrypt test cases, but not all.
> Some of them will be skipped because of not supporting features.
> 
> Here will just skip ceph in _scratch_mkfs_encrypted() and in
> _require_scratch_encryption() it will try to check "set_encpolicy"
> to make sure whether kernel ceph support the encryption or not.
> 
> Reviewed-by: Zorro Lang <zlang@redhat.com>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
> 
> V3:
> - Add more commit comments.

V2 patch has been merged and pushed.

Thanks,
Zorro

> 
> 
>  common/encrypt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/encrypt b/common/encrypt
> index 45ce0954..1a77e23b 100644
> --- a/common/encrypt
> +++ b/common/encrypt
> @@ -153,6 +153,9 @@ _scratch_mkfs_encrypted()
>  		# erase the UBI volume; reformated automatically on next mount
>  		$UBIUPDATEVOL_PROG ${SCRATCH_DEV} -t
>  		;;
> +	ceph)
> +		_scratch_cleanup_files
> +		;;
>  	*)
>  		_notrun "No encryption support for $FSTYP"
>  		;;
> -- 
> 2.31.1
> 

