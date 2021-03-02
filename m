Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D553AC43142
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Mar 2021 00:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAFE864FC6
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Mar 2021 00:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbhCCACW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Mar 2021 19:02:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43836 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381608AbhCBIGO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 2 Mar 2021 03:06:14 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lH01z-0000Qq-Cl; Tue, 02 Mar 2021 08:05:23 +0000
Date:   Tue, 2 Mar 2021 09:05:22 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/624: add fstests for idmapped mounts
Message-ID: <20210302080522.hdx5dveespkctwi5@wittgenstein>
References: <20210301151712.1994033-1-christian.brauner@ubuntu.com>
 <20210301173251.GA5375@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210301173251.GA5375@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 01, 2021 at 06:32:51PM +0100, Christoph Hellwig wrote:
> > +# Modify as appropriate.
> > +_supported_fs ext4 xfs
> 
> I think this should be
> 
> _supported_fs generic
> 
> now that we do the probing for the actual support, and any file system
> not supporting it will just do a _notrun from _require_idmapped_mounts.
> 
> Also the comment above this line should be dropped.

Will do.

Christian
