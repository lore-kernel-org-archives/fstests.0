Received: from bombadil.infradead.org ([65.50.211.133]:34861 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbeAVU0V (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Jan 2018 15:26:21 -0500
Date: Mon, 22 Jan 2018 12:26:20 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 6/8] fssum: Use bswap_64() instead of __bswap_64()
Message-ID: <20180122202620.GF16776@infradead.org>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
 <1516636639-9107-7-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516636639-9107-7-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 22, 2018 at 03:57:17PM +0000, Rostislav Skudnov wrote:
> Macros and functions starting with two underscores are usually internal
> and shouldn't be used by applications when a version without "__" is
> available.
> 
> Include byteswap.h explicitly since bswap_64() is defined there.

Shouldn't this use htobe64 instead?
