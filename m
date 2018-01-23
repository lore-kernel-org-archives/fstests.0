Received: from bombadil.infradead.org ([65.50.211.133]:38375 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeAWLVp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 Jan 2018 06:21:45 -0500
Date: Tue, 23 Jan 2018 03:21:44 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 6/8] fssum: Use htobe64() instead of a custom macro
Message-ID: <20180123112144.GA6222@infradead.org>
References: <20180123074412.GA26914@infradead.org>
 <1516694898-16458-1-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516694898-16458-1-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: hch@infradead.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
