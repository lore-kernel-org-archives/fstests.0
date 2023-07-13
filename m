Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2645DEB64DA
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Jul 2023 01:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjGMBox (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jul 2023 21:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjGMBox (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jul 2023 21:44:53 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477B9B0
        for <fstests@vger.kernel.org>; Wed, 12 Jul 2023 18:44:51 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-193.bstnma.fios.verizon.net [173.48.82.193])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36D1iZpd006604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 21:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689212677; bh=/hkWkSW3pXb33OC6NCVpZYodfIaqQbcTgPRnvHDQz54=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=DASbfZkXWkumSHY2Lv9YpLAMZwqXptiuIYzg0FtduBDeNh9vlW1DPeSyPSISfZhe0
         HI7F4bGdOuUz5T7m6gkEvSCTyoeKZV3hVs5V9EU3DfktKqtRfSDfN1O4KoHP3VGfk5
         w1aa2eGi+zZDiOgoPRwFeoUowzhpZk6wNvoN+k2elVteKNyvDpT6tPQ0HAaAzl7TtS
         YQWQJLV+CC0At9PHUf9mKxCtZOtUQ/sEsEgsFGUsVWdFbNDfbFb1nsLZ+be/wYpw6l
         97pakEJh16MdSGC4h0RU1XyGycVqWPQe4Ian0Ba4HMig2liYBvi38lGar1qLGuSf8F
         vENnzNeHG/wCQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2DD4915C0280; Wed, 12 Jul 2023 21:44:35 -0400 (EDT)
Date:   Wed, 12 Jul 2023 21:44:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Eryu Guan <eguan@redhat.com>, Zorro Lang <zlang@kernel.org>,
        fstests@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] generic/558: limit the number of spawned subprocesses
Message-ID: <20230713014435.GA3709197@mit.edu>
References: <2bb7705c-9a1a-6185-4554-9121e5cda710@redhat.com>
 <20230712184051.6hwpdtuzjkuvcj4f@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712184051.6hwpdtuzjkuvcj4f@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jul 13, 2023 at 02:40:51AM +0800, Zorro Lang wrote:
> The generic/558 was shared/006, it was written for specific fs (e.g. xfs), then
> shared with other similar localfs.
> 
> After we changed it to a generic test case, the `_scratch_mkfs_sized` helps to
> avoid running this case on nfs/cifs and any other fs which can't be mkfs sized.
> Originally we thought a fs has a small specific size generally has limited
> free inodes. It works for long time, but now bcachefs looks like an exception :)
> 
> I think we must limit the number of processes, then let each process create more
> files if it need more inodes, that helps to avoid the forkbomb problem, and helps
> this case to work with bcachefs and other fs have lots of free inodes in 1G space.
> 
> But we'd better to limit the number of free inodes too, we don't want to run this
> case too long time. If a fs shows too many free inodes, _notrun "The 1G $FSTYP has
> too many free inodes!".

Alternatively we could have some fs-specific code which uses a
different sized scratch file system depending on the file system.  So
for bcachefs, maybe it should only be, say, 1 MiB (or whatever the
smallest file system bcachefs can support).

This test is designed to test what happens when the file system is
filled 100% with inodes, to make sure the file system passes fsck at
100%, and then after deleting all of the inodes, the file system
should be self-consistent afterwards as well.  That's a pretty
straightforward test, and for a file system where inodes can be
anywhere and are variably sized, it's certainly a completely valid
thing to do.  And if it turns out that "too many free inodes", then
maybe the test should have some special case sizes for different file
systems.

	`				- Ted
