Return-Path: <fstests-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:58078 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbaGQJHP (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 17 Jul 2014 05:07:15 -0400
Date: Thu, 17 Jul 2014 02:07:14 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] xfs/007: add project quota Q_XQUOTRM test
Message-ID: <20140717090714.GA16015@infradead.org>
References: <53C73562.3010005@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53C73562.3010005@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Liu <jeff.liu@oracle.com>
Cc: fstests@vger.kernel.org, "xfs@oss.sgi.com" <xfs@oss.sgi.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 17, 2014 at 10:30:58AM +0800, Jeff Liu wrote:
> From: Jie Liu <jeff.liu@oracle.com>
> 
> Add test for project quota Q_XQUOTRM operations, this patch also
> update the golden output file to match the new output.

Changing the test to require crc filesystems seems like a bad idea.

I'd suggest to simply do two passes instead: the first one unchanged,
and the second one testing project instead of group quotas.

