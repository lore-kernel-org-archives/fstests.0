Received: from bombadil.infradead.org ([65.50.211.133]:50533 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbeAVUVo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Jan 2018 15:21:44 -0500
Date: Mon, 22 Jan 2018 12:21:43 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/8] fsstress: Include stddef.h for ptrdiff_t
Message-ID: <20180122202143.GA16776@infradead.org>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
 <1516636639-9107-2-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516636639-9107-2-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 22, 2018 at 03:57:12PM +0000, Rostislav Skudnov wrote:
> In musl C library headers ptrdiff_t is only defined in stddef.h.
> 
> Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
