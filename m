Received: from bombadil.infradead.org ([65.50.211.133]:33521 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbeAWHoN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 Jan 2018 02:44:13 -0500
Date: Mon, 22 Jan 2018 23:44:12 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 6/8] fssum: Use bswap_64() instead of __bswap_64()
Message-ID: <20180123074412.GA26914@infradead.org>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
 <1516636639-9107-7-git-send-email-rostislav@tuxera.com>
 <20180122202620.GF16776@infradead.org>
 <BDC32FA7-9CC0-42A2-9D59-43C9F7FAF5C4@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BDC32FA7-9CC0-42A2-9D59-43C9F7FAF5C4@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav <rostislav@tuxera.com>
Cc: Christoph Hellwig <hch@infradead.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 23, 2018 at 09:36:15AM +0200, Rostislav wrote:
> Thanks for your feedback! We can of course use htobe64(), but the file
> src/fssum.c already defines htonll() in a way that takes endianness into
> account, and using htobe64() would be equivalent to htonll(). My strategy when
> writing this patch set was to make the least number of modifications required
> to build with musl libc.

And normally our strategy in maintaining xfs related code is to do the
right thing even if it is a little more invasive.  Using htobe64 would
be the choice based on that.
