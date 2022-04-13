Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455A9C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 13 Apr 2022 07:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiDMHvo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Apr 2022 03:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbiDMHvm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Apr 2022 03:51:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739FA25B
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 00:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 154CE6152B
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 07:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED65C385A3;
        Wed, 13 Apr 2022 07:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649836160;
        bh=Z49xQzK6kXvOom3beN2dL+PoC/ySrrhNfbUfOEZSKxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQkz/tF0E7svGRWJU8QQvdQUyzu8Mq7zqGPthvPo3N5MNpwCEUBQ/HuWOZoizWLb7
         jZNjylCWPuovhomGPh1uATSM4bIa47u2HBTy20grV0QAfBSLTNMoMFHSn+xgQarVVC
         H4MQsA24Qdxevv8y20u1ZrOzgu6sHE42FmpYJhJRQLxBy1Si7K4imgLdR0fS+7KmO6
         GlXr+jeXe5ZJmq6glIPdep168Eqi6NvJaTqxq+hgiu5jUV0k3HskRroDrPUCqPI1WS
         1goNdZwo9BDZoHHEf6otI5+rzm1dVHpfxL2m63d9lEgg8soV6Qj96bIG29ri8DbM94
         vqw3BV2GlHqEg==
Date:   Wed, 13 Apr 2022 09:49:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v5] common: allow to run all tests on idmapped mounts
Message-ID: <20220413074910.rwoi4njgsgt4ogxe@wittgenstein>
References: <20220407112157.1775081-1-brauner@kernel.org>
 <20220407112157.1775081-21-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220407112157.1775081-21-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 07, 2022 at 01:21:57PM +0200, Christian Brauner wrote:
> In addition to the generic and filesystem-specific idmapped mount
> testsuites that already exist upstream today add simple infrastructure
> so any test can be run on idmapped mounts simply by setting
> IDMAPPED_MOUNTS=true in the config file or section. The main user for
> now will be overlay to verify it works correctly on idmapped mounts.
> 
> Note that the infrastructure is completely generic so every filesystem that
> supports idmapped mounts can simply run all of their tests idmapped. But
> note that not all ways to create a mount have been converted yet. That
> includes e.g. _dmthin_mount and direct calls to _mount in various tests.
> 
> In addition, there will be corner-cases. For example, xfs doesn't allow
> bulkstat on idmapped mounts because it is a filesystem wide operation,
> i.e. you can retrieve information for any inode in the filesystem so the
> operation cannot be scoped reasonably under a single mount. So xfstests
> testing bulkstat will fail as it's blocked. Similar for some btrfs
> ioctl()s.
> 
> While we could of course restrict this testmode to -overlay for which we
> know things work correctly we should not do this. It would mean that
> people won't start using it and so we won't see issues unless someone
> sits down and goes through more than 1000 tests and figures out for each
> individual one whether it needs to be skipped or not.
> 
> So instead allow this mode but for all filesystems so people can start
> running and reporting failures and we can fix them up or block them as
> we detect them.
> 
> Cc: Eryu Guan <guaneryu@gmail.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: <fstests@vger.kernel.org>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---

Hey Miklos,
hey Amir,

Just a quick update: Please note that this commit is now available in
upstream xfstests already as of last Sunday:

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=4a7b35d7a76cd993ad7a62fd180e00589c73ac4b

which means xfstests can run on the whole patchset directly.

Thanks!
Christian
