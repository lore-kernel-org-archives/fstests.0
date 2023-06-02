Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2C8C7EE24
	for <linux-fstests@archiver.kernel.org>; Fri,  2 Jun 2023 10:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbjFBKvp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 2 Jun 2023 06:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbjFBKvn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 2 Jun 2023 06:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B67132
        for <fstests@vger.kernel.org>; Fri,  2 Jun 2023 03:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685703045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y8zbCMU/FuKGCuJh/GvsOqjD7APYRQJ6/LXPRBh/CjE=;
        b=Us2NDnBXdgX57qmlM8eNBOad6QHI3YQXYG5I7Y24C6bMQr2iTLDbXdGXlySByCoIN3dkx9
        xVHMO9sTdWlvLiCQ1ZV5kJOLrcYf63sJ4TkiJ3hJfFCUvFRwObjo0+TgbzD59/y/s+0suQ
        v2YOUB53/ClfJO7yuDWp8+MRwKwXm04=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-qnvbuw8-MTSMM3SvuimR3Q-1; Fri, 02 Jun 2023 06:50:44 -0400
X-MC-Unique: qnvbuw8-MTSMM3SvuimR3Q-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-65322c3373eso496455b3a.2
        for <fstests@vger.kernel.org>; Fri, 02 Jun 2023 03:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685703043; x=1688295043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8zbCMU/FuKGCuJh/GvsOqjD7APYRQJ6/LXPRBh/CjE=;
        b=ecmSNHx1MWjL2aSaniG5fn9o/ItMy9mdHddBzySiwEO1tOvGU4ExD3g1M29e0adndh
         UQBOSMFvCkwg7BOVqTvJKTOYrzDKOZZCaGHmytC2w30njdJ3T+MB+ljwWjKEuEqp6bXc
         1kodrrml10+iybVnvm/yjBhrREP5zNwWWwdJZLq5fVvGYKQH3oezHp1fN0QYnWFKb9RV
         HqJpvSQn8eopYB86/jlxb80DmoNmBMVhtOohIQlNV4MZJY8h+tCvGUsIJXmcC3lJApiI
         RdIgdJ9pDTXs3uM6OJrD42DLEtqxjVM14vhKcXmrKU9wbaCr9n0RRF6Xy5zijdrYiNyR
         KmQQ==
X-Gm-Message-State: AC+VfDwPcFOE7j/kTPpyvSTveUj8IlS0gheliW3dLfN401RsUNm4FEYM
        PRf5Zkl9nd8WOOSa9r035ejC4YbvTG9e++S/t6G7yge3TkVw4qvSdMyYGdOFZFTbcPHAXSFXXQ1
        RhJQV8uItCKLI8Offwj7eDrSiG7dN
X-Received: by 2002:a05:6a00:2d1a:b0:652:c336:e63e with SMTP id fa26-20020a056a002d1a00b00652c336e63emr2610416pfb.31.1685703042969;
        Fri, 02 Jun 2023 03:50:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5G9VWzgN/j7JyfAvCfKgEiVH0rBnMEaFZtHfDdYjypz0vCQEGpUIdCkzOhoKxhPivvPeFgDw==
X-Received: by 2002:a05:6a00:2d1a:b0:652:c336:e63e with SMTP id fa26-20020a056a002d1a00b00652c336e63emr2610405pfb.31.1685703042703;
        Fri, 02 Jun 2023 03:50:42 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q23-20020a62ae17000000b00652efb88619sm763000pff.120.2023.06.02.03.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:50:42 -0700 (PDT)
Date:   Fri, 2 Jun 2023 18:50:38 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     xiubli@redhat.com
Cc:     fstests@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH] generic/020: add ceph-fuse support
Message-ID: <20230602105038.tz2azxiaxzcrdu3l@zlang-mailbox>
References: <20230530071552.766424-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530071552.766424-1-xiubli@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 30, 2023 at 03:15:52PM +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> For ceph fuse client the fs type will be "ceph-fuse".
> 
> Fixes: https://tracker.ceph.com/issues/61496
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  tests/generic/020 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/020 b/tests/generic/020
> index e00365a9..da258aa5 100755
> --- a/tests/generic/020
> +++ b/tests/generic/020
> @@ -56,7 +56,7 @@ _attr_get_max()

Hmm... generic/020 is a very old test case, I think this _attr_get_max might
can be a common helper in common/attr.

>  {
>  	# set maximum total attr space based on fs type
>  	case "$FSTYP" in
> -	xfs|udf|pvfs2|9p|ceph|fuse|nfs)
> +	xfs|udf|pvfs2|9p|ceph|fuse|nfs|ceph-fuse)

Anyway, that's another story, for the purpose of this patch:

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  		max_attrs=1000
>  		;;
>  	ext2|ext3|ext4)
> -- 
> 2.40.1
> 

