Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A43C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Dec 2021 20:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhLTUjb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Dec 2021 15:39:31 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55299 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229664AbhLTUja (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Dec 2021 15:39:30 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BKKdLbw023933
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Dec 2021 15:39:21 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3BCA915C33A4; Mon, 20 Dec 2021 15:39:21 -0500 (EST)
Date:   Mon, 20 Dec 2021 15:39:21 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] ext4/033: remove a portion of the test assuming
 resize2fs would fail
Message-ID: <YcDp+SLrwqUNBox4@mit.edu>
References: <20211215035409.244674-1-tytso@mit.edu>
 <Yb9M3aIb9cJGIJaB@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yb9M3aIb9cJGIJaB@desktop>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Dec 19, 2021 at 11:16:45PM +0800, Eryu Guan wrote:
> 
> This portion of test is the key of the original regression test, if
> we're going to remove this part, does it make sense to remove ext4/033
> completely?

Hmm, good point.  It's nice to keep the regression test around, but we
can't use resize2fs to test the kernel's online resize code directly.
We can fix this by creating test program to execute the ioctl
directly.   Revised patch coming....

							- Ted
