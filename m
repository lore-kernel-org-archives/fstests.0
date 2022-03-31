Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6DCC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Mar 2022 11:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbiCaLnZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Mar 2022 07:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiCaLnY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Mar 2022 07:43:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DC2166E16
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 04:41:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76D25B820C2
        for <fstests@vger.kernel.org>; Thu, 31 Mar 2022 11:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9FFC340ED;
        Thu, 31 Mar 2022 11:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648726894;
        bh=oOxz922AA2TBs0/v24wFJ/a7T+ppVceKL/0nw2l3504=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CvZcMcttdBKXJFd7xhsewYOdCVE9lsiY5Ry5HrTvyBWzdZ9Lzj8wwVB3oPj3q/tAw
         zYIdleb9r8Inda6mNTReMcoe/EL+zVraqCbXI5/AgBgb2fN8h/X3C0P/KNIIwHxMo4
         uIdNBnPt4scktrut5QjsugNjMnR3bB+HzlHV9/CDLOue1uCcXgpKb9I1l3oYuzsVL1
         hRl/oAFC5pAM+uVbiTYNLmdyXMiFugqEGyL0iXb65g8PuFDYm9KJhPAZrlToRPp7sF
         utQWtuWPmZB4DitwrN71ETEqcDOJC855vQxa70dF51WVlKh5RGIvRdDDNqhaTF3HBH
         9uKEFV/tuDdAw==
Date:   Thu, 31 Mar 2022 13:41:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, Eryu Guan <guan@eryu.me>,
        fstests <fstests@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos Catelin <rodrigo@sdfg.com.ar>,
        Seth Forshee <sforshee@digitalocean.com>,
        Luca Bocassi <luca.boccassi@microsoft.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH v3] common: allow to run all tests on idmapped mounts
Message-ID: <20220331114128.6j7lnp2h6f5ip4rf@wittgenstein>
References: <20220331112318.1377494-1-brauner@kernel.org>
 <20220331112318.1377494-21-brauner@kernel.org>
 <CAOQ4uxj-EndoH7ZT=sWRJ4VpXDXW4AyrFYByug7bYqria7LMPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj-EndoH7ZT=sWRJ4VpXDXW4AyrFYByug7bYqria7LMPw@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Mar 31, 2022 at 02:35:55PM +0300, Amir Goldstein wrote:
> On Thu, Mar 31, 2022 at 2:25 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > In addition to the generic and filesystem-specific idmapped mount
> > testsuites that already exist upstream today add simple infrastructure
> > so any test can be run on idmapped mounts simply by setting
> > IDMAPPED_MOUNTS=true in the config file or section. The main user for
> > now will be overlay to verify it works correctly on idmapped mounts.
> >
> > Note that the infrastructure is completely generic so every filesystem that
> > supports idmapped mounts can simply run all of their tests idmapped. But
> > note that not all ways to create a mount have been converted yet. That
> > includes e.g. _dmthin_mount and direct calls to _mount in various tests.
> >
> > In addition, there will be corner-cases. For example, xfs doesn't allow
> > bulkstat on idmapped mounts because it is a filesystem wide operation,
> > i.e. you can retrieve information for any inode in the filesystem so the
> > operation cannot be scoped reasonably under a single mount. So xfstests
> > testing bulkstat will fail as it's blocked. Similar for some btrfs
> > ioctl()s.
> >
> > While we could of course restrict this testmode to -overlay for which we
> > know things work correctly we should not do this. It would mean that
> > people won't start using it and so we won't see issues unless someone
> > sits down and goes through more than 1000 tests and figures out for each
> > individual one whether it needs to be skipped or not.
> >
> > So instead allow this mode but for all filesystems so people can start
> > running and reporting failures and we can fix them up or block them as
> > we detect them.
> >
> > Cc: Amir Goldstein <amir73il@gmail.com>
> > Cc: Eryu Guan <guaneryu@gmail.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: <fstests@vger.kernel.org>
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> > /* v2 */
> > unchanged
> >
> > /* v3 */
> > - Amir Goldstein <amir73il@gmail.com>:
> >   - Add more detailed explanation about the current state and
> >     expectations of the newly added IDMAPPED_MOUNTS support.
> 
> Please document the new envvar in README with a *short* disclaimer
> about expectations with and without -overlay and please add an [idmapped]
> section to the multi section config example in README.overlay.
> 
> Sorry if I wasn't clear about what better documentation of expectations
> the text in the commit message is important but is no replacement for
> documentation.

Will do. Since I'm upstreaming the patch separately I will hold off on
resending because of this. Instead I'll start upstreaming this in
parallel.

Thanks!
