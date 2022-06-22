Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDE7C43334
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Jun 2022 04:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356654AbiFVE1W (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Jun 2022 00:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356656AbiFVE1V (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Jun 2022 00:27:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F28E23525F
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 21:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655872038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j9u7LDlGCgRF3NS4iqS1iLn/AkMWug7xL+FlG9GwSdg=;
        b=aeR4vVj6i6bGIiHJrqKNKdnWSCMrSrV8bl7hRCuwtCcc/zeqbYMvcA2tcCWNIJ/WGPnuSY
        a80IycI/gB4mE0V57vnnbmdefpbJ+MiyW/Se4yLmI5LeTv0aaGX6bsld3jE1yfT1vXU22A
        HM848WU87c7Hnv0bjta8EezTihQOSyU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-JvzYaNYFPryYhP7VrLuuKA-1; Wed, 22 Jun 2022 00:27:17 -0400
X-MC-Unique: JvzYaNYFPryYhP7VrLuuKA-1
Received: by mail-qk1-f200.google.com with SMTP id f2-20020a05620a408200b006ab94bb9d09so14912552qko.8
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 21:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j9u7LDlGCgRF3NS4iqS1iLn/AkMWug7xL+FlG9GwSdg=;
        b=rBQgZsUvVCuOyZKbsCpomEeqhCzdCxjCb0zNQyp9MJeZM2sHGs+w32MyHWEL9Q+fGD
         MD9Ieef/JXiC20Y/M7oGh8uFlWgC4odWO9D3zynyTxtwRmOFkgnj2trbVXd95oI0euiY
         vF3QODszMDwL6Emg9kQRlxsTcT9EmKi+QEhrjZ0GQikTzNjAST3lywmlgjpAlbcMDmxu
         pp6gfzChhQyabmvhmZSdncVULeu7fvnCrxMUDq7DWGK0dEhjPBwrYigrciecnpJJbzZ1
         W2HC1cmGPZCfE3NPr/t1YltYgka2jnPIV+UNjDMfHp/QNZNBhDhI8p6HBsNM0MblJRJ8
         nfIg==
X-Gm-Message-State: AJIora8JGDnWmnANaRrySPlbGzFiKyAogASCi4cFps0jQz1Piaexb0uL
        aYsM6ZadxOEpSZw+KS/6Q8s7rVsI4RqGVdZcTWqN0YBO8tE93PEfzHygQ3Rdv2/XDxWetCDPIda
        rT/Dml3tx73IEVyQUDQ==
X-Received: by 2002:a37:a781:0:b0:6a6:a8f5:d111 with SMTP id q123-20020a37a781000000b006a6a8f5d111mr950725qke.676.1655872036401;
        Tue, 21 Jun 2022 21:27:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tDvK0Ft4qoduzlS34tr7FVHQ7jUBvAl21HKsUTlmx2WRqRzFHHEUrhVsdyHTcnHaig4fVd9w==
X-Received: by 2002:a37:a781:0:b0:6a6:a8f5:d111 with SMTP id q123-20020a37a781000000b006a6a8f5d111mr950712qke.676.1655872036108;
        Tue, 21 Jun 2022 21:27:16 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id dz18-20020a05620a2b9200b006a71729a139sm14712823qkb.44.2022.06.21.21.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 21:27:15 -0700 (PDT)
Date:   Wed, 22 Jun 2022 12:27:10 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 1/6] check: avoid FSTYP=<fstyp parameter> repetition
Message-ID: <20220622042710.fkwmlel4dfr7chfx@zlang-mailbox>
References: <20220620192934.21694-1-ddiss@suse.de>
 <20220620192934.21694-2-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620192934.21694-2-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jun 20, 2022 at 09:29:29PM +0200, David Disseldorp wrote:
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  check | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/check b/check
> index de11b37e..42925e09 100755
> --- a/check
> +++ b/check
> @@ -277,15 +277,13 @@ while [ $# -gt 0 ]; do
>  	case "$1" in
>  	-\? | -h | --help) usage ;;
>  
> -	-nfs)		FSTYP=nfs ;;
> -	-glusterfs)	FSTYP=glusterfs ;;
> -	-cifs)		FSTYP=cifs ;;
> -	-9p)		FSTYP=9p ;;
> -	-virtiofs)	FSTYP=virtiofs ;;
> -	-overlay)	FSTYP=overlay; export OVERLAY=true ;;
> -	-pvfs2)		FSTYP=pvfs2 ;;
> -	-tmpfs)		FSTYP=tmpfs ;;
> -	-ubifs)		FSTYP=ubifs ;;
> +	-nfs|-glusterfs|-cifs|-9p|-virtiofs|-pvfs2|-tmpfs|-ubifs)
> +		FSTYP="${1:1}"
> +		;;
> +	-overlay)
> +		FSTYP=overlay
> +		export OVERLAY=true
> +		;;

Looks good.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  	-g)	group=$2 ; shift ;
>  		GROUP_LIST="$GROUP_LIST ${group//,/ }"
> -- 
> 2.35.3
> 

