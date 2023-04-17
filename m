Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54054C77B61
	for <linux-fstests@archiver.kernel.org>; Mon, 17 Apr 2023 04:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDQESw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 17 Apr 2023 00:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDQESr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Apr 2023 00:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E0526BB
        for <fstests@vger.kernel.org>; Sun, 16 Apr 2023 21:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681705079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gTKZwDH0IFVf7f2p+Aqnass2h7qOP94Q4Xm+kge/09I=;
        b=QtWthj5emDTj2WBYNqCdZYiczfdmzCWuQ7joig5vOB0i+hlMbjTXEcZpHVMeeNA0hDaeMD
        HQzQfR/M8I1vUvbkUPpk/fZmyd6P2VHKE3uw0+Ian+sTiDaNxdPFRw1hmnpA+4FTRZaDFf
        r5g8qB23dSL7bgxWqerwUIUnDWq2TGo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-rd0pocOvOxqYwd44mjmCWg-1; Mon, 17 Apr 2023 00:17:58 -0400
X-MC-Unique: rd0pocOvOxqYwd44mjmCWg-1
Received: by mail-pj1-f69.google.com with SMTP id q88-20020a17090a17e100b00244b0813a68so8550257pja.9
        for <fstests@vger.kernel.org>; Sun, 16 Apr 2023 21:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681705077; x=1684297077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTKZwDH0IFVf7f2p+Aqnass2h7qOP94Q4Xm+kge/09I=;
        b=MmGIZRNRl4ir8TQ7xsQs7S+dOsPZHD3lBhppnMzOGoiuEB/siKMXCsGvSYctVsP8pm
         NEwgdc65s+6pgOseKrUM3N3IAqoLuqaXNxtPMmXtkLWl48J5n5usoFoJ9D9aaR/jSOPw
         h2gEtpz2UNJ1aZlxGKemAzdEnLjxFNra3ywOcdZgCneqvEzidDJZRhvt7jxKSvGrajmI
         W2n0k+7VNKh/1F6fT7c76uA89OzqMuZm5EnAGXFE7Lbz96HjpUnSnY4UUfPBXKM3h73k
         zg1tfAOBbUe7i02cws6QLcNgOeGAVTe6DgAgYbci+0cdxhPEmXDFBTEU5HGLmQIhkoVn
         ps3A==
X-Gm-Message-State: AAQBX9fSzbl+SaumsoTg/Oqyoq1dy1Vqj1PObSJfqBcwn1/5rHjxG1Mr
        0n47/Rsl3Kl5wuBGJ32DLrbBiM4i+QUeol/8i0PNU+IUbNgHRrmKoYyPIsp6j1k16hiZvJMWzcL
        LdYUH1Fq7XzpizsHdfBWfnvW9ikjYJJg=
X-Received: by 2002:a17:902:d508:b0:1a6:8548:e0ac with SMTP id b8-20020a170902d50800b001a68548e0acmr10761456plg.34.1681705077152;
        Sun, 16 Apr 2023 21:17:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZbKjyLtyvNF+IoVxnJ78aDG00iKDfpupyVF+feaHzci55dnAf9h4gXD1Bb9MojQnYAr2r5sg==
X-Received: by 2002:a17:902:d508:b0:1a6:8548:e0ac with SMTP id b8-20020a170902d50800b001a68548e0acmr10761445plg.34.1681705076791;
        Sun, 16 Apr 2023 21:17:56 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m7-20020a1709026bc700b0019a5aa7eab0sm6582990plt.54.2023.04.16.21.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 21:17:56 -0700 (PDT)
Date:   Mon, 17 Apr 2023 12:17:52 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     xiubli@redhat.com
Cc:     fstests@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH] common/rc: skip ceph when atime is required
Message-ID: <20230417041752.lryihlt7atnljfzo@zlang-mailbox>
References: <20230417024134.30560-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417024134.30560-1-xiubli@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 17, 2023 at 10:41:34AM +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> Ceph won't maintain the atime, so just skip the tests when the atime
> is required.
> 
> URL: https://tracker.ceph.com/issues/53844
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  common/rc | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 90749343..3238842e 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3999,6 +3999,9 @@ _require_atime()
>  	nfs|cifs|virtiofs)
>  		_notrun "atime related mount options have no effect on $FSTYP"
>  		;;
> +	ceph)
> +                _notrun "atime not maintained by $FSTYP"

Make sense to me. I'll change this line a bit when I merge it, to keep the line
aligned (with above).

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> +		;;
>  	esac
>  
>  }
> -- 
> 2.39.1
> 

