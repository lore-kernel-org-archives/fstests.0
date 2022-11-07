Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F9BC433FE
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Nov 2022 10:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiKGKyK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Nov 2022 05:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiKGKyJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Nov 2022 05:54:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF691082
        for <fstests@vger.kernel.org>; Mon,  7 Nov 2022 02:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667818395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bBH9bkxz89XttPnFbyTNBZMe1Y97uDZ/jyPp27K1H7k=;
        b=iVPF1JxL+O5O7zDDutx9E47naXxrb3VT2ButC4L86ZFIAZ3saKR/aF9nWC5j5KuN6xZHGB
        zlFNzLKioPM6gE38eqDId0DvXKpmii4VM5PJUVRfBtCiJ+btYMbCj7J6F2GIOEJ1iY6OxG
        y1TfgSfMWLcYCB4tXd5Te4ADKihKZww=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-605-mYLYcTuoM2KxutneafsWpg-1; Mon, 07 Nov 2022 05:53:13 -0500
X-MC-Unique: mYLYcTuoM2KxutneafsWpg-1
Received: by mail-ej1-f72.google.com with SMTP id gt15-20020a1709072d8f00b007aaac7973fbso6189176ejc.23
        for <fstests@vger.kernel.org>; Mon, 07 Nov 2022 02:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBH9bkxz89XttPnFbyTNBZMe1Y97uDZ/jyPp27K1H7k=;
        b=4cdneCTLF414VgQBA2aL5dtdU1psvS4UOnF8ZctthR68ajdG/mlFW9Nkfz1aN4qLRH
         oCfXgsqR4r7OtumUmQTCBRN2BG3B44yCiQpwTKlpCLf4bXsKnNenk/azS/19tfqvhE7g
         /e46Q9EVXDD61P8B1QnPFU96wCidgbTd7aPTyiZzttKakerpZjLudLLTv/ZOMbSt6gkK
         Btq47t5E5xajF/J2QRy7DgMKwDHw/uEWGF6eDL6AyjnqLeCAICUgEqfd2GAoqBOKF1yJ
         25nN8cs4dTEewwSZ7l/0e8sJ6eU/w2paL6xlrPhmA7eFZ8wSddgzweg2qmUxZHYLg1bj
         8xZA==
X-Gm-Message-State: ANoB5plyRvfONIk311loL/I+yFofwGuu/mdh+8v2+zT5Njg5iNFoiN9O
        qr5Xosn09tZYJZVUzlu48Bgj7giArFQIlf8GhNzgKSPv52Xc6bspH/CVxutIFpRB6nv4vjiEgqp
        UdKVPBngfhzuOSs2b
X-Received: by 2002:a17:906:d89:b0:7ae:6ba5:f324 with SMTP id m9-20020a1709060d8900b007ae6ba5f324mr3286349eji.299.1667818392463;
        Mon, 07 Nov 2022 02:53:12 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5TAMCHnXphi1w7WQOmF+OKizuLSEavYvn240ecj25BBAgHTUo0AHL6niOQhgMnl6lGEew5Jg==
X-Received: by 2002:a17:906:d89:b0:7ae:6ba5:f324 with SMTP id m9-20020a1709060d8900b007ae6ba5f324mr3286336eji.299.1667818392277;
        Mon, 07 Nov 2022 02:53:12 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906329500b00782ee6b34f2sm3187177ejw.183.2022.11.07.02.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 02:53:11 -0800 (PST)
Date:   Mon, 7 Nov 2022 11:53:09 +0100
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic: check logical-sector sized O_DIRECT
Message-ID: <20221107105309.khksga5m7p766sed@aalbersh.remote.csb>
References: <20221107045618.2772009-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107045618.2772009-1-zlang@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 07, 2022 at 12:56:18PM +0800, Zorro Lang wrote:
> If the physical sector size is 4096, but the logical sector size
> is 512, the 512b dio write/read should be allowed.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---

Looks good to me.
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

