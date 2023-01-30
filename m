Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C172C54EAA
	for <linux-fstests@archiver.kernel.org>; Mon, 30 Jan 2023 11:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbjA3LaR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 30 Jan 2023 06:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjA3L36 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Jan 2023 06:29:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDD94EFF
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2023 03:29:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 91A081FE2D;
        Mon, 30 Jan 2023 11:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675078194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=87RDXO60EhXJEuGXkDRc4r4426SxguKCNw8XvTw6QWY=;
        b=wx0/MTPfitCXGzvzcwm3wjok/KW8neV65mZXYMGIGFPx+TkgdI2aqju+Ug38u8bGujXZ29
        w8WD3KhzTnqbZtvlHUTePZlT1zzzAxf58Pu2E0FzrivrzGLTp7oEta7P379Y4SOwkIAa8R
        DD7xkORB2sf0HgnzFqCfvCautRhLihk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675078194;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=87RDXO60EhXJEuGXkDRc4r4426SxguKCNw8XvTw6QWY=;
        b=sbrJctNLt+GGfrwUUJmXQ7D5A7u6XTLZo986xhTtBAxex6nIVuG2mkUl1DsvHAeB8JWroa
        P8PlHQhZ4aEXdFDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 859FB13A06;
        Mon, 30 Jan 2023 11:29:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0UOXIDKq12MeJQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 30 Jan 2023 11:29:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 110C5A0778; Mon, 30 Jan 2023 12:29:54 +0100 (CET)
Date:   Mon, 30 Jan 2023 12:29:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/707: Test moving directory while being grown
Message-ID: <20230130112954.nswbfcekebaxsvxo@quack3>
References: <20230126151512.5438-1-jack@suse.cz>
 <20230130050018.5tta53zaxlhmlmy4@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130050018.5tta53zaxlhmlmy4@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon 30-01-23 13:00:18, Zorro Lang wrote:
> On Thu, Jan 26, 2023 at 04:15:12PM +0100, Jan Kara wrote:
> > Test how the filesystem can handle moving a directory to a different
> > directory (so that parent pointer gets updated) while it is grown. Ext4
> > and UDF had a bug where if the directory got converted to a different
> > type due to growth while rename is running, the filesystem got
> > corrupted.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  tests/generic/707     | 54 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/707.out |  2 ++
> >  2 files changed, 56 insertions(+)
> >  create mode 100755 tests/generic/707
> >  create mode 100644 tests/generic/707.out
> > 
> > diff --git a/tests/generic/707 b/tests/generic/707
> > new file mode 100755
> > index 000000000000..25cbb7e98a23
> > --- /dev/null
> > +++ b/tests/generic/707
> > @@ -0,0 +1,54 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2023 Jan Kara, SUSE Linux.  All Rights Reserved.
> > +#
> > +# FS QA Test 707
> > +#
> > +# This is a test verifying whether the filesystem can gracefully handle
> > +# modifying of a directory while it is being moved, in particular the cases
> > +# where directory format changes
> > +# 
> > +. ./common/preamble
> > +_begin_fstest auto
> > +
> > +_supported_fs generic
> > +_require_scratch
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +cd $SCRATCH_MNT
> 
> Is this necessary? Generally we use absolute path, e.g.
> 
> xxxfile=$SCRATCH_MNT/xxxxxxx
> touch $xxxfile

So here I can use absolute path without a problem.

> > +
> > +# Loop multiple times trying to hit the race
> > +loops=100
> > +files=500
> > +moves=500
> 
> You might would like to try LOAD_FACTOR or TIME_FACTOR parameters?

Will do.

> > +
> > +create_files()
> > +{
> > +	# We use slightly longer file name to make directory grow faster and
> > +	# hopefully convert between various types
> > +	for (( i = 0; i < $files; i++ )); do
> > +		touch somewhatlongerfilename$i
> > +	done
> > +}
> > +
> > +for (( i = 0; i <= $moves; i++ )); do
> > +	mkdir dir$i
> > +done
> > +
> > +for (( l = 0; l < $loops; l++ )); do
> > +	mkdir dir0/dir
> > +	pushd dir0/dir &>/dev/null
> 
> Use absolute path can help save the pushd&popd operations.

Not really. The thing is the background process needs to start inside the
directory that is being moved by the foreground process. Because the
absolute path constantly changes due to movement it is not really possible
to implement this without changing cwd.

> > +	create_files &
> 
> If there're background processes, we should deal with it in _cleanup() clearly.

Right, I'll add that. Thanks for review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
