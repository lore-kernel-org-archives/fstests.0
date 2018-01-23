Received: from mx1.mpynet.fi ([82.197.21.84]:54250 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750907AbeAWHgR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 23 Jan 2018 02:36:17 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 6/8] fssum: Use bswap_64() instead of __bswap_64()
From: Rostislav <rostislav@tuxera.com>
In-Reply-To: <20180122202620.GF16776@infradead.org>
Date: Tue, 23 Jan 2018 09:36:15 +0200
Content-Transfer-Encoding: 8BIT
Message-ID: <BDC32FA7-9CC0-42A2-9D59-43C9F7FAF5C4@tuxera.com>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com> <1516636639-9107-7-git-send-email-rostislav@tuxera.com> <20180122202620.GF16776@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


> On Jan 22, 2018, at 10:26 PM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Mon, Jan 22, 2018 at 03:57:17PM +0000, Rostislav Skudnov wrote:
>> Macros and functions starting with two underscores are usually internal
>> and shouldn't be used by applications when a version without "__" is
>> available.
>> 
>> Include byteswap.h explicitly since bswap_64() is defined there.
> 
> Shouldn't this use htobe64 instead?

Hello, Cristoph.

Thanks for your feedback! We can of course use htobe64(), but the file
src/fssum.c already defines htonll() in a way that takes endianness into
account, and using htobe64() would be equivalent to htonll(). My strategy when
writing this patch set was to make the least number of modifications required
to build with musl libc.