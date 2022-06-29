Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162BBC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 13:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiF2NP4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 09:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiF2NPz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 09:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3344428736
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 06:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656508554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIQRrkvac/IwSZ8V5AmUtFGXO3DW5Ucw+0OiMmSkYe4=;
        b=h4ESQt27qWA6/3tNc51HH6GDzHisTsTTouphJ0MHqWP/PoKJr4Q5c5aXQgl2KfFbks+A+a
        NRbgUakN8h+70Z8OB6Qnl8O+n66FkEjSaYIz585EwyRF/BaJ4/r4wJnlQy6hnTtvcqg/tK
        jsROB/nsiO+pBRYmxtk5okWViGQQS9I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-S_ZLjBHsPQW6yhO_3IxLvQ-1; Wed, 29 Jun 2022 09:15:53 -0400
X-MC-Unique: S_ZLjBHsPQW6yhO_3IxLvQ-1
Received: by mail-qk1-f199.google.com with SMTP id m15-20020a05620a290f00b006a74cf760b2so16415632qkp.20
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 06:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zIQRrkvac/IwSZ8V5AmUtFGXO3DW5Ucw+0OiMmSkYe4=;
        b=6wnlH6aVxdLUVds6G2X1JTwdSJMFZg9N64zrI3f8YvLACN1aZWg5v1/XJdjsvzwQIR
         knZxfhbxJmb1hOQG0YeW28FiX8H1fcm50s8lHsJIh1119IOcwJCVfuuin/4BdCTrkC9g
         DJdaYwyb6sYbyMnS14bQnY/hcSs6hO+GWLNd9JVpEIWxwamlLLxz0kqSXEJ5RuCdXgzV
         6H/KyQkaaxYWZ383sJdIJLIH+gfa/HDwYH/F805VcQR9FhgW6wHpnMiNWo6RRWVXC5b5
         DB7V3RCD+KTPLlgcrDnZAjKvWVWT+duOUxKtoC/I0qPlXkq3IE8piDYT2R/yL3JZEXBW
         lp+A==
X-Gm-Message-State: AJIora+r8rYuk4gqwdtdJ57kVBJTNkEXCSc7/QJGXMoHG9Zr94xXbOfZ
        R1XG6vvUJmnVOTogYQ8paYZ147hjlsimxXDO8q/YvnOcqJ504HenS6k/QVmkRuoIL6V05Mzodhm
        JJ5rIc1HNyvAeS7l3jw==
X-Received: by 2002:a37:a7d3:0:b0:6ae:fdb9:e8e4 with SMTP id q202-20020a37a7d3000000b006aefdb9e8e4mr1889516qke.325.1656508552121;
        Wed, 29 Jun 2022 06:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1udm31nA4WHx9mZ0gxriouIJJFhRGiI/lPyPI1gHVCTjMlm6iGHUi5nT0XeNgZVpKNDt7aOKw==
X-Received: by 2002:a37:a7d3:0:b0:6ae:fdb9:e8e4 with SMTP id q202-20020a37a7d3000000b006aefdb9e8e4mr1889488qke.325.1656508551744;
        Wed, 29 Jun 2022 06:15:51 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bl10-20020a05620a1a8a00b006a67eb4610fsm13428668qkb.116.2022.06.29.06.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 06:15:51 -0700 (PDT)
Date:   Wed, 29 Jun 2022 21:15:46 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH -v3 5/7] ext4/055: skip test if dax mount option is used
Message-ID: <20220629131546.sebavcnjvmt43xgn@zlang-mailbox>
References: <20220629124540.175775-1-tytso@mit.edu>
 <20220629124540.175775-6-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220629124540.175775-6-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jun 29, 2022 at 08:45:38AM -0400, Theodore Ts'o wrote:
> This test creates a 1k block file system with the quota feature
> enabled.   As such, it is incompatible with DAX.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/ext4/055 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/ext4/055 b/tests/ext4/055
> index 8f466f1b..aa15cfe9 100755
> --- a/tests/ext4/055
> +++ b/tests/ext4/055
> @@ -26,6 +26,7 @@ _require_command "$DEBUGFS_PROG" debugfs
>  echo "Silence is golden"
>  
>  # The 1K blocksize is designed for debugfs.
> +_exclude_scratch_mount_option dax
>  _scratch_mkfs "-F -O quota -b 1024" > $seqres.full 2>&1
>  
>  # Start from 0, fill block 1 with 6，replace the original 2.
> -- 
> 2.31.0
> 

