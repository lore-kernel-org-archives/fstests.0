Received: from bombadil.infradead.org ([65.50.211.133]:57169 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbeAVU0h (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Jan 2018 15:26:37 -0500
Date: Mon, 22 Jan 2018 12:26:37 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 7/8] t_mtab: Replace sys_siglist[] with strsignal()
Message-ID: <20180122202637.GG16776@infradead.org>
References: <1516636639-9107-1-git-send-email-rostislav@tuxera.com>
 <1516636639-9107-8-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516636639-9107-8-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 22, 2018 at 03:57:18PM +0000, Rostislav Skudnov wrote:
> strsignal(3) says that strsignal() should be used instead of
> sys_siglist[].
> 
> Signed-off-by: Rostislav Skudnov <rostislav@tuxera.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
