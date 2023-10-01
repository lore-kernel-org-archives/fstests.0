Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34344E748E9
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Oct 2023 11:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjJALv5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Oct 2023 07:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbjJALv4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 1 Oct 2023 07:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECF1D3
        for <fstests@vger.kernel.org>; Sun,  1 Oct 2023 04:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696161067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8sgnRjwVlSJC3Jbh1PUE3xy0ZYHOD7sQ7ElHVYQp3HE=;
        b=XKIo/VL7ylBNM7WUsNsynzcXxB9fL895xgXdmk3duxs5Ett0zOl4cLd5b0O0hGfs9jqxsY
        ojxxSwkk7ccdzkMTX+LFMEoI/IELIK2hOoBvnWm7R3lS8D3YKzT1zaOQQqwKyFERzMnqMP
        ezD5PXyW5Jhkigk4pM102WYHg095EME=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-6o0fO06NOmye2dKPvh_S_A-1; Sun, 01 Oct 2023 07:51:05 -0400
X-MC-Unique: 6o0fO06NOmye2dKPvh_S_A-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3ae214a02a6so33649301b6e.3
        for <fstests@vger.kernel.org>; Sun, 01 Oct 2023 04:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696161065; x=1696765865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sgnRjwVlSJC3Jbh1PUE3xy0ZYHOD7sQ7ElHVYQp3HE=;
        b=LjY1VwqiXi2/jT+s6du22o0xeuilI7EHgC0r4+r2J/6/Or8FmzOIg0pCKbPI5AkDSM
         KsFlsYpvUZz9NHTK8y1xjv+NnuLZ8QNG8px6d9XTlfSFujJL5x0HWX0rySw6KTAqoK9L
         lFrmFPHj6wtWqsZLvWKwNKI9M0EFfyTPGhc0opNcqO6l7+tAC2qI2uwkCACOyXDTHSWj
         7YVQ11YvRjLVtCPF9bYsrVsgYsSDvRTqSdLTcrcrrepIJVoQn6qEJRaQLMjylESr+XRq
         hCEtokKoOZ/NIByMKlON99B9t7aJGU4HKUbpPNIlPhpYOnA8pDE/vHi+mIBypRRYTW4J
         C1+Q==
X-Gm-Message-State: AOJu0YxWt6Fp3UDYPX+NiVDP9vI/2DXzt+atw07Mu3Ui9xoPXH3xXGi5
        QFnkqxCCFrK2udOwqd60hq8nvnnQqRUkZ+RcUS6I1IPjY8cQYZbg/ZxF/4YjWInTnjQhbh+xlpA
        /2KF9mKh6UPZ/bGCEtA==
X-Received: by 2002:a05:6808:9a3:b0:3af:6634:49b9 with SMTP id e3-20020a05680809a300b003af663449b9mr9745107oig.30.1696161065041;
        Sun, 01 Oct 2023 04:51:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDe5qBR666JBaneKAyWAZe6WAmzdhd1egCicRTZPq8AF4S8MvbttIt74I9tBmH0HFw2XLX8Q==
X-Received: by 2002:a05:6808:9a3:b0:3af:6634:49b9 with SMTP id e3-20020a05680809a300b003af663449b9mr9745092oig.30.1696161064695;
        Sun, 01 Oct 2023 04:51:04 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f54c00b001bd28b9c3ddsm20085160plf.299.2023.10.01.04.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 04:51:04 -0700 (PDT)
Date:   Sun, 1 Oct 2023 19:51:00 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2.1 1/1] xfs/{270,557,600}: update commit id for
 _fixed_by tag.
Message-ID: <20231001115100.q3v33yht334fcigy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <169567817047.2269889.16262169848413312221.stgit@frogsfrogsfrogs>
 <169567817607.2269889.5897696336492740125.stgit@frogsfrogsfrogs>
 <20230929172801.GB21283@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929172801.GB21283@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Sep 29, 2023 at 10:28:01AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Update the commit id in the _fixed_by tag now that we've merged the
> kernel fixes.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Thanks, this version is good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/xfs/270 |    2 +-
>  tests/xfs/557 |    2 +-
>  tests/xfs/600 |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/xfs/270 b/tests/xfs/270
> index 7d4e1f6a87..4e4f767dc1 100755
> --- a/tests/xfs/270
> +++ b/tests/xfs/270
> @@ -17,7 +17,7 @@ _begin_fstest auto quick mount
>  
>  # real QA test starts here
>  _supported_fs xfs
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit 74ad4693b647 \
>  	"xfs: fix log recovery when unknown rocompat bits are set"
>  # skip fs check because superblock contains unknown ro-compat features
>  _require_scratch_nocheck
> diff --git a/tests/xfs/557 b/tests/xfs/557
> index 522c4f0643..01205377b7 100644
> --- a/tests/xfs/557
> +++ b/tests/xfs/557
> @@ -18,7 +18,7 @@ _require_xfs_io_command "falloc"
>  _require_xfs_io_command "bulkstat_single"
>  _require_scratch
>  
> -_fixed_by_kernel_commit XXXXXXXXXXXX \
> +_fixed_by_kernel_commit 817644fa4525 \
>  	"xfs: get root inode correctly at bulkstat"
>  
>  # Create a filesystem which contains a fake root inode
> diff --git a/tests/xfs/600 b/tests/xfs/600
> index 56af634a7c..e6997c53d1 100755
> --- a/tests/xfs/600
> +++ b/tests/xfs/600
> @@ -20,7 +20,7 @@ _begin_fstest auto quick fsmap
>  
>  . ./common/filter
>  
> -_fixed_by_git_commit kernel XXXXXXXXXXXXX \
> +_fixed_by_git_commit kernel cfa2df68b7ce \
>  	"xfs: fix an agbno overflow in __xfs_getfsmap_datadev"
>  
>  # Modify as appropriate.
> 

