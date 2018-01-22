Received: from bombadil.infradead.org ([65.50.211.133]:42791 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeAVUYH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Jan 2018 15:24:07 -0500
Date: Mon, 22 Jan 2018 12:24:06 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 4/8] metaperf: Include linux/param.h explicitly for HZ
 macro
Message-ID: <20180122202406.GD16776@infradead.org>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
 <1516636639-9107-5-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516636639-9107-5-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 22, 2018 at 03:57:15PM +0000, Rostislav Skudnov wrote:
> Glibc includes linux/param.h when we include sys/param.h, whereas musl
> libc does not do that. HZ is a Linux-specific macro, therefore include
> the header file that defines it explicitly.
> 
> Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>

Using HZ in userspace doesn't make any sense at all.  The kernel HZ
(as in the granulairy for jiffies) can vary between architectures
and even configurations.  I guess it wants a hard coded 100 here, but
someone will have to do a detailed analysis.
