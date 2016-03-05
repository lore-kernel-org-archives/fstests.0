Received: from bombadil.infradead.org ([198.137.202.9]:56939 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbcCEUpS (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sat, 5 Mar 2016 15:45:18 -0500
Date: Sat, 5 Mar 2016 12:45:17 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] xfs/259: disable CRC if testing with 512 bytes block size
Message-ID: <20160305204517.GA10065@infradead.org>
References: <1456937518-20505-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456937518-20505-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

This will force crcs off for all the blocksizes.  We should
either always skip 512 bytes, or disable crcs only for the 512 byte
inode size case.  The first seems either, but the second would give
better test coverage.
