Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE45C433F5
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Nov 2021 14:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC03D6108F
	for <linux-fstests@archiver.kernel.org>; Mon,  1 Nov 2021 14:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhKAOPI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 1 Nov 2021 10:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231922AbhKAOPH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 1 Nov 2021 10:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635775954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UjQrrgrV+6JwgK7qaj7VTyQ5w3VHrBm2WpB+2/HE5tM=;
        b=aAxhQjPJxc2nntAIGmOD1CDkFvdrMLe+qlF9p/7GvD1K1ErjSXNRqvQ/pLKC7QsXGxCVrM
        Xuc50yFQ71H2wYKledkfseciUY2ZVpZ43w7r1Go2N/3b/7yIR5b5yaNx32I+WGPSuHec7a
        g8fxw+4Gjdlmcd/pZ2PL3X+B4Kg1aXU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-CS0xJ1YAOeulOxs_QPtnFA-1; Mon, 01 Nov 2021 10:12:33 -0400
X-MC-Unique: CS0xJ1YAOeulOxs_QPtnFA-1
Received: by mail-pg1-f197.google.com with SMTP id z7-20020a63c047000000b0026b13e40309so9340628pgi.19
        for <fstests@vger.kernel.org>; Mon, 01 Nov 2021 07:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=UjQrrgrV+6JwgK7qaj7VTyQ5w3VHrBm2WpB+2/HE5tM=;
        b=lksVWhkHT29sn4+1cYX0Zd5g2myCAIc4xtLvXmznGtpVHUzYDXbmyA3/R030VL3w92
         SifK5Dml2UYqxFuhTIhLb9Wb2d+4DKUXJ84WPTGwJw683+OMmHXC4WCmIvXB1sjhl7rp
         DbQZpTHjjlS4o7e/U3mk1XfhW33U7tgs3NyOa/fAmvaZczjoq1cfveyu/5bbW1rQ/aev
         rZN9W/Znvb20fOiioAHTnNcyXmubW8yX+NeeQi7FpM4/wU+MHpdm82Z580ycv/2VNyzp
         5n1qtHP+nelMwwqkYgm5co68KBecehBYHBODYFa5Tq7bTAOLSAl5SwOoTEP1jW7qvtW7
         jXjA==
X-Gm-Message-State: AOAM533LIcbS8yKus/fcHAjO+nbUoKtIC4harxG97cws+5wkfJRYstWf
        2kmrBmgnGauuHKPgH5bv2pD54jSMpVE6vivz1gLAdbmh6wBjTUGPTbTDK+wS8fS/qD3hMzpvJOh
        BsdjYwYTg09xPOhh4CA==
X-Received: by 2002:a63:91c8:: with SMTP id l191mr6134696pge.404.1635775951750;
        Mon, 01 Nov 2021 07:12:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZ4X4QzVz905WJkCPT5fpdFqvXdRB8d8uQq4bxd3GzlWHAxF/Er3YcODo//dz+fDhMEEHcSQ==
X-Received: by 2002:a63:91c8:: with SMTP id l191mr6134671pge.404.1635775951429;
        Mon, 01 Nov 2021 07:12:31 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a10sm13239261pgw.25.2021.11.01.07.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 07:12:31 -0700 (PDT)
Date:   Mon, 1 Nov 2021 22:26:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: Fix check for SCRATCH_DEV_POOL presence in
 _scratch_dev_pool_get
Message-ID: <20211101142656.cgsxbanon2nvozqa@fedora>
Mail-Followup-To: Nikolay Borisov <nborisov@suse.com>,
        fstests@vger.kernel.org
References: <20211101133511.383232-1-nborisov@suse.com>
 <20211101135658.385131-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101135658.385131-1-nborisov@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 01, 2021 at 03:56:58PM +0200, Nikolay Borisov wrote:
> Current check is buggy because it can never trigger as even if
> SCRATCH_DEV_POOL is not defined config_ndevs will get a value of 0 from
> 'wc -w', this in turn makes 'typeset -p config_ndevs' always return 0,
> triggering the existing check a noop.
> 
> Fix this by explicitly checking for the presence of SCHRATC_DEV_POOL
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> 
> Eryu,
> 
> Please use this patch as it's a more proper fix
> 
>  common/rc | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index 7f693d3922e8..07b69880eea6 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -917,15 +917,15 @@ _scratch_dev_pool_get()
>  		_fail "Usage: _scratch_dev_pool_get ndevs"
>  	fi
> 
> -	local test_ndevs=$1
> -	local config_ndevs=`echo $SCRATCH_DEV_POOL| wc -w`
> -	local -a devs="( $SCRATCH_DEV_POOL )"
> -
> -	typeset -p config_ndevs >/dev/null 2>&1
> +	typeset -p SCRATCH_DEV_POOL >/dev/null 2>&1
>  	if [ $? -ne 0 ]; then
>  		_fail "Bug: cant find SCRATCH_DEV_POOL ndevs"
>  	fi
> 
> +	local test_ndevs=$1
> +	local config_ndevs=`echo $SCRATCH_DEV_POOL| wc -w`
> +	local -a devs="( $SCRATCH_DEV_POOL )"

Yes, the logic of:
     "local config_ndevs=`echo $SCRATCH_DEV_POOL| wc -w`
      typeset -p config_ndevs >/dev/null 2>&1"
looks weird.

Checking SCRATCH_DEV_POOL makes sense to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>


> +
>  	if [ $config_ndevs -lt $test_ndevs ]; then
>  		_notrun "Need at least test requested number of ndevs $test_ndevs"
>  	fi
> --
> 2.17.1
> 

