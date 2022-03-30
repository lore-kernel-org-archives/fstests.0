Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA3CC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 30 Mar 2022 11:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244774AbiC3LkV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 30 Mar 2022 07:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238138AbiC3LkS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 30 Mar 2022 07:40:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F5A26548
        for <fstests@vger.kernel.org>; Wed, 30 Mar 2022 04:38:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3609CB81BBA
        for <fstests@vger.kernel.org>; Wed, 30 Mar 2022 11:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C3BC340EC;
        Wed, 30 Mar 2022 11:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648640310;
        bh=HqRQKxGRs5vKjPfLs33mXd5JmoEqV0tfXslTiVpCb4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=glVXEKHNAFlsKPtLwJ3JWq4cbvFQ/epbTKisAQNmWO8aPVesgBfnqBG42qjDyVoyV
         dSExUZVoQUvcCQJWCSKmEYOuWdJF3ebUbSL6mqvnxmY0UOCw2VrAj6o+lI1loDbWjN
         ZPmqjzj9f87OhwJLDneS3qU0zbvqTLJ6QpHONIJmHjg5esZ0DsmhTM6ZSiljVJj4VM
         aidqopDGw8Z7WNADaPKlBUpcWe8CfOetddg9xOrXGMRiJiUsUjwmz17VDSQKRQLI5F
         Hw1Azifi4PcR+m7JEQcRntRCerNAR71eDdr2MxRNv3tXdsIXEwotYvA6H7SZcYcthQ
         A7MzL5LMAf7cw==
Date:   Wed, 30 Mar 2022 13:38:24 +0200
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
Subject: Re: [PATCH v2] common: allow to run all tests on idmapped mounts
Message-ID: <20220330113824.3vbjsi4zxsoh5nfx@wittgenstein>
References: <20220330102409.1290850-1-brauner@kernel.org>
 <20220330102409.1290850-21-brauner@kernel.org>
 <CAOQ4uxid3vxXpxL25XNp7OWy9OjumHtSm7Zw3TEXO5_UHFRjnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxid3vxXpxL25XNp7OWy9OjumHtSm7Zw3TEXO5_UHFRjnA@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 30, 2022 at 02:10:11PM +0300, Amir Goldstein wrote:
> On Wed, Mar 30, 2022 at 1:26 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > In addition to the generic and filesystem-specific idmapped mount
> > testsuites that already exist upstream today add simple infrastructure
> > so any test can be run on idmapped mounts simply by setting
> > IDMAPPED_MOUNTS=true in the config file or section. The main user for
> > now will be overlay to verify it works correctly on idmapped mounts.
> >
> 
> It is not clear from this message how IDMAPPED_MOUNTS=true affects
> non -overlay runs and the answer is complicated:
> 
> You handled the majority of cases using _test_mount and _scratch_mount
> but there are still many tests that open code _mount and some helpers
> like _dmthin_mount that are used quite often.

I verified that actually for testing overlay. _dmthin_mount is used in 8
tests (btrfs/196, generic/347, generic/405, generic/455, generic/457,
generic/470, generic/482, generic/500). None of them were run in a
regular testrun on the 5.17 base kernel.
Direct _mount calls in the generic/ testsuite are 8 (generic/042,
generic/081, generic/108, generic/361, generic/459, generic/563,
generic/620, geneirc/649).
Again, none of them were run in a regular testrun on the 5.17 base
kernel. Let alone that for most of them conversion to be tested on
idmapped mounts didn't make sense.

> 
> So either document that IDMAPPED_MOUNTS=true will idmapp the
> fs mounts whenever it can as best effort, or restrict the use of
> IDMAPPED_MOUNTS=true with OVERLAY=true for now.

Just to clarify, the test patch will be upstreamed independently. It is
included here so people can run xfstests right away if they are
interested.

The infrastructure is completely generic so every filesystem that
supports idmapped mounts can simply run all of their tests idmapped. But
there will be corner-cases. For example, xfs doesn't allow bulkstat on
idmapped mounts because it is a filesystem wide operation, i.e. you can
retrieve information for any inode in the filesystem so the operation
cannot be scoped reasonably under a single mount. So xfstests testing
bulkstat will fail as it's blocked. Similar for some btrfs ioctl()s.

We could of course restrict this testmode to -overlay for which we know
things work correctly but that I don't like that as this means that
people won't start using it and so we won't see issues unless someone
sits down and goes through all 750+ tests and figures out for each
individual one why it fails the way it fails.

I'd rather not restrict the generic infrastructure so people can run and
report failures and we can fix them up or block them as we detect them.
So I'd rather just point that out in the commit message, I think.

In any case, the tests will be upstreamed in parallel but separate from
this series. :)
