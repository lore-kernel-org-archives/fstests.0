Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0B1C4332F
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Nov 2022 16:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiKGQfc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Nov 2022 11:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiKGQfc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Nov 2022 11:35:32 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FBAC20
        for <fstests@vger.kernel.org>; Mon,  7 Nov 2022 08:35:29 -0800 (PST)
Received: from letrec.thunk.org ([12.146.29.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2A7GZGXf018629
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Nov 2022 11:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1667838918; bh=FWtLEQYTWbEFsVEz+Z12WMUQDM6DCNUd7J0FJcZqjTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NzB/tZdI/CW7DEEdsrvL3hJWFEDgQ69PQ1MHvx0Tfpr4uf8sY/L5r2cKz+dWT4cEC
         Usizf8IBGqsxq8MMG8mShdRY9EvlQkgfMkUD60sXu6W7v5YpIcI2cyY3kTHEZBfdZt
         PSj/902SxqYu3gshciaxdy3Lpd4fRVcPLGIVt2b0C8D7tL+MAHrmyTdm7Kkr8rIOrV
         FG3p1kl/yZ2gyH7OP2R6gbUwpsEfF6ZQTTIzJIshtKGwxPAFgwrYjOIYKuv6ThHw2T
         RS744WRQ3LOaG3Ld5RVD7m2CbZpOzVMlAZ7i6+U0YFx06/X0gfORor5zs3ewC+kddH
         SnAyDS11A0nCw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 220F18C00D2; Mon,  7 Nov 2022 11:35:16 -0500 (EST)
Date:   Mon, 7 Nov 2022 11:35:16 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: Re: [PATCH] generic: add missing $FSX_AVOID to fsx invocations
Message-ID: <Y2kzxKnYf8CLj49v@mit.edu>
References: <20221105182918.24099-1-tytso@mit.edu>
 <20221106121031.ywrlqu6w54kgnn2i@zlang-mailbox>
 <Y2gqpYhf5n8Y43eZ@mit.edu>
 <20221107020236.gdlmb5hxsaxxislo@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107020236.gdlmb5hxsaxxislo@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Nov 07, 2022 at 10:02:36AM +0800, Zorro Lang wrote:
> I think it doesn't make sense to use $FSX_AVOID in `fsx --replay-ops` cases.
> Due to generally the operations which a cases would like to replay are exact
> steps to reproduce to a known bug. If we skip some operations (e.g. -F), it
> doesn't make sense for this reproducer.
> 
> The recommended way for this kind of cases is making sure current fs/system
> support the operations will be run by fsx, especially those features are not
> common on different fs/system....
>
> So it uses below _require_* helpers to make sure these operations are supported,
> before testing:
> 
>   _require_xfs_io_command "falloc"
>   _require_xfs_io_command "falloc" "-k"
>   _require_xfs_io_command "fzero"
>   _require_xfs_io_command "fcollapse"
> 
> That's my point, hope I didn't misunderstand what you said :)

No, you didn't understand me.  :-)

For context, I have an out of tree patch (see attached), which I had
tried upstreaming a while back, but it got rejected, so I've continued
to keep it in my personal tree.  The basic idea is sometimes you might
want to suppress a test even *though* _require_xfs_io_command seems to
indicate that operation was supported.

This might either be because the test didn't know about ext4
bigalloc's cluster alignment requirements, or because a particular
operation might just be *buggy* and being able to run tests as if a
particular command wasn't supported was useful.

It was rejected because the claim was that you could just exclude by
group instead (e.g., "punch", "collapse") but I didn't trust that the
group list would be kept up to date, so I never really agreed with
that line of reasoning.  These days, given that group declaration are
kept in the test script, it's much less likely to happen, but I've
kept the patch in my tree because it's occasionally useful.

At this point, it's admittedly pretty rarely needed since ext4's
collapse and insert range commands are pretty solid modulo tests not
understanding cluster alignment, but still, it's not much effort for
me to keep carrying the patch and I don't expect it will ever get
upstreamed.

					- Ted

commit c9d25475a94d5e53d7f18d247a17088999522862
Author: Theodore Ts'o <tytso@mit.edu>
Date:   Sat Oct 17 14:39:26 2015 -0400

    common: introduce XFS_IO_AVOID env var
    
    Like FSSTRESS_AVOID and FSX_AVOID, XFS_IO_AVOID can be used to avoid
    using various advanced file system features such as "fpunch"
    "fcollapse", "finsert", or "zero".  Tests that require an xfs_io
    command which is included in the space-separated list found in the
    XFS_IO_AVOID environment variable will be skipped using _notrun.
    
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/README b/README
index 4c4f22f85..42baff07b 100644
--- a/README
+++ b/README
@@ -245,6 +245,10 @@ Misc:
    this option is supported for all filesystems currently only -overlay is
    expected to run without issues. For other filesystems additional patches
    and fixes to the test suite might be needed.
+ - setenv XFS_IO_AVOID, which may contain a list of space separated
+   xfs_io commands which will be avoided in case you want to exclude
+   tests that require the use of certain file system operations such
+   as "fpunch", "fcollapse", "finsert", or "zero".
 
 ______________________
 USING THE FSQA SUITE
diff --git a/common/rc b/common/rc
index eb67e0cdc..d1c07a4d0 100644
--- a/common/rc
+++ b/common/rc
@@ -2485,6 +2485,11 @@ _require_xfs_io_command()
 	local opts=""
 	local attr_info=""
 
+	if echo "$XFS_IO_AVOID" | grep -wq -- "$command"
+	then
+		_notrun "Avoiding xfs_io $command"
+	fi
+
 	local testfile=$TEST_DIR/$$.xfs_io
 	local testio
 	case $command in
