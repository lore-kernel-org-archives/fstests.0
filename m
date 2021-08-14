Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1F8C4338F
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 10:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2955560F39
	for <linux-fstests@archiver.kernel.org>; Sat, 14 Aug 2021 10:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbhHNKOY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 14 Aug 2021 06:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229894AbhHNKOY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 14 Aug 2021 06:14:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1360E60F21;
        Sat, 14 Aug 2021 10:13:54 +0000 (UTC)
Date:   Sat, 14 Aug 2021 12:13:48 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>, fstests@vger.kernel.org,
        Eryu Guan <guan@eryu.me>
Subject: Re: [PATCH v3 2/8] idmapped-mounts: switch to getopt_long_only()
Message-ID: <20210814101348.3launiiy7z7o5ksg@wittgenstein>
References: <20210812160140.990229-1-brauner@kernel.org>
 <20210812160140.990229-3-brauner@kernel.org>
 <20210814084234.GB22637@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210814084234.GB22637@lst.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, Aug 14, 2021 at 10:42:34AM +0200, Christoph Hellwig wrote:
> > -	while ((ret = getopt_long(argc, argv, "", longopts, &index)) != -1) {
> > +	while ((ret = getopt_long_only(argc, argv, "d:f:m:sh", longopts, &index)) != -1) {
> 
> Hmm.  From the manpage:
> 
> "(If the program accepts only long options, then optstring should be specified
> as an  empty  string (""),  not  NULL.)"
> 
> So I think the empty opstring should remain.
> 
> Also later in the man page:
> 
> " getopt_long_only() is like getopt_long(), but '-' as well as "--" can
> indicate a long option."
> 
> So maybe my advise to switch to getopt_long_only wasn't needed or is
> even not that helpful.  Sorry, it's been a while since I wrote programs
> with non-trivial option parsing.

Nah, that's perfectly fine. I think the getopt_long_only() switch was
good. We don't anywhere use and shouldn't encourage using shortopts.
It's much more descriptive to see

$here/src/idmapped-mounts/idmapped-mounts \
	--test-btrfs \
	--device "$TEST_DEV" \
	--mountpoint "$TEST_DIR" \
	--scratch-device "$SCRATCH_DEV" \
	--scratch-mountpoint "$SCRATCH_MNT"
	--fstype "$FSTYP"

than it is to see e.g.:

$here/src/idmapped-mounts/idmapped-mounts \
	-b 
	-d "$TEST_DEV" \
	-m "$TEST_DIR" \
	-s "$SCRATCH_DEV" \
	-a "$SCRATCH_MNT" \
	-f "$FSTYP"

In the second case I have to go check the source code to make sure that
this is the correct option. In the first case I can just read it in the
test itself. So I think we'll keep it but I'll remove the option string
like you pointed out.

Christian
