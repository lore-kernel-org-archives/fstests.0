Received: from bombadil.infradead.org ([198.137.202.133]:42056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfBRJFM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Feb 2019 04:05:12 -0500
Received: from [88.128.83.71] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gverQ-0007Oz-2p
        for fstests@vger.kernel.org; Mon, 18 Feb 2019 09:05:12 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: two grouping tweaks
Date: Mon, 18 Feb 2019 10:05:01 +0100
Message-Id: <20190218090503.12034-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Remove two tests that don't dedup from the dedup group, and add
a new seek group.
