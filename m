Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B6EE743E1
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Sep 2023 05:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjI2FXz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 29 Sep 2023 01:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjI2FXy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Sep 2023 01:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E641A2
        for <fstests@vger.kernel.org>; Thu, 28 Sep 2023 22:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695964986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rT7q5ABhiXi4cAWfRmu0uabBW3kY7SYwhq6pFjVOpGs=;
        b=dJQLOIlFSeZdsJXGh7KW6lqz5gJfxLNBLNQZEZqVf4hF3p9GK7+1x9Y6ITkNrGmfh/TZkE
        FaLoFF9uxEKOPtzkrzFtukU68o1ok3gJrrZ6oIDe57/62i1kAQxpkL8Dx0KEEYDV1H1XD/
        CpeBPrX5T5pBMLrUpFugUhTIWdOOmIo=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-cgUo8fLgMSC26OTVB3C-mg-1; Fri, 29 Sep 2023 01:23:04 -0400
X-MC-Unique: cgUo8fLgMSC26OTVB3C-mg-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6c0f174540cso28163990a34.2
        for <fstests@vger.kernel.org>; Thu, 28 Sep 2023 22:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695964983; x=1696569783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rT7q5ABhiXi4cAWfRmu0uabBW3kY7SYwhq6pFjVOpGs=;
        b=AaIAVA4/oBEMLnggij8PSH9YORecGhfO6TYT6kPXloXWFKhuDYnUlbbxcclhaBhOCB
         Pc81KI4lviLkBOF/Vu34hdM2Vlg23p8I03f5LwacROOtFau7giXq0cnx7vpOzrysDyCl
         EPjeNxZqNnOl1A5SpfSnNuKsue0DJ16UF59Ckl/NEueDbHEGNIZ1RlarMdwSVs1/PSQI
         pZC1sOPE0QjqQGgKWLB00ydZmv0pYs0yHPVN1ctfaIQ4A0A5Mb3GknPE3sv61VB7DrKT
         CYbjCYTyg/PNyxVTSHn5FHJO5qSXw7kSoWsQNAq3XD8IfpcosgEuvXYUPI1lszyNyIKm
         xOZw==
X-Gm-Message-State: AOJu0Yy6cqLCuBoObO+xt9Es51dvWNUd/fl0Begj20ynrCHeWmwCUe/0
        0q5HlAEzYIdXNyPyzH2H0k8LPnTQ/3kOO+x+cGXhZrrIDfI/0G+L6sov9GtjRVHrK9uTJ4MnPod
        gj/B9vAEO00ND4I9AAQ==
X-Received: by 2002:a05:6830:124b:b0:6bd:ba2c:fbbd with SMTP id s11-20020a056830124b00b006bdba2cfbbdmr3472491otp.20.1695964983529;
        Thu, 28 Sep 2023 22:23:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiwhdDJHiM0VK32TkOIKuqOf5Pa+JVy4+/rQWRgR5FJFhd0Ro7XD8L+LRUodOp+KHLh3FXqw==
X-Received: by 2002:a05:6830:124b:b0:6bd:ba2c:fbbd with SMTP id s11-20020a056830124b00b006bdba2cfbbdmr3472486otp.20.1695964983268;
        Thu, 28 Sep 2023 22:23:03 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p27-20020a63741b000000b0056c2de1f32esm11863594pgc.78.2023.09.28.22.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 22:23:02 -0700 (PDT)
Date:   Fri, 29 Sep 2023 13:22:59 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 1/1] xfs/270: update commit id for _fixed_by tag.
Message-ID: <20230929052259.7umlz236g3o4su6r@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <169567817047.2269889.16262169848413312221.stgit@frogsfrogsfrogs>
 <169567817607.2269889.5897696336492740125.stgit@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169567817607.2269889.5897696336492740125.stgit@frogsfrogsfrogs>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Sep 25, 2023 at 02:42:56PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Update the commit id in the _fixed_by tag now that we've merged the
> kernel fix.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  tests/xfs/270 |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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

This patch is good to me, but we have more xfs cases have fixed commit which
have been merged:

$ grep -rsni xxxxxxxx tests/xfs|grep _fixed
tests/xfs/600:23:_fixed_by_git_commit kernel XXXXXXXXXXXXX \
tests/xfs/557:21:_fixed_by_kernel_commit XXXXXXXXXXXX \
tests/xfs/270:20:_fixed_by_kernel_commit xxxxxxxxxxxx \

xfs/600: cfa2df68b7ce xfs: fix an agbno overflow in __xfs_getfsmap_datadev
xfs/557: 817644fa4525 xfs: get root inode correctly at bulkstat

Do you want to fix them in one patch, or you hope to merge this
patch at first?

Thanks,
Zorro


>  # skip fs check because superblock contains unknown ro-compat features
>  _require_scratch_nocheck
> 

