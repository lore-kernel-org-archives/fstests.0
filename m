Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59434C433EF
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Jun 2022 16:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiFYQje (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 25 Jun 2022 12:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiFYQje (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 25 Jun 2022 12:39:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D86140DE
        for <fstests@vger.kernel.org>; Sat, 25 Jun 2022 09:39:32 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25PGdRkf030400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Jun 2022 12:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656175168; bh=24IKZ8XS/s9rApBg7Bkpmbq0/rO6CiZ9JM+0QKp38dk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=h9J8iK9kosWVXYO6KWNMDjcOJa3aVcCyCVND1cYuApNTYZF0Skk3TLFG2TBKCf4Bw
         s16szwUtuwxCNy6ak6W+2cCxCotVcUGTUfkGs5Bf4Ka0ZC6j51u50v2dz7s6b/58mQ
         ybTdYItqRrKOhHl7f7wZzcGlXDQN5ys5jEGrICbAV1bfeBJ4nxTlDe0TOG3/ZuRbGg
         YNNrDx7TJnTS/2e3LaDKpEBC4mFGhIelc6/OvTi3EH6JGIkk/fJ0QYxY0BoMtl/lCo
         svzyOb+sLlizqPfXgCz9E1S1aK5pYDDHUDPD4WBiesFVDLNq3khdICZ6PhQaPRzj+u
         Ds0T5j2WETLPQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 43FD915C42F6; Sat, 25 Jun 2022 12:39:27 -0400 (EDT)
Date:   Sat, 25 Jun 2022 12:39:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     An Long <lan@suse.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/config: Fix use of MKFS_OPTIONS
Message-ID: <Yrc6Pz67mL56ML6j@mit.edu>
References: <20220623160825.31788-1-lan@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623160825.31788-1-lan@suse.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 24, 2022 at 12:08:25AM +0800, An Long wrote:
>  
> +# check the size value in $MKFS_OPTIONS is an integer
> +if [[ $MKFS_OPTIONS =~ [0-9]+[^0-9\ ] ]] ; then
> +        _fatal "error: \$MKFS_OPTIONS: Only number in bytes is allowed, no units."
> +fi

This will break configs, since ext4 has a feature 64bit, so there
might be MKFS_OPTIONS that contain "-O 64bit", or "-O ^64bit".

For that matter, this wll also break things like "-E encoding=12.1"
which sets the Unicode encoding to 12.1.

... or "-E lazy_itable_init=1,lazy_journal_init=1".

Bottom line, blindly assuming that any number followed by a non-number
is a unit, is just not going to work.

I think the real problem is that we have fstests trying to parse
MKFS_OPTIONS at all in the first place.  For that matter, I'm not fond
of tests that try to override MKFS_OPTIONS for their own nefarious
purposes, because sometimes certain MKFS_OPTIONS imply something about
what must be in MOUNT_OPTIONS, or vice versa.  I do understand why
that has to be done for certain tests, but... yelch.  Especially in
centralized functions like _scratch_mkfs_sized, it just leads to tech
debt.

I'll note that generic tests and functions in common/rc that do unholy
things with MKFS_OPTIONS already have to have per-file system hacks as
it is.  So having more per-file system hacks for check_block_options()
is par for the course, so long as we accept that we want to have
generic tests and generic code violate the abstraction barrier and try
to read or override MKFS_OPTIONS.

If we want to go down that approach, perhaps another approach would be
to specify the desired blocksize diretly in the fs config.  Something
like "FS_BLOCK_SIZE=1024"?  We can then have the fs-specific mkfs
commands translate that into the appropriate "-b 1024" or whatever
else might be appropriate for a particular file system.  And then
tests that want to override the block size can just override
FS_BLOCK_SIZE and then the _mkfs function can use it as appropriate.

(BTW, this has been less important for ext4, since we allow the block
size to be specified more than once, with the last option being the
one which controls.  So "mkfs.ext4 -b 4096 ... -b 1024 ..." is OK for
ext4, but it results in an error for mkfs.xfs.  Otherwise we could
probably solve this problem more easily.)

I know my proposed approach will require all of the fstests wrapers to
be changed, and may require auditing a lot of tests to see what
breaks.  But quite frankly, what we have write now with tests messing
with MKFS_OPTIONS is kind of a mess already, and if we're going to do
clean up the tech debt, it's going to requrie some pain.

Or we could use the suggestion of more per-fs case in a
_check_mkfs_options function.  Which is a bit ugly, but IMHO, not as
ugly as the existing hacks where we have generic code trying to mess
with MKFS_OPTIONS....

						- Ted
