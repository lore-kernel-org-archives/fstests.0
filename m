Received: from imap.thunk.org ([74.207.234.97]:59124 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752368AbeARB2g (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 17 Jan 2018 20:28:36 -0500
Date: Wed, 17 Jan 2018 20:28:31 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: ext4 quota tests fail with CONFIG_QFMT_V2=n
Message-ID: <20180118012831.GF6948@thunk.org>
References: <20180118010936.GA10649@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180118010936.GA10649@vader>
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>
Cc: fstests@vger.kernel.org, Jan Kara <jack@suse.cz>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jan 17, 2018 at 05:09:36PM -0800, Omar Sandoval wrote:
> Hello,
> 
> If I run xfstests on ext4 with a kernel with CONFIG_QFMT_V2=n, the following
> tests fail:
> 
> generic/082
> generic/219
> generic/230
> generic/231
> generic/232
> generic/233
> generic/234
> generic/235
> generic/244
> generic/270
> generic/382
> 
> Would it be possible to handle this case and skip the test instead?

I'd like to ask a different question, which is there a reason to
support CONFIG_QFMT_V1 && !CONFIG_QFMT_V2?  Maybe we should just
always enable CONFIG_QFMT_V2, and simplify the test matrix?

       	      		      	  	       	    - Ted
