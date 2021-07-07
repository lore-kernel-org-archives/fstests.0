Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DBBC07E95
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 22:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B5D61CCA
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 22:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhGGWmz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Jul 2021 18:42:55 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46279 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230106AbhGGWmz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jul 2021 18:42:55 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 167Me6Zg025827
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Jul 2021 18:40:06 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EC4E815C3CC6; Wed,  7 Jul 2021 18:40:05 -0400 (EDT)
Date:   Wed, 7 Jul 2021 18:40:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Pavel Reichl <preichl@redhat.com>, fstests@vger.kernel.org,
        shreeya.patel@collabora.com
Subject: Re: [PATCH 1/1] generic/453: Do NOT run for FSs restricting names
Message-ID: <YOYtRXrc5EdOqcHp@mit.edu>
References: <20210707102007.66774-1-preichl@redhat.com>
 <20210707102007.66774-2-preichl@redhat.com>
 <20210707145158.GC11571@locust>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707145158.GC11571@locust>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 07, 2021 at 07:51:58AM -0700, Darrick J. Wong wrote:
> # Skip this test unless the filesystem treats names (directory entries,
> # fs labels, and extended attribute names) as raw byte sequences.
> 
> > +        case "$FSTYP" in
> > +        ext2|ext3|ext4|xfs|btrfs)
> 
> Does this need to _notrun ext4 filesystems that have casefolding
> enabled?  (Or: should we let the ext4 developers figure that out?)

Casefolding has to be enabled on the file system level (mkfs.ext4 -O
casefold) but also on a per-directory level (by setting the casefold
flag).  Otherwise, unrestricted byte streams are allowed for file
names.  Since generic/453 doesn't set the casefold flag, this tests
passes even when the scratch mount options include casefolding.

The generic/556 test will test casefolding.

BTW, we should probably include f2fs as a file system which normally
allow unrestricted byte streams.  F2fs also supports casefolding, but
again, like ext4, it's only enabled when the per-directory casefold
flag is enabled.  So:

+        case "$FSTYP" in
+        ext2|ext3|ext4|f2fs|xfs|btrfs)

I've verified that generic/453 passes on f2fs today.

				- Ted
