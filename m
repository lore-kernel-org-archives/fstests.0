Received: from verein.lst.de ([213.95.11.211]:47035 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752952AbdBCJ4I (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Feb 2017 04:56:08 -0500
Date: Fri, 3 Feb 2017 10:56:06 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] generic/407: check that destination timestamps are
        updated on clone
Message-ID: <20170203095606.GA28569@lst.de>
References: <20170202162755.21101-1-hch@lst.de> <CAOQ4uxiPdAvGe7LT9OtvGJrXozxtTxQi_iDU--y_9aPUTsSkaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiPdAvGe7LT9OtvGJrXozxtTxQi_iDU--y_9aPUTsSkaA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

> Although this may be nit picking, why 2 seconds?

Copied from a test that did it, 1 is enough though.
