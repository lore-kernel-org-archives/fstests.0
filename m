Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7E4C43334
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Jul 2022 17:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiGMRRM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Jul 2022 13:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiGMRRK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Jul 2022 13:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF8582CE07
        for <fstests@vger.kernel.org>; Wed, 13 Jul 2022 10:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657732629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rLhkNjsTRfqGJh2Nb8MEzmrcUy3t2fKC9MngQwvWI6g=;
        b=Qf26w+UqWauHlncIfYZ8I/PJJAcF2wlSyUX7KZTmtHWvaWioUejGQInTWJnkb6S87Cgqk9
        Ctj00HpRSRXn3sBHIvPlxm+WWfFPJztfVvXSZ9MFhTqFxN2xGlPEHNqr3bZec9rtvV0fkX
        D/cfn/RC8bxVoayEEMbk9zfU1D/hnnc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-KoCRVFZNNlKqUVpEf5IELg-1; Wed, 13 Jul 2022 13:17:06 -0400
X-MC-Unique: KoCRVFZNNlKqUVpEf5IELg-1
Received: by mail-ot1-f71.google.com with SMTP id y18-20020a9d5192000000b0061c4600197eso4032308otg.16
        for <fstests@vger.kernel.org>; Wed, 13 Jul 2022 10:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rLhkNjsTRfqGJh2Nb8MEzmrcUy3t2fKC9MngQwvWI6g=;
        b=eK1DkJctvd7mOeE3OlhsA9cPsbiQf4fMUP5jEyPr9PRJuFFN1vI8dq8t9dSgM9TQYb
         Rdaury7gR1pUgi6443wxVMFSImz2pFFcXkDLbyz9etuYlNY9DVVOD0yYODO77FWGXntq
         fllgvRIiO8hEhD4EdRBm1D9gmzs+UILL5roQZE/n2SqF0qCQrK7ByEBDmkrdOhg/lfhy
         ZaHtwfaAny7R9VmZaO4LLJUmjbEgIi9FxrckFMJhKA85XI1If8UHjS6U4iyCdlUDaheU
         dH9tGZVDQUOGWv9yeN5m/K+71rkc9BmoSsYF4AuZsbNoY6o2L4dnLrOXsvlUC9MJ6JqH
         VMTQ==
X-Gm-Message-State: AJIora9C2aG2UJBwvNSr0B0gXmLYDgqNc1K5N7bcO/Ag567uCZy2SP6g
        Ztdkl8HRyCHvA7tCkcybl2EQmEn0CJ7+0fFFR1WMTN8kplfU3q5ZcnM2AfVnx1vi0lgN8iGHm84
        lHTSu4AzD7hiTWcn2fw==
X-Received: by 2002:a05:6870:7a5:b0:101:5bb9:780 with SMTP id en37-20020a05687007a500b001015bb90780mr2382594oab.192.1657732624906;
        Wed, 13 Jul 2022 10:17:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vv1jJtU8jDgGkmR/9A3nwNxi0dCq5Y/DrYLTwtkuFTj29bq0EQiMLfmTcXMiE+DbSTTVWFqg==
X-Received: by 2002:a05:6870:7a5:b0:101:5bb9:780 with SMTP id en37-20020a05687007a500b001015bb90780mr2382576oab.192.1657732624649;
        Wed, 13 Jul 2022 10:17:04 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q3-20020aca5c03000000b003356be620e3sm5488652oib.49.2022.07.13.10.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 10:17:04 -0700 (PDT)
Date:   Thu, 14 Jul 2022 01:16:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, tytso@mit.edu,
        leah.rumancik@gmail.com
Subject: Re: [PATCH 7/8] filter: report data block mappings and od offsets in
 multiples of allocation units
Message-ID: <20220713171657.ee2vsdvedohwkce3@zlang-mailbox>
References: <165767379401.869123.10167117467658302048.stgit@magnolia>
 <165767383332.869123.15665387460779572064.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165767383332.869123.15665387460779572064.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 12, 2022 at 05:57:13PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> All the tests that use these two filter functions also make all of their
> fallocate calls in units of file allocation units, not filesystem
> blocks.  Make them transform the file offsets to multiples of file
> allocation units (via _get_file_block_size) so that xfs/242 and xfs/252
> will work with XFS with a rt extent size set.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Looks good,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/filter |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/common/filter b/common/filter
> index 14f6a027..28dea646 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -221,7 +221,7 @@ _filter_xfs_io_units_modified()
>  
>  _filter_xfs_io_blocks_modified()
>  {
> -	BLOCK_SIZE=$(_get_block_size $SCRATCH_MNT)
> +	BLOCK_SIZE=$(_get_file_block_size $SCRATCH_MNT)
>  
>  	_filter_xfs_io_units_modified "Block" $BLOCK_SIZE
>  }
> @@ -457,7 +457,7 @@ _filter_busy_mount()
>  
>  _filter_od()
>  {
> -	BLOCK_SIZE=$(_get_block_size $SCRATCH_MNT)
> +	BLOCK_SIZE=$(_get_file_block_size $SCRATCH_MNT)
>  	$AWK_PROG -v block_size=$BLOCK_SIZE '
>  		/^[0-9]+/ {
>  			offset = strtonum("0"$1);
> 

