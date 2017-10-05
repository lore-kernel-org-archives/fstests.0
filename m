Received: from bombadil.infradead.org ([65.50.211.133]:38567 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbdJETss (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Oct 2017 15:48:48 -0400
Date: Thu, 5 Oct 2017 12:48:47 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/4] writev_on_pagefault: Use ssize_t type for write(2)
 return value
Message-ID: <20171005194847.GC21115@infradead.org>
References: <1507207800-5688-1-git-send-email-rostislav@tuxera.com>
 <1507207800-5688-2-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507207800-5688-2-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
