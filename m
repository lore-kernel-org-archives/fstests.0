Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0535BC433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  4 Apr 2022 12:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240989AbiDDMxc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 4 Apr 2022 08:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbiDDMxb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Apr 2022 08:53:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3C66272
        for <fstests@vger.kernel.org>; Mon,  4 Apr 2022 05:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63057611E8
        for <fstests@vger.kernel.org>; Mon,  4 Apr 2022 12:51:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36AAC2BBE4;
        Mon,  4 Apr 2022 12:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649076694;
        bh=3nNpQwqMvqjUMtIwHREY96coxWnTvfPo4gI15TZJ5Ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQ5prZHou6/NooaKQ2YsoIxpsy+jCuvJ/YXt7lcGA+ru5NRiYv4YIeAN6IJ0rNSY7
         9DSVUowmPqcWyAtY87mDNg88aAutfCX5jK8G3kWGKU/JalPauGQHEbU6w/lMt0k6uP
         MpWILdmjtXotBbOASebrsiV/4NyoYWqeNI1J++sgGUX1uymO1+SyKFAoPPDpHhYJ/S
         LDOypUxz7eRz/AMhwpmNiUG4P1JLz+kurhINPbY9hx5NX+okIhf/WqMYHPggWFKvzj
         oCPI/tElF/ble6MKOL+UxtZQzl2LC2eLf4BE60GpdxdkTLnZetWSH65Y+4iwthSZwx
         kwno6f1iEnkFg==
Date:   Mon, 4 Apr 2022 14:51:28 +0200
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
Subject: Re: [PATCH v4] common: allow to run all tests on idmapped mounts
Message-ID: <20220404125128.uecs4chv6amfyb6d@wittgenstein>
References: <20220404105159.1567595-1-brauner@kernel.org>
 <20220404105159.1567595-21-brauner@kernel.org>
 <CAOQ4uxgW75aqHTPyOqYPPjS1hX8ANzu2K3j89HyFxrK587d+wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgW75aqHTPyOqYPPjS1hX8ANzu2K3j89HyFxrK587d+wg@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 04, 2022 at 03:41:17PM +0300, Amir Goldstein wrote:
> On Mon, Apr 4, 2022 at 1:55 PM Christian Brauner <brauner@kernel.org> wrote:
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
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> one nit below could be addressed later.
> 
> > ---
> > /* v2 */
> > unchanged
> >
> > /* v3 */
> > - Amir Goldstein <amir73il@gmail.com>:
> >   - Add more detailed explanation about the current state and
> >     expectations of the newly added IDMAPPED_MOUNTS support.
> >
> > /* v4 */
> > - Amir Goldstein <amir73il@gmail.com>:
> >   - Document new IDMAPPED_MOUNTS env variable in README and add an
> >     [idmapped] section to README.overlay.
> > ---
> >  README         |  5 +++++
> >  README.overlay |  6 +++++-
> >  common/config  |  1 +
> >  common/overlay |  2 ++
> >  common/rc      | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 63 insertions(+), 1 deletion(-)
> >
> > diff --git a/README b/README
> > index 9f01aa10..0f98035c 100644
> > --- a/README
> > +++ b/README
> > @@ -78,6 +78,11 @@ Preparing system for tests:
> >              - setenv TEST_LOGDEV "device for test-fs external log"
> >               - setenv TEST_RTDEV "device for test-fs realtime data"
> >               - if TEST_LOGDEV and/or TEST_RTDEV, these will always be used.
> > +             - set IDMAPPED_MOUNTS=true to run all tests on top of idmapped
> > +               mounts. While this option is supported for all filesystems
> > +               currently only -overlay is expected to run without issues. For
> > +               other filesystems additional patches and fixes to the test suite
> > +               might be needed.
> >               - if SCRATCH_LOGDEV and/or SCRATCH_RTDEV, the USE_EXTERNAL
> >                 environment variable set to "yes" will enable their use.
> >               - setenv DIFF_LENGTH "number of diff lines to print from a failed test",
> > diff --git a/README.overlay b/README.overlay
> > index 39e25ada..ec4671c3 100644
> > --- a/README.overlay
> > +++ b/README.overlay
> > @@ -31,7 +31,8 @@ partly supported with './check -overlay'. Only multi-section files that
> >  do not change FSTYP and MKFS_OPTIONS can be safely used with -overlay.
> >
> >  For example, the following multi-section config file can be used to
> > -run overlay tests on the same base fs, but with different mount options:
> > +run overlay tests on the same base fs, but with different mount options, and on
> > +top of idmapped mounts:
> >
> >   [xfs]
> >   TEST_DEV=/dev/sda5
> > @@ -46,6 +47,9 @@ run overlay tests on the same base fs, but with different mount options:
> >   OVERLAY_MOUNT_OPTIONS="-o redirect_dir=off"
> >   OVERLAY_FSCK_OPTIONS="-n -o redirect_dir=off"
> >
> > + [idmapped]
> > + IDMAPPED_MOUNTS=true
> > +
> >  In the example above, MOUNT_OPTIONS will be used to mount the base scratch fs,
> >  TEST_FS_MOUNT_OPTS will be used to mount the base test fs,
> >  OVERLAY_MOUNT_OPTIONS will be used to mount both test and scratch overlay and
> > diff --git a/common/config b/common/config
> > index 479e50d1..1033b890 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -647,6 +647,7 @@ _overlay_config_override()
> >         # Set fsck options, use default if user not set directly.
> >         export FSCK_OPTIONS="$OVERLAY_FSCK_OPTIONS"
> >         [ -z "$FSCK_OPTIONS" ] && _fsck_opts
> > +       export IDMAPPED_MOUNTS="$IDMAPPED_MOUNTS"
> 
> This line has no purpose here.
> 
> It does not matter yet because overlayfs mount itself cannot be idmapped
> so there is no need to test idmapped overlayfs mount, but if you did want
> to allow that, the code would need to look like this:
> 
> export OVL_BASE_IDMAPPED_MOUNTS="$IDMAPPED_MOUNTS"
> export IDMAPPED_MOUNTS="$OVERLAY_IDMAPPED_MOUNTS"
> 
> and in _overlay_config_restore:
> 
> [ -z "$OVL_BASE_IDMAPPED_MOUNTS" ] || \
>     export IDMAPPED_MOUNTS=$OVL_BASE_IDMAPPED_MOUNTS
> 
> Then, code dealing with idmapped layers would check the variable
> OVL_BASE_IDMAPPED_MOUNTS and code dealing with idmapped
> overlayfs mount would check the generic variable IDMAPPED_MOUNTS.
> 
> In the config file there would be two possible config vars:
> OVERLAY_IDMAPPED_MOUNTS - use idmapped overlayfs mount
> IDMAPPED_MOUNTS - use idmapped overlayfs layers
> 
> Same as the roles of OVERLAY_MOUNT_OPTIONS and
> MOUNT_OPTIONS that are documented in README.overlay.
> 
> P.S. the implementation of OVERLAY_FSCK_OPTIONS seems a bit
> broken (no restore), but fsck.overlay tool is not very alive, so probably

I tried to find installation candiates but for the distro I'm using it's
not available as a package.

> nobody is using this feature.
> 
> Bottom line, I do not know if and when you intend to add support for
> idmapped overlayfs mounts, until then, there is no action item.
> Unless you want to follow my instructions and use
> OVL_BASE_IDMAPPED_MOUNTS semantics already to make the
> code a bit more clear. I leave the decision to you or to the maintainer.
> Just wanted to put this on record.

Noted.
