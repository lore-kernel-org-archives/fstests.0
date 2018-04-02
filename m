Received: from imap.thunk.org ([74.207.234.97]:52054 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753980AbeDBBPv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 1 Apr 2018 21:15:51 -0400
Date: Sun, 1 Apr 2018 21:15:47 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 2/2] test-appliance: add virtfs/9p test configs
Message-ID: <20180402011547.GA31157@thunk.org>
References: <20180330021040.23748-1-eguan@linux.alibaba.com>
 <20180330021040.23748-2-eguan@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330021040.23748-2-eguan@linux.alibaba.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@linux.alibaba.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 30, 2018 at 10:10:40AM +0800, Eryu Guan wrote:
> Currently virtfs/9p has only one default config file, with tests in
> clone group excluded.
> 
> Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>

Thanks, I've applied both of your patches to the xfstest-bld repo.

	     	     	     	  - Ted
