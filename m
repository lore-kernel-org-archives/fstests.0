Received: from bombadil.infradead.org ([65.50.211.133]:55691 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeAVUWF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Jan 2018 15:22:05 -0500
Date: Mon, 22 Jan 2018 12:22:04 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/8] Replace all __[u]intNN_t types with standard
 [u]intNN_t
Message-ID: <20180122202204.GB16776@infradead.org>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
 <1516636639-9107-3-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516636639-9107-3-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 22, 2018 at 03:57:13PM +0000, Rostislav Skudnov wrote:
> Integer types such as __uint32_t are non-standard and not supported by
> some C libraries such as musl. This commit replaces them with standard
> types such as uint32_t and includes stdint.h header where necessary.
> 
> The following command was used to do the changing of types:
> sed -r -i 's/__(u?int[0-9]{2}_t)/\1/g' src/*.c ltp/*.c

Looks good nad matches what we've done to the kernel and xfsprogs:

Reviewed-by: Christoph Hellwig <hch@lst.de>
