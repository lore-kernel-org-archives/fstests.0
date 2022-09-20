Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE3FECAAD8
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 14:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiITOmo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 10:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiITOmn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 10:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD98F3A164
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663684962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WhmIpCzv2y9ufK4zFJtCfk9Hl85NSbftTdDsd4D0f8A=;
        b=OpI2/qJg4zrXElfG7YPSAXYpzpIsD3qdSqHiHiOy3KCMkRrIs42Y8ZANIgLPcyk/gxAoc5
        J3XG0tEBOf6BDfspMNGm76pCxYHYuQZ39rSfwjDG0axOXUF2igbIkR0fR3M++8x8a+mAU2
        e3IW2pGRiikUcNJXaBMuN614bmee8Kc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-617-LBA5PXzLMJOoo0pxvgj28g-1; Tue, 20 Sep 2022 10:42:40 -0400
X-MC-Unique: LBA5PXzLMJOoo0pxvgj28g-1
Received: by mail-qk1-f198.google.com with SMTP id bs33-20020a05620a472100b006cef8cfabe2so2082670qkb.12
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 07:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=WhmIpCzv2y9ufK4zFJtCfk9Hl85NSbftTdDsd4D0f8A=;
        b=P0hS0yJiUh7mhQi+47l+Yw22BbetYHQKypZ9SfUDcQroIXFVim0/XeJ4qz8nEGQzoz
         MSWV8+to/9g5t8Maqd2pUBsln6ERssn1oXJq9waxQGuT7cbDjnqCcQQRQzLeCL+iWIUb
         ZWBfjG2IIZ952kUXKV2stZT+45eJA/EAs5s1vrkdvbeEOUA5xv2Gfi1OaTImDJdnK3pA
         zqrx70tQlFGCTKtkn/OSXOl36++gSNRCvrThXFTmobUisP87ujDlkR84XilFt/hQ3FzI
         9rqtuNqtj7xrWAJ9gfEKJ4PZHMMUdqbHQdpbb4bUf+xzISwXtAl7UGQP3RJ8bSyqR0ly
         WGrQ==
X-Gm-Message-State: ACrzQf16AED/Qe8pz3thEWAT3TFlkf0dSpNxs8CL+lsWUisR5cTYEx9a
        fENWs6A9TfuCZRIOuy+TMLGyjmwiB/ITVPhtY/QCkk0IdO+DOAmGcf4uHJwpnGYuheUYuI8BOQu
        kZKQMEBKfF8DRL7Xw2Q==
X-Received: by 2002:a05:6214:21aa:b0:4ad:1e9c:e6d5 with SMTP id t10-20020a05621421aa00b004ad1e9ce6d5mr14882577qvc.73.1663684960065;
        Tue, 20 Sep 2022 07:42:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5vmdQTuB8QU0rV0eqFI9m42mlAas/5P5vgHzXUVek9Evj0Pey3SGtk0izPOfUP+zAD+odHNg==
X-Received: by 2002:a05:6214:21aa:b0:4ad:1e9c:e6d5 with SMTP id t10-20020a05621421aa00b004ad1e9ce6d5mr14882553qvc.73.1663684959849;
        Tue, 20 Sep 2022 07:42:39 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o24-20020a05620a229800b006ce515196a7sm1433qkh.8.2022.09.20.07.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:42:39 -0700 (PDT)
Date:   Tue, 20 Sep 2022 22:42:34 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Seth Forshee <sforshee@kernel.org>, Zorro Lang <zlang@kernel.org>,
        Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH] idmapped-mounts: account for EOVERFLOW
Message-ID: <20220920144234.tbajutllmoicpme3@zlang-mailbox>
References: <20220920083522.1291798-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920083522.1291798-1-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 20, 2022 at 10:35:22AM +0200, Christian Brauner wrote:
> We introduced a new type vfs{g,u}id_t into the vfs in b27c82e12965
> ("attr: port attribute changes to new types"). This type makes sure that
> {g,u}ids mapped into an idmapped mount are distinct from regular
> k{g,u}id_t. This expands the possible errnos that users may see so we
> need to handle both EINVAL and EOVERFLOW.
> 
> Cc: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---

Make sense to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/vfs/idmapped-mounts.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
> index c010dfa1..ed7948b6 100644
> --- a/src/vfs/idmapped-mounts.c
> +++ b/src/vfs/idmapped-mounts.c
> @@ -7367,7 +7367,7 @@ static int setattr_fix_968219708108(const struct vfstest_info *info)
>  		 */
>  		if (!fchownat(open_tree_fd, FILE1, 0, 0, AT_SYMLINK_NOFOLLOW))
>  			die("failure: change ownership");
> -		if (errno != EINVAL)
> +		if (errno != EINVAL && errno != EOVERFLOW)
>  			die("failure: errno");
>  
>  		/*
> @@ -7457,7 +7457,7 @@ static int setattr_fix_968219708108(const struct vfstest_info *info)
>  		 */
>  		if (!fchownat(open_tree_fd, FILE1, 0, 0, AT_SYMLINK_NOFOLLOW))
>  			die("failure: change ownership");
> -		if (errno != EINVAL)
> +		if (errno != EINVAL && errno != EOVERFLOW)
>  			die("failure: errno");
>  
>  		/*
> 
> base-commit: 890c50823b6430bf0929d9a57e76b9b4d6bbc25f
> -- 
> 2.34.1
> 

