Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB00C3DA7D
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Jan 2023 13:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjAANaU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Jan 2023 08:30:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjAANaU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Jan 2023 08:30:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF9A3894
        for <fstests@vger.kernel.org>; Sun,  1 Jan 2023 05:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672579769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FZ9wFR+izkGobv8G8OkSAX0ejGFf09Spc9enwFj68d8=;
        b=GSJ+Hg4BSvzVuioUozWVxx0Dd/X21aKr+RTvZUw4+kL3DWzxmVnRX49gvLX9EplnlC63Qk
        kcMqyzTQmzU8kH3xXvBHZ9jsIHSE9sgW3eiqVp2veOGHi4Obp1Zg3nPIz98uQEWqoFCZAn
        OJEfmu1spKAd0JTkvgyUVNxc6860PCM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-aicTkmw6P0GiHnHghsJsUQ-1; Sun, 01 Jan 2023 08:29:28 -0500
X-MC-Unique: aicTkmw6P0GiHnHghsJsUQ-1
Received: by mail-pl1-f197.google.com with SMTP id c17-20020a170902d49100b00192be705f76so1907706plg.13
        for <fstests@vger.kernel.org>; Sun, 01 Jan 2023 05:29:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZ9wFR+izkGobv8G8OkSAX0ejGFf09Spc9enwFj68d8=;
        b=m6ruZPL+oLzcec5AI8r5CoPiu8kuvMcPmlWfXijV2cXjlTGb6yjgibC24+pksIVhd6
         vbbF7nlDU7cqStLN7P5KI0LhtOuqbkiu3hXLKcY2gKcg/NIBK3Es57Ngm9IJZzhJsFfV
         tXsMvUy5w5Lyln2q5JAXr0Ui5nCri6tugAOuKNwTDp4RvDaATjUVKcrwIfI2Mdz//3u3
         feAfkDw9++YA0BQkT1HFWsIKOmTcWQrddw8iH3tAZ3M3vKHxwt0TDEIq0jlYogpivmSo
         Bx9a43jT7vM3+76Qkr/wAyhApydmtmVMe03rmuHML070IGcZzFET2SebPhtg2kmO01v4
         m3zg==
X-Gm-Message-State: AFqh2krGcNP29gGOGhvpsZQTjgiCUxgkF30cHWge/t6THUlZFG8KTIYM
        7GcWoyEQd82nvrytdX93wPNONBQEfbScvQs/BnjHTpp9g0uP4CeY7ThXAz7fk4PHd/C3Zuwaqhb
        qehCQMTwrV7byUBk1/Q==
X-Received: by 2002:a17:90a:fe10:b0:226:201a:fdb0 with SMTP id ck16-20020a17090afe1000b00226201afdb0mr14789305pjb.35.1672579767302;
        Sun, 01 Jan 2023 05:29:27 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvcgZCd7xTO4TQXGTCRXWdKSKiNPYjLwL8xaq1Z7XbGc+3tiFw7azjXJABcZfncgi8kQLKTUA==
X-Received: by 2002:a17:90a:fe10:b0:226:201a:fdb0 with SMTP id ck16-20020a17090afe1000b00226201afdb0mr14789295pjb.35.1672579766991;
        Sun, 01 Jan 2023 05:29:26 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ch24-20020a17090af41800b00219cf5c3829sm15645062pjb.57.2023.01.01.05.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jan 2023 05:29:26 -0800 (PST)
Date:   Sun, 1 Jan 2023 21:29:22 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     xzhou@redhat.com
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] overlay: avoid to use NULL OVL_BASE_FSTYP for mounting
Message-ID: <20230101132922.apezbzhkrelqq7ve@zlang-mailbox>
References: <20221229134434.1513212-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229134434.1513212-1-libaokun1@huawei.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Dec 29, 2022 at 09:44:34PM +0800, Baokun Li wrote:
> Generally, FSTYP is used to specify OVL_BASE_FSTYP. When we specify FSTYP
> through an environment variable, it is not converted to OVL_BASE_FSTYP.
> In addition, sometimes we do not even specify the file type. For example,
> we only use `./check -n -overlay -g auto` to list overlay-related cases.
> If OVL_BASE_FSTYP is NULL, mounting fails and the test fails.
> 
> To solve this problem, try to assign a value to OVL_BASE_FSTYP when
> specifying -overlay. In addition, in the _overlay_base_mount function,
> the basic file system type of the overlay is specified only when
> OVL_BASE_FSTYP is not NULL.
> 
> Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---

Hi Murphy,

Does this patch fix the problem you hit?

Thanks,
Zorro

>  check          | 1 +
>  common/overlay | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index 1ff0f44a..22062935 100755
> --- a/check
> +++ b/check
> @@ -283,6 +283,7 @@ while [ $# -gt 0 ]; do
>  		FSTYP="${1:1}"
>  		;;
>  	-overlay)
> +		[ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
>  		FSTYP=overlay
>  		export OVERLAY=true
>  		;;
> diff --git a/common/overlay b/common/overlay
> index e35419d0..20cafeb1 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -85,7 +85,12 @@ _overlay_base_mount()
>  		return 1
>  	fi
>  
> -	_mount -t $OVL_BASE_FSTYP $* $dev $mnt
> +	if [ $OVL_BASE_FSTYP ]; then
> +		_mount -t $OVL_BASE_FSTYP $* $dev $mnt
> +	else
> +		_mount $* $dev $mnt
> +	fi
> +
>  	_idmapped_mount $dev $mnt
>  }
>  
> -- 
> 2.31.1
> 

