Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD74C77B7D
	for <linux-fstests@archiver.kernel.org>; Thu, 18 May 2023 05:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjERF01 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 May 2023 01:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjERF00 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 May 2023 01:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5763A96
        for <fstests@vger.kernel.org>; Wed, 17 May 2023 22:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684387532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XgjDn/fMn2KTsPrGr1IM2peFSMqoGe+HeOm/AiE4UBk=;
        b=Q67zZT7RfO+npppT+srDf3+OOvktFu75mU01p+uTOXqp7CYR6SVUPKyBAA/U/8qgI8+d/q
        bAuar//5VNWiJA3jCK065M3/MyoY1hkfSJfYInoqGnJuFSGU2Ew90UjaUoycCNGFDpd6Id
        S+7gZQz3v8FGb2ifwgG1rvC0AtvkdjY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-ThbQNy_TObeNHQiH0XY9Gg-1; Thu, 18 May 2023 01:25:30 -0400
X-MC-Unique: ThbQNy_TObeNHQiH0XY9Gg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-530a5ad74e0so954915a12.2
        for <fstests@vger.kernel.org>; Wed, 17 May 2023 22:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684387530; x=1686979530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgjDn/fMn2KTsPrGr1IM2peFSMqoGe+HeOm/AiE4UBk=;
        b=RmQD2BVHARbIOEX/EOoJZGSUJ5mnsrlA+5qRR50KX4afhr76ndMHUuX+0Z6TB0rcGV
         Dayc9KSO5M5PAtVPsIv3u8R5ctbVoEL6Wm6G60nNA0l+/ED+O1elXqcscfAD8PoLpoN+
         B+5l201CZ4ijhhZiZfWbVXoP0QmdUVvF8lcsWatJRUrI2viYu6k/WrZB+4qsrcyqIckI
         TqKUvPb7a14aQJCwGFc7xA+NACg6TZpQJU3xcwvyAeju+rz0zIPgI/gH5eiOShfJWVRS
         gTeoQnu5sm3A7ju0uz0S7iR4Ds96uGBx5AxBjqtFeGZt2XbtB9gbGTZmgjLAa0NHEMM4
         xMPA==
X-Gm-Message-State: AC+VfDyxfx+RdAdaIIrsaj+vVyu8EbcpHswjRNwmlUrGuOZ5B4n7Y6Pa
        kTxrdZuiit90xyzXY8uxIPyWBhVQcbDGR+6wpg8jIwJYT/z6Inwc7ffvv+iLhEl5ZpsTTkUsXC0
        xWXrdPZW7ITm/3fmO8g==
X-Received: by 2002:a05:6a21:6da9:b0:101:457:c687 with SMTP id wl41-20020a056a216da900b001010457c687mr1149751pzb.20.1684387529861;
        Wed, 17 May 2023 22:25:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7T/jB8RExJYkHCtr4EJfPn00TyB+0UIDeZc2b6eY6r+YEAtuXYp+TZgyT+XhHQFCjrcB12wQ==
X-Received: by 2002:a05:6a21:6da9:b0:101:457:c687 with SMTP id wl41-20020a056a216da900b001010457c687mr1149730pzb.20.1684387529496;
        Wed, 17 May 2023 22:25:29 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p37-20020a631e65000000b005143448896csm361081pgm.58.2023.05.17.22.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 22:25:29 -0700 (PDT)
Date:   Thu, 18 May 2023 13:25:24 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org, fstests@vger.kernel.org,
        Anand Jain <anand.jain@oracle.com>
Subject: Re: [PATCH v3] generic/728: Add a test for xattr ctime updates
Message-ID: <20230518052524.dzoniitzq72hkzyx@zlang-mailbox>
References: <20230516141407.201674-1-anna@kernel.org>
 <c4b7915a-0bb7-178e-0258-fe24ee3359df@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4b7915a-0bb7-178e-0258-fe24ee3359df@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 17, 2023 at 01:04:59PM +0800, Anand Jain wrote:
> On 16/5/23 22:14, Anna Schumaker wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > 
> > The NFS client wasn't updating ctime after a setxattr request. This is a
> > test written while fixing the bug.
> 
> You can include the '_fixed_by_kernel_commit' field for hints

Anna said the related kernel commit hasn't been acked. I'm not sure what's the
current status, if it's acked but not merged, Anna can use "xxxxxxxx" to replace
the commit id temporarily, or add this later (just don't forget:)

Thanks,
Zorro

> on unfixed kernels. With this and Darrick's suggestions, you
> can add my RB.
> 
>  Reviewed-by: Anand Jain <anand.jain@oracle.com>
> 
> 

