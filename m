Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2A4C07E95
	for <linux-fstests@archiver.kernel.org>; Sun,  4 Jul 2021 22:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB12613E5
	for <linux-fstests@archiver.kernel.org>; Sun,  4 Jul 2021 22:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhGDWIO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 4 Jul 2021 18:08:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47734 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229652AbhGDWIO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 4 Jul 2021 18:08:14 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 164M5UZR016998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 4 Jul 2021 18:05:31 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7C58215C3C91; Sun,  4 Jul 2021 18:05:30 -0400 (EDT)
Date:   Sun, 4 Jul 2021 18:05:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, Leah Rumancik <leah.rumancik@gmail.com>
Subject: Re: [PATCH] ext4/048: skip test of filename wipe if journal
 checkpoint is not supported
Message-ID: <YOIwqn1jPBSyXIwd@mit.edu>
References: <20210621164851.1808923-1-tytso@mit.edu>
 <YOGRukqZFQTb36MS@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOGRukqZFQTb36MS@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Jul 04, 2021 at 06:47:22PM +0800, Eryu Guan wrote:
> 
> I think that depends on if we treat it as a feature or a bugfix. We
> should let the test fail on old kernels if that's a bugfix, and skip the
> test if it's a feature. Apparently, we take it as a feature here.

Yes, it's clearly a feature.

> > feature, and landed just a little bit after filename wipe feature, so
> > use support for the journal checkpoint ioctl as a proxy for support
> > for the filename wipe feature.
> 
> This seems fragile, they're related features but not always bounded
> together, I think it's possible for distros developers decide to
> backport only one of the features (though quite unlikely).

Given the discussion for the patches, I suspect that it will be only
the distros that are meant for Cloud environments (e.g., Google's COS,
maybe Amazon Linux, etc.) that will be interested at all in the first
place --- and if they do, they'll want to take both of them.

That's because it's only in a Cluod environment we can make specific
guarantees about how discard works, and it's mostly in a Cloud
environment where you have customers which appear to be the most
concerned about being able to certify to their auditors that PII can
be reliably wiped after they "lift and shift" from their private data
centers to third-party operated hyperscale Cloud providers.

> Is it worth to introduce features sysfs entry for journal checkpoint and
> filename wipe in ext4? In fstests' point of view, it's great to have
> such entries that could be checked. If it's not worth it, I think the
> "feature proxy" way is acceptable, given that the two features are
> closely related and aimed to the same security issue.

Well, we didn't when the patch first landed, so even if we did add the
features sysfs file, there's no guarantee that distros doing the
backport will pick up the patch to add the features file.  The sysfs
files do take up a few hundred bytes each, and so there is some
resistance in adding a lot of sysfs features, saving them for major
features.

For better or for worse, one of the principles of sysfs is to _not_
require any parsing, such that something like /proc/stat would have to
be replaced by something like individual 1,000+ sysfs files (try
running wc -w /proc/stat), depending on how cpu cores and interrupt
channels the system has.

This is why we are using separate sysfs files for each feature,
instead of a /proc file containing a list of features which fstests
could test by checking the exit status of "grep ^feature_name$
/proc/fs/ext4/feature-list".  But in retrospect, maybe we should have
gone down that path, since adding features to a feature-list
pseudo-file is essentially free, and would make life much more
convenient for fstests --- right now we do a lot of "create a scratch
file system; try to mount it and see if it succeed or fails, which is
a lot of needless church and extra write cycles on the test device,
and takes more time than just running "grep" on a festure-list file.

Alas, sysfs was considered the new hotness, and the superior approach,
while /proc was considered the legacy, hacky approach.  Ah, well...

Cheers,

						- Ted
