Received: from bombadil.infradead.org ([198.137.202.133]:47122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGFXe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jun 2019 01:23:34 -0400
Date: Thu, 6 Jun 2019 22:23:31 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/2] ext4/036: Add tests for filename casefolding
 feature
Message-ID: <20190607052331.GA19838@infradead.org>
References: <20190606193138.25852-1-krisman@collabora.com>
 <20190606193138.25852-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606193138.25852-2-krisman@collabora.com>
Sender: fstests-owner@vger.kernel.org
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Cc: tytso@mit.edu, fstests@vger.kernel.org, linux-ext4@vger.kernel.org, "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
List-ID: <fstests@vger.kernel.org>

On Thu, Jun 06, 2019 at 03:31:38PM -0400, Gabriel Krisman Bertazi wrote:
> From: "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
> 
> This new test implements verification for the per-directory
> case-insensitive feature, as supported in the reference implementation
> in Ext4.  Currently, this test only supports Ext4, but the plan is to
> run it in other filesystems, once they support the feature.
> 
> For now, let it live in ext4 and we move to shared/ or generic/ when
> other filesystems supporting this feature start to pop up.

Please keep it in shared/ from the start.  There isn't really anything
ext4 specific.  In fact xfs already supports CI file systems, just
without utf8 tables for now.
