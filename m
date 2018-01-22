Received: from bombadil.infradead.org ([65.50.211.133]:34853 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751060AbeAVUYh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Jan 2018 15:24:37 -0500
Date: Mon, 22 Jan 2018 12:24:36 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 5/8] dmiperf: Include sys/types.h for u_int32_t
Message-ID: <20180122202436.GE16776@infradead.org>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
 <1516636639-9107-6-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516636639-9107-6-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 22, 2018 at 03:57:16PM +0000, Rostislav Skudnov wrote:
> u_int32_t type is defined in sys/types.h, which is often included by
> glibc implicitly when some other headers are used, but other C libraries
> such as musl may not necessarily do so, therefore an explicit include is
> needed.
> 
> Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

(alternatively we could switch to uint*_t types for consistency)
