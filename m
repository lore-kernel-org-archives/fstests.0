Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7480C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Jun 2022 10:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352195AbiFNKQh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Jun 2022 06:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352914AbiFNKQe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Jun 2022 06:16:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1311146CB3
        for <fstests@vger.kernel.org>; Tue, 14 Jun 2022 03:16:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96A0560AAD
        for <fstests@vger.kernel.org>; Tue, 14 Jun 2022 10:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972ACC3411B;
        Tue, 14 Jun 2022 10:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655201793;
        bh=YQtLsgwlT5nlNH/cHdIDp5gRk5Rx+mkXd14IkXTbXnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A8pq6ClYya43QMbWpBcr9WW8hJli2RH/8MD5C6zKHn7me+SPaSWMINMPzQzAima1c
         oBOHshLFYQ201nMXoGtu1He10EkqFM7OKZjTBOwLYB3fCsAvnSTM8Ed3wFmkHhDlRy
         jDzhm9xIMAMs1YULp6nxgERka4huuvE44SvLhonqYNbnNOxecnlMzQndmKNOmF6qWM
         BTjJ1/nt2FbDnNVx9YlYsMBFgO1vo0de6DY/5FdBKpXKgBYCItsSH/pgOzm3s3e/Km
         tkYCPJPYSMdijM6dAGrMFuOUDkpYiDyVDA3u9oWfl6aQNOnLET9VIIByLpPsNBw1bK
         eW4LYpOqzf3GQ==
Date:   Tue, 14 Jun 2022 12:16:28 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, Seth Forshee <sforshee@digitalocean.com>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH] generic/692: test group ownership change
Message-ID: <20220614101628.j7fckh3izpxt3ahp@wittgenstein>
References: <20220613152314.2235940-1-brauner@kernel.org>
 <20220614042516.a6eyaajeiyg6irbh@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220614042516.a6eyaajeiyg6irbh@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 14, 2022 at 12:25:16PM +0800, Zorro Lang wrote:
> On Mon, Jun 13, 2022 at 05:23:14PM +0200, Christian Brauner wrote:
> > When group ownership is changed a caller whose fsuid owns the inode can
> > change the group of the inode to any group they are a member of. When
> > searching through the caller's groups we failed to use the gid mapped
> > according to the idmapped mount otherwise we fail to change ownership.
> > Add a test for this.
> > 
> > Cc: Seth Forshee <sforshee@digitalocean.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > Cc: <fstests@vger.kernel.org>
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> 
> Thanks for this test, a few of small review points as below ...

Thanks for the review!

> 
> >  tests/generic/692     | 74 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/692.out |  3 ++
> >  2 files changed, 77 insertions(+)
> >  create mode 100755 tests/generic/692
> >  create mode 100644 tests/generic/692.out
> > 
> > diff --git a/tests/generic/692 b/tests/generic/692
> > new file mode 100755
> > index 00000000..825c836a
> > --- /dev/null
> > +++ b/tests/generic/692
> > @@ -0,0 +1,74 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 Christian Brauner (Microsoft).  All Rights Reserved.
> > +#
> > +# FS QA Test 692
> > +#
> > +# Test that users can changed group ownership of a file they own to a group
> > +# they are a member of.
> > +#
> > +# Regression test for commit:
> > +#
> > +# 263de29d8397 ("fs: account for group membership")
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick perms attr idmapped mount
> > +
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +	cd /
> > +	$UMOUNT_PROG $TEST_DIR/target-mnt
> 
> Do you need to filter out the errors by "2>/dev/null"?

Yeah, good idea.

> 
> > +	rm -r -f $tmp.*
> > +}
> > +
> > +# Import common functions.
> > +# . ./common/filter
> 
> I think you didn't use any filter, right? If so, this can be removed.

Removed.

> 
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
>      ^^^
> This line can be removed too.

Removed.

> 
> > +_supported_fs generic
> > +_require_test
> > +_require_chown
> > +_require_idmapped_mounts
> > +_require_user fsgqa
> > +_require_group fsgqa
> > +_require_group fsgqa2
> > +
> > +uqid=`id -u fsgqa`
> > +gqid=`id -g fsgqa`
> > +uqid2=`id -u fsgqa2`
> > +gqid2=`id -g fsgqa2`
> > +
> > +setup_tree()
> > +{
> > +	mkdir -p $TEST_DIR/source-mnt
> > +	chmod 0777 $TEST_DIR/source-mnt
> > +	touch $TEST_DIR/source-mnt/dir1
> > +	chown 65534:65534 $TEST_DIR/source-mnt
> > +	chown 65534:65535 $TEST_DIR/source-mnt/dir1
> > +
> > +	mkdir -p $TEST_DIR/target-mnt
> > +	chmod 0777 $TEST_DIR/target-mnt
> > +}
> > +
> > +setup_idmapped_mnt()
> > +{
> > +	$here/src/vfs/mount-idmapped \
> 
> You might need:
>   _require_test_program "vfs/mount-idmapped"
> 
> due to _require_idmapped_mounts doesn't guarantee that.

Yes, good point!

Thanks!
Christian
