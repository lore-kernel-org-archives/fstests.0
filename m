Received: from bombadil.infradead.org ([198.137.202.9]:51396 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161084AbcFHSRh (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 8 Jun 2016 14:17:37 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: a small fix for two reflink testcases
Date: Wed,  8 Jun 2016 20:17:30 +0200
Message-Id: <1465409851-27969-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

This is a fun one, I found it because the tests as-is cause a weird
silly rename bug on nfs, but when debugging it I found that the
bigfile. file probably shouldn't exist.  Oddly enough not creating
it makes the bug that is about unlinking another file go away..

