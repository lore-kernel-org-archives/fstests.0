Received: from bombadil.infradead.org ([65.50.211.133]:54995 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752952AbdBCJ6p (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Feb 2017 04:58:45 -0500
Received: from 80-109-146-114.cable.dynamic.surfer.at ([80.109.146.114] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1cZadg-0007oo-GR
        for fstests@vger.kernel.org; Fri, 03 Feb 2017 09:58:44 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: clone/dedup timestamp tests V2
Date: Fri,  3 Feb 2017 10:58:37 +0100
Message-Id: <20170203095839.8007-1-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

A few fixes to the new 407 test compared to the previous one: only
sleep one second and clean up the test files properly.

A second test for the dedupe timestamps.  While both tests are prretty
trivial the feature checks are different, so we need two.

