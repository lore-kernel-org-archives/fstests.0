Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF62C4332F
	for <linux-fstests@archiver.kernel.org>; Wed, 14 Dec 2022 18:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiLNSlv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 14 Dec 2022 13:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238886AbiLNSlp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 14 Dec 2022 13:41:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7346B2A715
        for <fstests@vger.kernel.org>; Wed, 14 Dec 2022 10:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671043255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTDcKqysoJsS1IFGNutz6UdMJGnvNSrJ858y5VWuguE=;
        b=XkWjyab0Oi4umxsy68OljhY1ikuuVR1IQJ7TL1HNNyxTZpA7A57hbHZKAFpB1xNbqM11E1
        qGvaZTmal6TjesS0DeSEKw/XfZtexhRGdBE1r7VBPN1VJf31mIZu2UCXu8SVwmttOiE8Zh
        A0gJ6/k/0SsB0+WRMZ45tJ4qFA04svc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-v889v-oCN3qTlSVs_NKdeA-1; Wed, 14 Dec 2022 13:40:54 -0500
X-MC-Unique: v889v-oCN3qTlSVs_NKdeA-1
Received: by mail-pf1-f197.google.com with SMTP id x21-20020a62fb15000000b0057451601be4so4575750pfm.19
        for <fstests@vger.kernel.org>; Wed, 14 Dec 2022 10:40:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTDcKqysoJsS1IFGNutz6UdMJGnvNSrJ858y5VWuguE=;
        b=P7I07A0m/40iTmEpsJaLv6OZNyfPhYcKtInmMrwmL2V/ibr/3c/pK9x8OkcZY0aeLN
         DCHTh46YRIX1o1snhVf475BbgH+ZrKvC3iPdfoKgLCz8MB3Rf+Fmgebgj1OhsGVWo2Eu
         5HdQiyJ7dgGzlSiN6NFow8pa9Icg6yHbotjrgvUDdGi8s4v6DA3Uzyqp1fKgdhtkN1O5
         oyMiaa8hlezONrhFPt4yvarwnlFmARiJwpO1mzQMnfinpKbLa2z5hVJKDWmxeFuTVgBt
         hZ0QxUdjaDX2fQ2h+5t76YxfL37iQyn1bNjup+ZZZMXGPGCbKPj0NgZvhmkjE2B2hpNx
         z2Cw==
X-Gm-Message-State: ANoB5pmsGeSMSEN6fWxG/r8Qnb9TMQOlyA0SWqbB80OyHPvw2sgxGGde
        cSp1pQxzyh28/1T/JVdoquK4zEuZtE4f7CAF5rna11NoFCe7OkwdurITPqtR/kdYMgZyAlkhJmk
        EufTuDYWbbxRBBCt1vw==
X-Received: by 2002:a17:902:7845:b0:186:971c:297e with SMTP id e5-20020a170902784500b00186971c297emr21555460pln.20.1671043252405;
        Wed, 14 Dec 2022 10:40:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5iR1wrQqQRxW0bqEfeL/rXr2uPe4/LiVucxwt/FboDDX1zdQN+lnMB3swZHVacI9usvJj+yw==
X-Received: by 2002:a17:902:7845:b0:186:971c:297e with SMTP id e5-20020a170902784500b00186971c297emr21555441pln.20.1671043252066;
        Wed, 14 Dec 2022 10:40:52 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z1-20020a1709027e8100b00188f7ad561asm2171488pla.249.2022.12.14.10.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 10:40:51 -0800 (PST)
Date:   Thu, 15 Dec 2022 02:40:47 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs/122: fix EFI/EFD log format structure size after
 flex array conversion
Message-ID: <20221214184047.k3iaxggotcli4423@zlang-mailbox>
References: <167096073708.1750519.5668846655153278713.stgit@magnolia>
 <167096074260.1750519.311637326793150150.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167096074260.1750519.311637326793150150.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 13, 2022 at 11:45:42AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Adjust this test since made EFI/EFD log item format structs proper flex
> arrays instead of array[1].
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

So we let this case fail on all older system/kernel? Is the kernel patch
recommended to be merged on downstream kernel?

Thanks,
Zorro

>  tests/xfs/122.out |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/tests/xfs/122.out b/tests/xfs/122.out
> index a56cbee84f..95e53c5081 100644
> --- a/tests/xfs/122.out
> +++ b/tests/xfs/122.out
> @@ -161,10 +161,10 @@ sizeof(xfs_disk_dquot_t) = 104
>  sizeof(xfs_dq_logformat_t) = 24
>  sizeof(xfs_dqblk_t) = 136
>  sizeof(xfs_dsb_t) = 264
> -sizeof(xfs_efd_log_format_32_t) = 28
> -sizeof(xfs_efd_log_format_64_t) = 32
> -sizeof(xfs_efi_log_format_32_t) = 28
> -sizeof(xfs_efi_log_format_64_t) = 32
> +sizeof(xfs_efd_log_format_32_t) = 16
> +sizeof(xfs_efd_log_format_64_t) = 16
> +sizeof(xfs_efi_log_format_32_t) = 16
> +sizeof(xfs_efi_log_format_64_t) = 16
>  sizeof(xfs_error_injection_t) = 8
>  sizeof(xfs_exntfmt_t) = 4
>  sizeof(xfs_exntst_t) = 4
> 

