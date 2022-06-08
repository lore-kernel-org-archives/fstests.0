Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CC3CCA482
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Jun 2022 09:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiFHJTr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Jun 2022 05:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbiFHJTM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Jun 2022 05:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0263F232ACB
        for <fstests@vger.kernel.org>; Wed,  8 Jun 2022 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654677694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x3ViZ7KMtV57nuYrL36SRIzOR46fHP7ZePPOQYVlfOE=;
        b=bZAQrI7hWxsfNiAWpDGJAHulwIFa4uGjNvhUBH4nM0tpOB9jH5c18pyy8NFbMvNVZRM68J
        QWFiVRVqljwUiM2GVZ87Fd03c+hDRQi/Xmcr5BugmoKa8iBDN7pY+Hj9sdLgafrJlI/ahZ
        1FyUg1pieN1lf9QGG45io+KZhFIuK78=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-q3rBOIZgMmeq-g986jHPCQ-1; Wed, 08 Jun 2022 04:41:33 -0400
X-MC-Unique: q3rBOIZgMmeq-g986jHPCQ-1
Received: by mail-pj1-f69.google.com with SMTP id j8-20020a17090a3e0800b001e3425c05c4so8827081pjc.0
        for <fstests@vger.kernel.org>; Wed, 08 Jun 2022 01:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=x3ViZ7KMtV57nuYrL36SRIzOR46fHP7ZePPOQYVlfOE=;
        b=mH+RiUziBWHXCXUSSHMUfKGvGslcpeWNnLb4h9qsuNgV+/n2TJtfhOEH6wFJwPQU0N
         qhnCGA401MpzmXeazB9L0RfXycThkRQHOFRXTmyY0oQcY2hoRAeNku8LAzJjG8YCuQl4
         POwXM/VnKZkwc/8FOGC1X346gdlWHyy0Gr4qUWhALlTEtQQ/eruMj51YuBdszbVNLbxI
         XyG0bBNdvXjOCK3X3XE+mGLUNVLqacwRjipvJdWEZYRdpi1H7sj4bAkQ896nq6IPazby
         bxpjSosePo7pxqUK735W0xNt38Z5iGwYhaG0MIdwr5keLW9NIT9jdHxQiBoEi++D5aSW
         C6mA==
X-Gm-Message-State: AOAM531Qwj4ReGYCIxq9EJ2epgbTPTur+nF5CcfvqNhBffnZAQMFQZ14
        +v0+aik4GjxWmMMhuS8+lWNMW5joNenOKIp5jRcb8WUsf/i9PugaDLYqerWa186jPmuJ1GjAYsI
        4Ksdmorz54vfVMxpM+w==
X-Received: by 2002:a65:6bd3:0:b0:3fd:63c3:a84b with SMTP id e19-20020a656bd3000000b003fd63c3a84bmr17700980pgw.572.1654677691777;
        Wed, 08 Jun 2022 01:41:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUDtWFnME8QJhVfkuT6kfze8TJFII1OLM2ZYx9b1iaj0MN7TrxAzthRj2r/Fxn8GyVFfaEiA==
X-Received: by 2002:a65:6bd3:0:b0:3fd:63c3:a84b with SMTP id e19-20020a656bd3000000b003fd63c3a84bmr17700965pgw.572.1654677691539;
        Wed, 08 Jun 2022 01:41:31 -0700 (PDT)
Received: from [10.72.12.54] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id go13-20020a17090b03cd00b001e667f932cdsm12764658pjb.53.2022.06.08.01.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:41:30 -0700 (PDT)
Subject: Re: [PATCH 1/2] generic/020: adjust max_attrval_size for ceph
To:     =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        fstests@vger.kernel.org
Cc:     Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
References: <20220607151513.26347-1-lhenriques@suse.de>
 <20220607151513.26347-2-lhenriques@suse.de>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <4196c96d-0ae8-a7ba-7a5f-b64483336d17@redhat.com>
Date:   Wed, 8 Jun 2022 16:41:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220607151513.26347-2-lhenriques@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


On 6/7/22 11:15 PM, Luís Henriques wrote:
> CephFS doesn't had a maximum xattr size.  Instead, it imposes a maximum
> size for the full set of an inode's xattrs names+values, which by default
> is 64K but it can be changed by a cluster admin.
>
> Adjust max_attrval_size so that the test can be executed in this
> filesystem.
>
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>   tests/generic/020 | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/tests/generic/020 b/tests/generic/020
> index d8648e96286e..cadfce5f45e3 100755
> --- a/tests/generic/020
> +++ b/tests/generic/020
> @@ -128,15 +128,16 @@ _attr_get_max()
>   	pvfs2)
>   		max_attrval_size=8192
>   		;;
> -	xfs|udf|9p|ceph)
> +	xfs|udf|9p)
>   		max_attrval_size=65536
>   		;;
>   	bcachefs)
>   		max_attrval_size=1024
>   		;;
> -	nfs)
> -		# NFS doesn't provide a way to find out the max_attrval_size for
> -		# the underlying filesystem, so just use the lowest value above.
> +	nfs|ceph)
> +		# NFS and CephFS don't provide a way to find out the
> +		# max_attrval_size for the underlying filesystem, so just use
> +		# the lowest value above.
>   		max_attrval_size=1024
>   		;;
>   	*)

Why not fixing this by making sure that the total length of 'name' + 
'value' == 64K instead for ceph case ?

IMO we shouldn't worry about the case that the max could be changeable, 
we just need to test the framework works well with the default is 
enough. And then print a warning if the test fails to let users to know 
that the max size must be as default, which is 64K, or if users didn't 
change it then it should be a real bug in ceph.


