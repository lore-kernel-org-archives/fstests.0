Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8253C433DB
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Mar 2021 23:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A7564F1A
	for <linux-fstests@archiver.kernel.org>; Tue,  2 Mar 2021 23:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhCBXva (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 2 Mar 2021 18:51:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:43010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239556AbhCBBoP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 1 Mar 2021 20:44:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F4066148E;
        Tue,  2 Mar 2021 01:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614649414;
        bh=kgFFaRgWA+f5IvNapXWcpMhg008iZxZT2C+/ZKX/7w8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VmNzxPwfOPD5XpI6MzKpSvri34VStDGXDdX8qzIm2+I9ce1JTpEb9mb+M8rcZ1r6k
         c7mPz5E8Nh4ZtghmZTNgoEWK5fV5ZfXYG9obIbmt8JpSt6EHSEAMCZkvjoUTuICDNQ
         6ipo+zga+zlr+1Pd4CM36djvuhmgjkRZBTUyw8Prra0cljvlgbZixrGYOXpD+1FHS9
         u4pA7MQ7g1iZNEWRilxb4JEu13k1CA5PmSBvMHCGgmTxrzUF1uRFgC2L9e8/sGoq9S
         EL+PGKXH7pssmEmDS0jvI8ge0s6J9R0a5R2DhORMdbT94dGbxPF0tNAk9nLT0fgnCN
         kiMLECptr8u1g==
Date:   Mon, 1 Mar 2021 17:43:33 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        fstests@vger.kernel.org
Subject: Re: [PATCH] generic/624: add fstests for idmapped mounts
Message-ID: <20210302014333.GF7269@magnolia>
References: <20210301151712.1994033-1-christian.brauner@ubuntu.com>
 <20210301173251.GA5375@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

The rest of this series still hasn't shown up in my inbox...

...but I did wonder, have you all tested file creation with idmapped
mounts and quotas enabled?  I noticed after the fact (sorry...) that
the dqalloc call just prior to creating the inode still uses
current_fs[ug]id() and not the fs[ug]id_into_mnt() call that the
conversion series uses.

(The fact that xfs access the ids once for quota and again when actually
creating the inode is screaming for a cleanup, by the way...)

--D
