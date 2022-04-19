Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49205C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Apr 2022 18:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355803AbiDSSi1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Apr 2022 14:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357706AbiDSSiA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Apr 2022 14:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A6D724F37
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 11:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650393269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AyKeDt/G+be2E1gyLoCwi+1fRzVFrvAJkghfupIO6no=;
        b=NKHgeixj8SIdf0jNJZUww5bDgmnGew+nze328i/HlVm+C+tERDGkI3zF7Xja9Mktzd1oja
        RIZVIXgfCN9iiZ+s9pr/gv4FuiTczdz+ykxIDB44uPpgiSkTkG2FT+DPpb1s8nPofOvqZt
        Ujg5LSiY7IYsVn9E3tq1IOys/V3Ke1s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-3gjrRV_GM_6YSdShK8yYnQ-1; Tue, 19 Apr 2022 14:34:28 -0400
X-MC-Unique: 3gjrRV_GM_6YSdShK8yYnQ-1
Received: by mail-qv1-f72.google.com with SMTP id j7-20020a05621419c700b004461f75de48so13047448qvc.10
        for <fstests@vger.kernel.org>; Tue, 19 Apr 2022 11:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=AyKeDt/G+be2E1gyLoCwi+1fRzVFrvAJkghfupIO6no=;
        b=uD318iIlnQfoVv3RPl9Lz5yCPaaypkeDEc1bf3QYrdExzplGTENTvUAsAWONbRHed+
         asWxH610zPI2+qS7JoE8gvEo0UeZDW5XjgoW0a/XfJJZBSWg0TpV9fNJNgugJ0bAwUwC
         Mriu1XIQrR6gsxs06AKgHMJ4mdzBimTMoncc+fI9J34iTntWjvkTnd2yi5GXL/f8/Sgt
         dFaFdUw1gnLklBkCpI5CChEqVhzGBU7T/GaFwSYO6Fp5hsPpvwQW8/xxxdDYoN5tNtJc
         V0tj08+m545PEJW+4PxERo1cD3KOPLsDwGboGbk6FoRT2YNI6GgppEp6jmmRqRTZup2K
         h6vQ==
X-Gm-Message-State: AOAM530+0HR8iVjvks03XFzD6sn8T0v+3dxO+gS7X7Q0RGS0T7jzo3Vu
        sG5bqS5xkRCzXMIO5OcLuLyfsBa/91VkLS4S4qtE1Up20hBKyPXMApalMqd6QC/OflPF5ycYgEE
        Dt2nDmaOI6TMMCwscGA==
X-Received: by 2002:ad4:5bc7:0:b0:441:53a2:169c with SMTP id t7-20020ad45bc7000000b0044153a2169cmr12977856qvt.8.1650393267594;
        Tue, 19 Apr 2022 11:34:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiKXC2/RiQDh5CJQRXIQmnuUQY+xhfR/93kuRANErdytCKje+pae6FFWxAjEY+Jyt60VC7Lw==
X-Received: by 2002:ad4:5bc7:0:b0:441:53a2:169c with SMTP id t7-20020ad45bc7000000b0044153a2169cmr12977843qvt.8.1650393267365;
        Tue, 19 Apr 2022 11:34:27 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002f1fc230725sm449116qta.31.2022.04.19.11.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:34:26 -0700 (PDT)
Date:   Wed, 20 Apr 2022 02:34:21 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     guaneryu@gmail.com, linux-xfs@vger.kernel.org,
        fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH 2/2] generic/019: fix incorrect unset statements
Message-ID: <20220419183421.ohwmohh3tl3wi6li@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>, guaneryu@gmail.com,
        linux-xfs@vger.kernel.org, fstests@vger.kernel.org, guan@eryu.me
References: <165038951495.1677615.10687913612774985228.stgit@magnolia>
 <165038952637.1677615.2651496553218188517.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165038952637.1677615.2651496553218188517.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Apr 19, 2022 at 10:32:06AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Fix incorrect usage of unset -- one passes the name of the variable, not
> the *value* contained within it.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/019 |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/tests/generic/019 b/tests/generic/019
> index 854ba57d..45c91624 100755
> --- a/tests/generic/019
> +++ b/tests/generic/019
> @@ -140,8 +140,8 @@ _workout()
>  	kill $fs_pid &> /dev/null
>  	wait $fs_pid
>  	wait $fio_pid
> -	unset $fs_pid
> -	unset $fio_pid
> +	unset fs_pid
> +	unset fio_pid
>  
>  	# We expect that broken FS still can be umounted
>  	run_check _scratch_unmount
> 

