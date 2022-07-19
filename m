Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB23C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jul 2022 05:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiGSFNV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Jul 2022 01:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiGSFNV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jul 2022 01:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F03B2B1BE
        for <fstests@vger.kernel.org>; Mon, 18 Jul 2022 22:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658207599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0FclPhlZfNsgG44D00NbTHsZEcSYeEfk2yT40L0/7sI=;
        b=Ism4lrUbx/8A1zsUl8sQJ3Xu4nS/KAAbLaAID48XQtNu0ZwYUZa97y4se9OZ+pJrgXCDFm
        mBUI/+BPo4y2p3UVPIfZnFUN5J9AiWWVTgF7XISnJ1+A/4OJy09NEgOP2N4wmvWgmg2JPp
        55G3/vVZAZrK5IYx/En+fOR88H24wgs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-rx5wKuqHN1KuXj0WoOiDtA-1; Tue, 19 Jul 2022 01:13:17 -0400
X-MC-Unique: rx5wKuqHN1KuXj0WoOiDtA-1
Received: by mail-qv1-f70.google.com with SMTP id u15-20020a0ced2f000000b004732a5e7a99so6710335qvq.5
        for <fstests@vger.kernel.org>; Mon, 18 Jul 2022 22:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0FclPhlZfNsgG44D00NbTHsZEcSYeEfk2yT40L0/7sI=;
        b=7/UjuT2GnM0bOappDsFcX1tLcRuDFfGCDHM1yw5IfoPlBcIWex3TKpGboxKbK47Tih
         pSJHYDcsnAIZkH6opU9MglnM5OrT2CYSQPJ+GRhp+p0YLhy+FZkO6RAg0SyEJELTaMr0
         tn2AvD/ZIp0x+AknHGESQ+CytyxVP+eJy46rifrm7tP7zMaYF7kGxbOoI6UuGDEEn78P
         xSbLDDYQwstAt44WvChtzQu3dtidcDttj1EIU2VjLcW/sfl5/XxErmjgXa7XcgO4mTzL
         n3q8CsYARE3QygN3Wf7lYUjU+xheSyrU5E6V7E7BBnLSHP09kq14CeqMxpT2nCOd3wk6
         Kp+Q==
X-Gm-Message-State: AJIora+tpTNZLknLTlCRwxf1ECSCLoJT0IKh461XIEuxQkaOR7g6cedD
        r1C6DOoYthS9vMP6Ns5mpIdNdMMKO8lXd0xIiAn404bMFifUj8gMzIZA8Kt/KC4IZRmJ2DvHgAm
        e+Xtqjn1+3Uz50doumg==
X-Received: by 2002:ac8:58d6:0:b0:31e:e54d:fea0 with SMTP id u22-20020ac858d6000000b0031ee54dfea0mr9709551qta.367.1658207596905;
        Mon, 18 Jul 2022 22:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uIShZj6DSQX+ZBwtePRXpXR508rxKDkLsWk52HusNDvzWWheI6AWQQoo81RDV8WODsXKgB3g==
X-Received: by 2002:ac8:58d6:0:b0:31e:e54d:fea0 with SMTP id u22-20020ac858d6000000b0031ee54dfea0mr9709542qta.367.1658207596609;
        Mon, 18 Jul 2022 22:13:16 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bk34-20020a05620a1a2200b006af1f0af045sm12795964qkb.107.2022.07.18.22.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 22:13:16 -0700 (PDT)
Date:   Tue, 19 Jul 2022 13:13:10 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2 1/2] xfs/270: Fix syntax error
Message-ID: <20220719051310.mptogjydytz233n4@zlang-mailbox>
References: <1657012808-2204-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657012808-2204-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jul 05, 2022 at 05:20:07PM +0800, Yang Xu wrote:
> Without xfsprogs commit
> f4afdcb0a ("xfs_db: clean up the salvage read callsites in set_cur()"),
> this case will fail as below:
> 
> +/var/lib/xfstests/tests/xfs/270: line 51: [: !=: unary operator expected
> 
> With this xfsprogs bug, xfs_db can't get new_ro_compat value, so report
> this bash syntax error.
> 
> Fix this and add a helper output for xfsprogs bug.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/270 | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/xfs/270 b/tests/xfs/270
> index b740c379..4954e943 100755
> --- a/tests/xfs/270
> +++ b/tests/xfs/270
> @@ -47,9 +47,12 @@ _scratch_xfs_set_metadata_field "features_ro_compat" "$ro_compat" "sb 0" \
>  new_ro_compat=$(_scratch_xfs_get_metadata_field "features_ro_compat" "sb 0" \
>  						2>/dev/null)
>  
> -# verify the new ro_compat field is correct.
> -if [ $new_ro_compat != $ro_compat ]; then
> +# verify the new ro_compat field is correct. Without xfsprogs commit
> +# f4afdcb0ad ("xfs_db: clean up the salvage read callsites in set_cur()"),
> +# we can't get new_ro_compat value.
> +if [ "$new_ro_compat" != "$ro_compat" ]; then
>  	echo "Unable to set new features_ro_compat. Wanted $ro_compat, got $new_ro_compat"
> +	echo "May hit a known xfsprog bug"
>  fi
>  
>  # rw mount with unknown ro-compat feature should fail
> -- 
> 2.27.0
> 

