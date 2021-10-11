Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F02FC433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 14:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3395660E98
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Oct 2021 14:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238344AbhJKOix (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:38:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60252 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237686AbhJKOix (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Oct 2021 10:38:53 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19BEaY2G009494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 10:36:34 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3C1FF15C00CA; Mon, 11 Oct 2021 10:36:34 -0400 (EDT)
Date:   Mon, 11 Oct 2021 10:36:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>
Cc:     fstests@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Zorro Lang <zlang@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] generic/095: don't use 1k blocksize for DIO operations
Message-ID: <YWRL8pftnuS/iASr@mit.edu>
References: <20211011135504.23328-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211011135504.23328-1-lhenriques@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 11, 2021 at 02:55:04PM +0100, Luís Henriques wrote:
> This test fails when using zram because it's using bs=1k for DIO in fio
> jobs.  Fix the test by using _min_dio_alignment instead to get the correct
> blocksize.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>

I'd suggest using the commit summary:

generic/095: align DIO read/writes with the supported sector size for the device

It might also be worth noting that generic/095 would have been failing
not just for zram, but if run on other hardware devices that might
have a logical sector size > 1k --- e.g., advanced format HDD's with
4k sectors, DASD's on mainframes with 2k sectors, etc.

Note: this change will cause the fio stress workload to do its DIO
operations using a block size of 512, which I think is fine for this
test.  (There might be other tests which are making assumptions about
the supported DIO alignment of the scratch device where adjusting the
test might be more complicated; fortunately, this doesn't appear to be
one of them.)

Other than changes to the commit description, feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Thanks,

					- Ted
